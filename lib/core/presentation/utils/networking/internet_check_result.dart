import 'package:waterhero/core/presentation/utils/networking/internet_check_option.dart';

class InternetCheckResult {
  InternetCheckResult({
    required this.option,
    required this.isSuccess,
  });

  final InternetCheckOption option;

  final bool isSuccess;

  @override
  String toString() {
    return 'InternetCheckResult(\n'
        '  option: ${option.toString().replaceAll('\n', '\n  ')},\n'
        '  isSuccess: $isSuccess\n'
        ')';
  }
}
