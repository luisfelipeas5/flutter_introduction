import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {}

class MovieChangeEvent extends MovieEvent {
  final int index;

  MovieChangeEvent({
    required this.index,
  });

  @override
  List<Object?> get props => [
        index,
      ];
}
