import 'dart:convert';

import 'package:advertecha_test/features/contact/data/models/contact_model.dart';
import 'package:dio/dio.dart';

class ContactRemote {
  final Dio dio;

  ContactRemote(this.dio);

  Future<int?> sendContact(ContactModel contactModel) async {
    final Response response = await dio.post("/test/contact/",
        data: jsonEncode(contactModel.toJson()));
    return response.statusCode;
  }
}
