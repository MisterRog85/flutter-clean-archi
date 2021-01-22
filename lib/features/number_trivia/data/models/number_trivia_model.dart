import 'package:flutter_clean_archi/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:meta/meta.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel ({
    @required String text,
    @required int number,
  }) : super(text: text, number: number); //super passe au constructeur de la classe parente

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(text: json['text'], number: (json['number'] as num).toInt());
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text, //référence au super
      'number': number, //référence au super
    };
  }
}