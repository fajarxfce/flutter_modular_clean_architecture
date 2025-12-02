/// Network configuration
class NetworkConfig {
  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;
  final bool enableLogging;

  const NetworkConfig({
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.sendTimeout = const Duration(seconds: 30),
    this.enableLogging = true,
  });

  factory NetworkConfig.development() {
    return const NetworkConfig(
      baseUrl: 'https://pos.karuhundeveloper.com/api',
      enableLogging: true,
    );
  }

  factory NetworkConfig.production() {
    return const NetworkConfig(
      baseUrl: 'https://pos.karuhundeveloper.com/api',
      enableLogging: false,
    );
  }

  factory NetworkConfig.staging() {
    return const NetworkConfig(
      baseUrl: 'https://pos.karuhundeveloper.com/api',
      enableLogging: true,
    );
  }
}
