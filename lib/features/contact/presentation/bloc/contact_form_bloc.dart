import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:advertecha_test/core/status.dart';
import 'package:advertecha_test/features/contact/data/data_sources/contact_remote.dart';
import 'package:advertecha_test/features/contact/data/models/contact_model.dart';
import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'contact_form_event.dart';

part 'contact_form_state.dart';

class ContactFormBloc extends Bloc<ContactFormEvent, ContactFormState> {
  final ContactRemote _contactRemote;

  ContactFormBloc(this._contactRemote) : super(const ContactFormState()) {
    on<ContactFormEvent>(_onEvent, transformer: sequential());
  }

  _onEvent(ContactFormEvent e, Emitter<ContactFormState> emit) {
    return switch (e) {
      NameChangedEvent e => _onNameChanged(e, emit),
      EmailChangedEvent e => _onEmailChanged(e, emit),
      MessageChangedEvent e => _onMessageChanged(e, emit),
      SendFormEvent e => _onSendForm(e, emit),
    };
  }

  Future<void> _onSendForm(_, Emitter<ContactFormState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final int? status = await Future.delayed(
        const Duration(seconds: 3),
        () async => await _contactRemote.sendContact(ContactModel(
            name: state.name, email: state.email, message: state.message)));
    if (kDebugMode) {
      print((state.name, state.email, state.message));
    }
    if (status == 201) {
      emit(state.copyWith(status: Status.success));
    } else {
      emit(state.copyWith(status: Status.failed));
    }
    emit(state.copyWith(status: Status.loaded));
    if (state.isFormReadyToSend()) {
      emit(state.copyWith(status: Status.ready));
    }
  }

  void _onNameChanged(NameChangedEvent e, Emitter<ContactFormState> emit) {
    emit(state.copyWith(name: e.name));
    if (state.name.isEmpty) {
      emit(state.copyWith(errorName: "The field is empty", status: Status.loaded));
      return;
    }
    emit(state.copyWith(errorName: ""));
    if (state.isFormReadyToSend()) {
      emit(state.copyWith(status: Status.ready));
    }
  }

  void _onEmailChanged(EmailChangedEvent e, Emitter<ContactFormState> emit) {
    emit(state.copyWith(email: e.email));
    if (!EmailValidator.validate(state.email)) {
      emit(state.copyWith(errorEmail: "Email is invalid", status: Status.loaded));
      return;
    }
    emit(state.copyWith(errorEmail: ""));
    if (state.isFormReadyToSend()) {
      emit(state.copyWith(status: Status.ready));
    }
  }

  void _onMessageChanged(
      MessageChangedEvent e, Emitter<ContactFormState> emit) {
    emit(state.copyWith(message: e.message));
    if (state.message.isEmpty) {
      emit(state.copyWith(errorMessage: "The field is empty", status: Status.loaded));
      return;
    }
    emit(state.copyWith(errorMessage: ""));
    if (state.isFormReadyToSend()) {
      emit(state.copyWith(status: Status.ready));
    }
  }

}
