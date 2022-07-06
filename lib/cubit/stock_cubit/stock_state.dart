part of 'stock_cubit.dart';

@immutable
abstract class StockState {}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockLoaded extends StockState {
  final List<StockModel> stocks;

  StockLoaded([this.stocks = const []]);

  List<Object> get props => [stocks];

  @override
  String toString() => 'StockLoaded';
}

class StockNotLoaded extends StockState {
  final String error;
  StockNotLoaded(this.error);

  List<Object> get props => [error];

  @override
  String toString() => 'StockNotLoaded { error: $error }';
}

class StockError extends StockState {
  final String message;

  StockError(this.message);

  List<Object> get props => [message];

  @override
  String toString() => 'StockError { message: $message }';
}
