import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/income_model.dart';

class IncomeAllRepository {
  final _incomeAllDate = FirebaseFirestore.instance.collection('incomes');

  Stream<List<IncomeModel>> getAllIncomeAlls() {
    final response = _incomeAllDate;
    return response.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => IncomeModel.fromSnapshot(doc)).toList();
    });
  }

  Future<void> addIncome(incomeModel) async {
    await _incomeAllDate.add({
      'id': incomeModel.id,
      'product': incomeModel.product,
      'amount': incomeModel.amount,
      'date': incomeModel.date,
      'time': incomeModel.time,
      'code': incomeModel.code,
      'user': incomeModel.user,
    });
  }
}
