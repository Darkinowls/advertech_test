import 'package:advertecha_test/features/contact/presentation/cubit/contact_form_cubit.dart';
import 'package:advertecha_test/features/contact/presentation/form/icon_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/status.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final emailC = TextEditingController();
  final messageC = TextEditingController();
  final nameC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var toBlockButton = false;

  @override
  void initState() {
    emailC.addListener(() => setState(() {}));
    messageC.addListener(() => setState(() {}));
    nameC.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    emailC.dispose();
    nameC.dispose();
    messageC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactFormCubit, ContactFormState>(
      listener: (context, state) {
        setState(() => toBlockButton = false);
        if (state.status == Status.failed) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 8),
              content: Row(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(width: 15),
                  Text("There is an error in the form!"),
                ],
              )));
        }
        if (state.status == Status.success) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 8),
              content: Row(
                children: [
                  Icon(Icons.gpp_good, color: Colors.green),
                  SizedBox(width: 15),
                  Text("Message is successfully delivered!"),
                ],
              )));
        }
        if (state.status == Status.loading) {
          setState(() => toBlockButton = true);
          toBlockButton = true;
          return;
        }
      },
      child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconTextFormField(
                    textFormField: TextFormField(
                        controller: nameC,
                        decoration: const InputDecoration(labelText: "Name"),
                        validator: _checkFieldIsNotEmpty)),
                const SizedBox(height: 25),
                IconTextFormField(
                  textFormField: TextFormField(
                    controller: emailC,
                    decoration: const InputDecoration(labelText: "Email"),
                    validator: (value) {
                      if (value != null && !EmailValidator.validate(value)) {
                        return "The email isn't valid";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 25),
                IconTextFormField(
                  textFormField: TextFormField(
                      controller: messageC,
                      decoration: const InputDecoration(labelText: "Message"),
                      validator: _checkFieldIsNotEmpty),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(152, 109, 142, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    onPressed: (_formKey.currentState != null &&
                                !_formKey.currentState!.validate() ||
                            toBlockButton)
                        ? null
                        : () => BlocProvider.of<ContactFormCubit>(context)
                            .sendContactForm(
                                nameC.text, emailC.text, messageC.text),
                    child: BlocBuilder<ContactFormCubit, ContactFormState>(
                      builder: (context, state) {
                        if (state.status == Status.loading) {
                          return const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Please wait"),
                              SizedBox(width: 15),
                              SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ))
                            ],
                          );
                        }
                        return const Text('Send');
                      },
                    )),
              ],
            ),
          )),
    );
  }

  String? _checkFieldIsNotEmpty(String? value) {
    if (value != null && value.isEmpty) {
      return "The field should not be empty";
    }
    return null;
  }
}
