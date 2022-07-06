import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/stock_model.dart';

class StockRepository {
  final _stockDate = FirebaseFirestore.instance.collection('stock');
  Stream<List<StockModel>> getStock() {
    final response = _stockDate;
    return response.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => StockModel.fromSnapshot(doc)).toList();
    });
  }

  Future<void> addStock(stockModel) async {
    await _stockDate.add({
      'id': stockModel.id,
      'product': stockModel.product,
      'amount': stockModel.amount,
    });
  }
}
