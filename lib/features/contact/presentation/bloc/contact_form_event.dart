part of 'contact_form_bloc.dart';

sealed class ContactFormEvent{
  const ContactFormEvent();
}

class NameChangedEvent extends ContactFormEvent{
  final String name;
  const NameChangedEvent(this.name);
}

class EmailChangedEvent extends ContactFormEvent{
  final String email;
  const EmailChangedEvent(this.email);
}

class MessageChangedEvent extends ContactFormEvent{
  final String message;
  const MessageChangedEvent(this.message);
}

class SendFormEvent extends ContactFormEvent{
  const SendFormEvent();
}