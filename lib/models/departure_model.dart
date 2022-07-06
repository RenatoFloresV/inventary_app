import 'package:cloud_firestore/cloud_firestore.dart';

class DepartureModel {
  String? id;
  String? product;
  int? amount;
  String? date;
  String? time;
  String? user;
  num? price;

  DepartureModel(
      {this.id,
      this.product,
      this.amount,
      this.user,
      this.date,
      this.time,
      this.price});

  List<Object> get props => [id!, product!, amount!, date!, time!, user!];

  static DepartureModel fromSnapshot(DocumentSnapshot snapshot) {
    DepartureModel departureModel = DepartureModel(
      id: snapshot['id'],
      product: snapshot['product'],
      amount: snapshot['amount'],
      date: snapshot['date'],
      time: snapshot['time'],
      user: snapshot['user'],
      price: snapshot['price'],
    );
    return departureModel;
  }
}
