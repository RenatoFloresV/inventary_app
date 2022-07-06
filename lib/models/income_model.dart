import 'package:cloud_firestore/cloud_firestore.dart';

class IncomeModel {
  String? id;
  String? product;
  int? amount;
  String? date;
  String? code;
  String? user;
  String? time;
  IncomeModel(
      {this.id,
      this.product,
      this.amount,
      this.date,
      this.code,
      this.user,
      this.time});

  List<Object> get props => [id!, product!, amount!, date!, code!];

  static IncomeModel fromSnapshot(DocumentSnapshot snapshot) {
    IncomeModel incomeModel = IncomeModel(
        id: snapshot['id'],
        product: snapshot['product'],
        amount: snapshot['amount'],
        date: snapshot['date'],
        time: snapshot['time'],
        code: snapshot['code'],
        user: snapshot['user']);
    return incomeModel;
  }
}
