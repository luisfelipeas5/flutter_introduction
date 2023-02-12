import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;

  const Movie({
    required this.title,
  });

  @override
  List<Object?> get props => [
        title,
      ];

  Movie copyWith({
    String? title,
  }) {
    return Movie(
      title: title ?? this.title,
    );
  }
}
