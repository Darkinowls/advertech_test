import 'package:advertecha_test/core/locator.dart';
import 'package:advertecha_test/features/contact/data/data_sources/contact_remote.dart';
import 'package:advertecha_test/features/contact/presentation/cubit/contact_form_cubit.dart';
import 'package:advertecha_test/features/contact/presentation/form/contact_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        body: BlocProvider<ContactFormCubit>(
          create: (context) => ContactFormCubit(lc<ContactRemote>()),
          child: const ContactForm(),
        ));
  }
}
