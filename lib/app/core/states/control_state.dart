import 'package:equatable/equatable.dart';
import 'package:ufenergy/app/core/usecase/errors/failures.dart';

abstract class ControlState<Result extends Object> extends Equatable {
  TResult when<TResult extends Object>({
    required TResult initial(),
    required TResult loading(),
    required TResult success(Result? result),
    required TResult error(Failure failure),
  }) {
    return initial();
  }
}

class InitialState<Result extends Object> extends ControlState<Result> {
  InitialState();

  @override
  TResult when<TResult extends Object>({
    required TResult initial(),
    required TResult loading(),
    required TResult success(Result? result),
    required TResult error(Failure failure),
  }) {
    return initial();
  }

  @override
  List<Object?> get props => [];
}

class LoadingState<Result extends Object> extends ControlState<Result> {
  LoadingState();

  @override
  TResult when<TResult extends Object>({
    required TResult initial(),
    required TResult loading(),
    required TResult success(Result? result),
    required TResult error(Failure failure),
  }) {
    return loading();
  }

  @override
  List<Object?> get props => [];
}

class ErrorState<Result extends Object> extends ControlState<Result> {
  final Failure failure;
  ErrorState(this.failure);

  @override
  TResult when<TResult extends Object>({
    required TResult initial(),
    required TResult loading(),
    required TResult success(Result? result),
    required TResult error(Failure failure),
  }) {
    return error(failure);
  }

  @override
  List<Object?> get props => [failure];
}

class SuccessState<Result extends Object> extends ControlState<Result> {
  final Result? result;
  SuccessState(this.result);

  @override
  TResult when<TResult extends Object>({
    required TResult initial(),
    required TResult loading(),
    required TResult success(Result? result),
    required TResult error(Failure failure),
  }) {
    return success(result);
  }

  @override
  List<Object?> get props => [result];
}
