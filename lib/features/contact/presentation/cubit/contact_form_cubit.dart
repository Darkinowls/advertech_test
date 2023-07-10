import 'package:advertecha_test/core/status.dart';
import 'package:advertecha_test/features/contact/data/data_sources/contact_remote.dart';
import 'package:advertecha_test/features/contact/data/models/contact_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'contact_form_state.dart';

class ContactFormCubit extends Cubit<ContactFormState> {
  final ContactRemote _contactRemote;

  ContactFormCubit(this._contactRemote) : super(const ContactFormState());

  void sendContactForm(String name, String email, String message) async {
    emit(state.copyWith(status: Status.loading));
    final int? status = await Future.delayed(
        const Duration(seconds: 1),
        () async => await _contactRemote.sendContact(
            ContactModel(name: name, email: email, message: message)));
    if (status == 201) {
      emit(state.copyWith(status: Status.success));
      return;
    }
    emit(state.copyWith(status: Status.failed));
    emit(state.copyWith(status: Status.loaded));
  }
}
