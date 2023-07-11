part of 'contact_form_bloc.dart';

class ContactFormState extends Equatable {
  final Status status;
  final String email;
  final String errorEmail;
  final String name;
  final String errorName;
  final String message;
  final String errorMessage;

  @override
  List<Object?> get props => [
        status,
        email,
        errorEmail,
        name,
        errorName,
        message,
        errorMessage,
      ];

  const ContactFormState({
    this.status = Status.loaded,
    this.email = "",
    this.errorEmail = "",
    this.name = "",
    this.errorName = "",
    this.message = "",
    this.errorMessage = "",
  });

  ContactFormState copyWith({
    Status? status,
    String? email,
    String? errorEmail,
    String? name,
    String? errorName,
    String? message,
    String? errorMessage,
  }) {
    return ContactFormState(
      status: status ?? this.status,
      email: email ?? this.email,
      errorEmail: errorEmail ?? this.errorEmail,
      name: name ?? this.name,
      errorName: errorName ?? this.errorName,
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool isThereError() =>
      errorEmail.isNotEmpty || errorMessage.isNotEmpty || errorName.isNotEmpty;

  bool isThereEmptyField() => email.isEmpty || message.isEmpty || name.isEmpty;

  bool isFormFilledCorrectly() => !isThereError() && !isThereEmptyField();

  bool isFormReadyToSend() => isFormFilledCorrectly() && status == Status.loaded;

}
