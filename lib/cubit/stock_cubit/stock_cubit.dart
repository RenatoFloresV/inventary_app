import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/stock_model.dart';
import '../../repositories/stock/stock_repository.dart';

part 'stock_state.dart';

class StockCubit extends Cubit<StockState> {
  StockCubit(this._stockRepository) : super(StockInitial());
  final StockRepository _stockRepository;

  Future<void> getStocks() async {
    try {
      final dateincomesStreamData = _stockRepository.getStock();
      dateincomesStreamData.listen((stocks) {
        emit(StockLoaded(stocks));
      });
    } catch (e) {
      emit(StockError(e.toString()));
    }
  }

  Future<void> addStock(stockModel) async {
    final response = await _stockRepository.addStock(stockModel);
    return response;
  }
}
