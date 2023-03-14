import 'package:mahasainik_app/error/app_error.dart';

/// Generic class for the states
abstract class ApiState<T> {
  final Status status;
  final T? data;
  final String? message;
  final AppError? error;

  ApiState.loading(this.message, {this.data, this.error})
      : status = Status.loading;

  ApiState.completed(this.data, {this.message, this.error})
      : status = Status.completed;

  ApiState.error(this.error, {this.data, this.message}) : status = Status.error;

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }
}

enum Status {
  loading,
  completed,
  error,
}
