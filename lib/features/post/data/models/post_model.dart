import 'package:clean_architecture_flutter/core/databases/api/end_points.dart';

import '../../domain/entities/post_entitiy.dart';

class PostModel extends PostEntity {
  final int userId;
  final String body;

  PostModel(
      {required this.userId,
      required super.id,
      required super.title,
      required this.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json[ApiKey.id],
      userId: json[ApiKey.userId],
      body: json[ApiKey.body],
      title: json[ApiKey.title],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.id: id,
      ApiKey.userId: userId,
      ApiKey.body: body,
      ApiKey.title: title,
    };
  }
}
