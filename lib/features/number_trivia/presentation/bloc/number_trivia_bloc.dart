import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_archi/core/error/constants.dart';
import 'package:flutter_clean_archi/core/error/failures.dart';
import 'package:flutter_clean_archi/core/usecases/usecase.dart';
import 'package:flutter_clean_archi/core/util/input_converter.dart';
import 'package:flutter_clean_archi/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_archi/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_clean_archi/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:meta/meta.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required this.inputConverter
  }) :  assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither = inputConverter.stringToUnsignedInterger(event.numberString);
      yield* inputEither.fold( //yield* = yield each
          (failure) async* { //async* permet de générer des streams
            yield Error(message: INPUT_FAILURE_MESSAGE); //yield fait parti d'async* et permet d'émettre un message
          },
          (integer) async* {
            yield LoadingState();
            final failuerOrTrivia = await getConcreteNumberTrivia(Params(number: integer));
            yield* _eitherLoadedOrErrorState(failuerOrTrivia);
          },
      );
    } else if (event is GetTriviaForRandomNumber) {
      yield LoadingState();
      final failuerOrTrivia = await getRandomNumberTrivia(NoParams());
      yield* _eitherLoadedOrErrorState(failuerOrTrivia);
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(Either<Failure, NumberTrivia> failuerOrTrivia) async* {
    yield failuerOrTrivia.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (trivia) => Loaded(trivia: trivia),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch(failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpcted error';
    }
  }

  @override
  NumberTriviaState get initialState => Empty();
}
