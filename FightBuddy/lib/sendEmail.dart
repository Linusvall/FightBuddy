import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmailPage {
  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    final serviceId = 'service_izh8b2h';
    final templateId = 'template_74y75k3';
    final userId = 'HHAeMuM6HJ6hkYZIk';

    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final respone = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_subject': subject,
            'user_message': message,
          }
        }));
  }
}
