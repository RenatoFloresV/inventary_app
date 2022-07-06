import 'package:cloud_firestore/cloud_firestore.dart';


class DateModel {
  String? id;
  String? date;

  DateModel({this.id, this.date
      });

  List<Object> get props => [
        id!,
        date!,
      ];

  static DateModel fromSnapshot(DocumentSnapshot snapshot) {
    DateModel dateModel = DateModel(
      id: snapshot.id,
      date: snapshot['date'],
    );
    return dateModel;
  }
}
