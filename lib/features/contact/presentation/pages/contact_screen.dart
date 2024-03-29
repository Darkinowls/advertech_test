import 'package:advertecha_test/core/locator.dart';
import 'package:advertecha_test/features/contact/data/data_sources/contact_remote.dart';
import 'package:advertecha_test/features/contact/presentation/form/contact_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contact_form_bloc.dart';

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
        body: BlocProvider<ContactFormBloc>(
          create: (context) => ContactFormBloc(lc<ContactRemote>()),
          child: const SingleChildScrollView(child: ContactForm()),
        ));
  }
}
