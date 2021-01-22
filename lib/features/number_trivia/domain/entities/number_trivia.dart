import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NumberTrivia extends Equatable {
  final String text;
  final int number;

  NumberTrivia({
    @required this.text, //@required disponible via meta
    @required this.number
  }) : super([text, number]); //super appel le constructeur de Equatable et passe la liste avec nos éléments
}
