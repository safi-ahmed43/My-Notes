import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? id, userId, title, desc;
  DateTime createdAt;
  NoteModel(this.id,this.userId,this.title,this.desc,this.createdAt);
  
  factory NoteModel.formMap(Map<String, dynamic> map ) => NoteModel(
    map['id'],
    map['user_id'],
    map['title'],
    map['desc'],
    map['created_at'] is Timestamp
        ? (map['created_at'] as Timestamp).toDate()
        : DateTime.parse(map['created_at'].toString()),
  );
  Map<String, dynamic> toMap() => {
    'id':id,
    'user_id':userId,
    'title':title,
    'desc':desc,
    'created_at': Timestamp.fromDate(createdAt)
  };
}