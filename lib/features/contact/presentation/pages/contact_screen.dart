import 'package:advertecha_test/features/contact/presentation/form/contact_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
          title: const Center(child: Text("Contact us")),
        ),
        body: const ContactForm());
  }
}
