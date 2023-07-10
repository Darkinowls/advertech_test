import 'package:advertecha_test/core/status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'contact_form_state.dart';

class ContactFormCubit extends Cubit<ContactFormState> {
  ContactFormCubit() : super(ContactFormState());
}
