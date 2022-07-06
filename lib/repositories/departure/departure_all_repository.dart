import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventary_app/models/departure_model.dart';

class DepartureAllRepository {
  final _incomeAllDate = FirebaseFirestore.instance.collection('departures');

  Stream<List<DepartureModel>> getAllDepartures() {
    final response = _incomeAllDate;
    return response.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => DepartureModel.fromSnapshot(doc))
          .toList();
    });
  }

  Future<void> addDeparture(departureModel) async {
    await _incomeAllDate.add({
      'id': departureModel.id,
      'product': departureModel.product,
      'amount': departureModel.amount,
      'date': departureModel.date,
      'time': departureModel.time,
      'user': departureModel.user,
      'price': departureModel.price,
    });
  }

  // Future<void> addIncomesFromUser(uid) async{
  //   FirebaseFirestore.instance.collection('users').doc(uid).collection('incomes').add({
  //     'id': '1',
  //     'product': 'product',
  //     'amount': 'amount',
  //     'date': 'date',
  //     'time': 'time',
  //     'user': 'user',
  //     'price': 'price',
  //   });
  // }
}
