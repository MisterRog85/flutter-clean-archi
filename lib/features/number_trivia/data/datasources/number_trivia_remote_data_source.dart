import 'package:flutter_clean_archi/features/number_trivia/data/models/number_trivia_model.dart';

abstract class  NumberTriviaRemoteDataSource {
  //avec trois slashs on fait de la doc
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}