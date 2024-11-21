class ApiConstants {
  static const String baseUrl = 'https://655.mtis.workers.dev/';
  static const String translateEndpoint = 'translate';

  static const int maxInputLength = 100;
  static const Duration rateLimitWindow = Duration(seconds: 1);
  static const int maxRequestsPerWindow = 4;
  static const Duration requestTimeout = Duration(seconds: 20);
}
