part of 'contact_form_cubit.dart';

class ContactFormState extends Equatable {
  final Status status;
  final String email;
  final String name;
  final String message;

  @override
  List<Object> get props => [status, email, name, message];

  const ContactFormState({
    this.status = Status.loaded,
    this.email = "",
    this.name = "",
    this.message = "",
  });

  ContactFormState copyWith({
    Status? status,
    String? email,
    String? name,
    String? message,
  }) {
    return ContactFormState(
      status: status ?? this.status,
      email: email ?? this.email,
      name: name ?? this.name,
      message: message ?? this.message,
    );
  }
}
