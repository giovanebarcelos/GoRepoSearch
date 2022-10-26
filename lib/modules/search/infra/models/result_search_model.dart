// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../domain/entities/entities.dart';

class ResultSearchModel extends ResultSearch {
  ResultSearchModel({required super.title, required super.content, required super.img});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'img': img,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    return ResultSearchModel(
      title: map['title'] as String,
      content: map['content'] as String,
      img: map['img'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source) as Map<String, dynamic>);  
}
