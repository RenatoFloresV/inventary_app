import 'package:bloc/bloc.dart';
import 'package:inventary_app/repositories/departure/departure_all_repository.dart';
import 'package:meta/meta.dart';
import '../../models/departure_model.dart';

part 'departure_state.dart';

class DepartureCubit extends Cubit<DepartureState> {
  DepartureCubit(this._dateincomeRepository) : super(DepartureInitial());
  final DepartureAllRepository _dateincomeRepository;

  Future<void> getDepartures() async {
    try {
      final dateincomesStreamData =
          _dateincomeRepository.getAllDepartures();
      dateincomesStreamData.listen((departures) {
        emit(DepartureLoaded(departures));
      });
    } catch (e) {
      emit(DepartureError(e.toString()));
    }
  }

  Future<void> addDeparture(dateincomeModel) async {
    final response = await _dateincomeRepository.addDeparture(
      dateincomeModel,
    );
    return response;
  }
  // Future<void> test(uid) async {
  //   final response = await _dateincomeRepository.addIncomesFromUser(uid);
  //   return response;
  // }
}
