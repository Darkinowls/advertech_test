import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final lc = GetIt.instance;

Future<void> setupLocator() async {
  lc.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: "https://api.byteplex.info/api")));
}
