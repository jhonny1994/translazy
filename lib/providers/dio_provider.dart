import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translazy/core/constants.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio()
    ..options.baseUrl = ApiConstants.baseUrl
    ..options.connectTimeout = const Duration(seconds: 20)
    ..options.receiveTimeout = const Duration(seconds: 20);
  return dio;
});
