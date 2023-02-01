import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {}

class MovieChangeEvent extends MovieEvent {
  @override
  List<Object?> get props => [];
}
