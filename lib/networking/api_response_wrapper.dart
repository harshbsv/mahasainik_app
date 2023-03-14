import 'package:equatable/equatable.dart';
import 'package:mahasainik_app/error/app_exception.dart';
import 'package:mahasainik_app/networking/log_util.dart';

class ApiResponseWrapper<T> extends Equatable {
  ErrorModel? _error;
  T? _data;
  ExceptionHandler? _exceptionHandler;

  void setException(ExceptionHandler? error) {
    _exceptionHandler = error;
    _error = error?.getErrorModel();
    LogUtil().printBigLog(message: error?.getException()?.toString() ?? '');
  }

  void setErrorModel(ErrorModel? error) {
    _error = error;
    LogUtil().printBigLog(message: error?.errorMessage ?? '');
  }

  ApiResponseWrapper({T? data, ExceptionHandler? error})
      : _data = data,
        _error = error?.getErrorModel(),
        _exceptionHandler = error;

  // ignore: use_setters_to_change_properties
  void setData(T data) {
    _data = data;
  }

  T? get getData => _data;

  ErrorModel? get getException => _error;

  ExceptionHandler? get getAppException => _exceptionHandler;

  bool get hasException => _error != null;

  bool get hasData => _data != null;

  @override
  List<Object?> get props => [_data, _error];
}
