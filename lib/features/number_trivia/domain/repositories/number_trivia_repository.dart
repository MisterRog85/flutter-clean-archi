import 'package:dartz/dartz.dart';
import 'package:flutter_clean_archi/core/error/failures.dart';
import 'package:flutter_clean_archi/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository { //abstract similaire protocol en Swift
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number); //either vient de dartz et permet de gérer les erreurs dans les futures plus facilement, en proposant deux types pour le retour
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}