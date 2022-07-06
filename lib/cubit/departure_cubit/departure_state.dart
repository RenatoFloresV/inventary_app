part of 'departure_cubit.dart';

@immutable
abstract class DepartureState {}

class DepartureInitial extends DepartureState {}

class DepartureLoading extends DepartureState {}

class DepartureLoaded extends DepartureState {
  final List<DepartureModel> departures;

  DepartureLoaded([this.departures = const []]);

  List<Object> get props => [departures];

  @override
  String toString() => 'DepartureLoaded';
}

class DepartureNotLoaded extends DepartureState {
  final String error;
  DepartureNotLoaded(this.error);

  List<Object> get props => [error];

  @override
  String toString() => 'DepartureNotLoaded { error: $error }';
}

class DepartureError extends DepartureState {
  final String message;

  DepartureError(this.message);

  List<Object> get props => [message];

  @override
  String toString() => 'DepartureError { message: $message }';
}
