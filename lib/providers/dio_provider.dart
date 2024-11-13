import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translazy/core/constants.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio()..options.baseUrl = ApiConstants.baseUrl;
  return dio;
});
