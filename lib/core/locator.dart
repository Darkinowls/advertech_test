import 'package:advertecha_test/features/contact/data/data_sources/contact_remote.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final lc = GetIt.instance;

Future<void> setupLocator() async {
  lc.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: "https://api.byteplex.info/api")));

  lc.registerSingleton<ContactRemote>(ContactRemote(lc<Dio>()));
}
