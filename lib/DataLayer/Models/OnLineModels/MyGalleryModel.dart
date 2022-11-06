// To parse this JSON data, do
//
//     final myGalleryModel = myGalleryModelFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators, prefer_if_null_operators

import 'dart:convert';

MyGalleryModel myGalleryModelFromJson(String str) =>
    MyGalleryModel.fromJson(json.decode(str));

String myGalleryModelToJson(MyGalleryModel data) => json.encode(data.toJson());

class MyGalleryModel {
  MyGalleryModel({
    this.status,
    this.data,
    this.message,
  });

  String? status;
  Data? data;
  String? message;

  factory MyGalleryModel.fromJson(Map<String, dynamic> json) => MyGalleryModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data!.toJson(),
        "message": message == null ? null : message,
      };
}

class Data {
  Data({
    this.images,
  });

  List<String>? images;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
      };
}
