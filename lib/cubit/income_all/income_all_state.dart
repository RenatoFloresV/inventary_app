part of 'income_all_cubit.dart';

abstract class IncomeAllState {
  const IncomeAllState();

  List<Object> get props => [];
}

class IncomeAllInitial extends IncomeAllState {
  const IncomeAllInitial();
}

class IncomeAllLoading extends IncomeAllState {
  const IncomeAllLoading();
}

class IncomeAllLoaded extends IncomeAllState {
  final List<IncomeModel> incomes;

  const IncomeAllLoaded([this.incomes = const []]);

  @override
  List<Object> get props => [ incomes];

  @override
  String toString() => 'IncomeAllLoaded';
}

class IncomeAllNotLoaded extends IncomeAllState {
  final String error;
  const IncomeAllNotLoaded(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'IncomeAllNotLoaded { error: $error }';
}

class IncomeAllError extends IncomeAllState {
  final String message;

  const IncomeAllError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'IncomeAllError { message: $message }';
}
