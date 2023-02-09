import 'package:flutter_introduction/failure.dart';

enum ResultStatus {
  success,
  error,
}

class Result<T> {
  final ResultStatus status;
  final T? data;
  final Failure? failure;

  Result._({
    required this.status,
    this.data,
    this.failure,
  });

  factory Result.success(T data) {
    return Result._(
      status: ResultStatus.success,
      data: data,
    );
  }

  factory Result.failed(Failure failure) {
    return Result._(
      status: ResultStatus.error,
      failure: failure,
    );
  }

  bool isSuccess() => status == ResultStatus.success;
}
