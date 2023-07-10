import 'package:advertecha_test/features/contact/presentation/form/icon_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:email_validator/email_validator.dart';

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
    return Form(
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
              )),
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
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(152, 109, 142, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                onPressed: (nameC.text.isEmpty ||
                        messageC.text.isEmpty ||
                        !_formKey.currentState!.validate())
                    ? null
                    : () {},
                child: const Text('Send'),
              )
            ],
          ),
        ));
  }
}
