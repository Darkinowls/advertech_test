import 'package:advertecha_test/features/contact/presentation/bloc/contact_form_bloc.dart';
import 'package:advertecha_test/features/contact/presentation/form/icon_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/status.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactFormBloc, ContactFormState>(
      listener: (context, state) {
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
      },
      child: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconTextFormField(
                child: BlocSelector<ContactFormBloc, ContactFormState, String>(
              selector: (state) => state.errorName,
              builder: (context, errorStr) {
                return TextFormField(
                  onChanged: (value) =>
                      BlocProvider.of<ContactFormBloc>(context)
                          .add(NameChangedEvent(value)),
                  decoration: InputDecoration(
                      labelText: "Name",
                      errorText: errorStr.isEmpty ? null : errorStr),
                );
              },
            )),
            const SizedBox(height: 25),
            IconTextFormField(
              child: BlocSelector<ContactFormBloc, ContactFormState, String>(
                selector: (state) => state.errorEmail,
                builder: (context, errorStr) {
                  return TextFormField(
                    onChanged: (value) =>
                        BlocProvider.of<ContactFormBloc>(context)
                            .add(EmailChangedEvent(value)),
                    decoration: InputDecoration(
                        labelText: "Email",
                        errorText: errorStr.isEmpty ? null : errorStr),
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
            IconTextFormField(
              child: BlocSelector<ContactFormBloc, ContactFormState, String>(
                selector: (state) => state.errorMessage,
                builder: (context, errorStr) {
                  return TextFormField(
                      onChanged: (value) =>
                          BlocProvider.of<ContactFormBloc>(context)
                              .add(MessageChangedEvent(value)),
                      decoration: InputDecoration(
                          labelText: "Message",
                          errorText: errorStr.isEmpty ? null : errorStr));
                },
              ),
            ),
            const SizedBox(height: 50),
            BlocSelector<ContactFormBloc, ContactFormState, Status>(
              selector: (state) => state.status,
              builder: (context, status) {
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(152, 109, 142, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    onPressed: (status != Status.ready)
                        ? null
                        : () => BlocProvider.of<ContactFormBloc>(context)
                            .add(const SendFormEvent()),
                    child: (status == Status.loading)
                        ? const Row(
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
                          )
                        : const Text("Send"));
              },
            )
          ],
        ),
      ),
    );
  }
}
