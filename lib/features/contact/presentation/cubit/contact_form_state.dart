part of 'contact_form_cubit.dart';

class ContactFormState extends Equatable {
  final Status status;

  @override
  List<Object> get props => [status];

  const ContactFormState({
    this.status = Status.loaded,
  });

  ContactFormState copyWith({
    Status? status,
  }) {
    return ContactFormState(
      status: status ?? this.status,
    );
  }
}
