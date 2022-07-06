import 'package:bloc/bloc.dart';
import 'package:inventary_app/models/income_model.dart';
import '../../repositories/income/income_all_repository.dart';

part 'income_all_state.dart';

class IncomeAllCubit extends Cubit<IncomeAllState> {
  final IncomeAllRepository _incomeAllRepository;
  IncomeAllCubit(this._incomeAllRepository) : super(const IncomeAllInitial());

  Future<void> getIncomeAlls() async {
    try {
      final incomeAllsStreamData = _incomeAllRepository.getAllIncomeAlls();
      incomeAllsStreamData.listen((incomes) {
        emit(IncomeAllLoaded(incomes));
      });
    } catch (e) {
      emit(IncomeAllError(e.toString()));
    }
  }

  Future<void> addDateIncome(dateincomeModel) async {
    final response = await _incomeAllRepository.addIncome(dateincomeModel);
    return response;
  }
}
