import 'package:cloud_firestore/cloud_firestore.dart';

class StockModel {
  String? id;
  String? product;
  int? amount;

  StockModel({this.id, this.product, this.amount});

  List<Object> get props => [id!, product!, amount!];

  static StockModel fromSnapshot(DocumentSnapshot snapshot) {
    StockModel stockModel = StockModel(
        id: snapshot['id'],
        product: snapshot['product'],
        amount: snapshot['amount']);
    return stockModel;
  }
}
