import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_archi/core/error/failures.dart';
import 'package:flutter_clean_archi/core/usecases/usecase.dart';
import 'package:flutter_clean_archi/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_archi/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:meta/meta.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params>{
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async { //en appelant la méthode "call" on se permet de l'appeler directement avec le nom de la classe
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({@required this.number}) : super([number]);
}