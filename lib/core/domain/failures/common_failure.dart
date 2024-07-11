import 'package:freezed_annotation/freezed_annotation.dart';
part 'common_failure.freezed.dart';

@freezed
class CommonFailure with _$CommonFailure {
  const CommonFailure._();

  const factory CommonFailure.data({required String message}) = _Data;

  const factory CommonFailure.noData({required String message}) = _NoData;

  const factory CommonFailure.server({
    required String message,
    required int code,
  }) = _Server;

  const factory CommonFailure.storage({required String message}) = _Storage;

  const factory CommonFailure.noConnection({required String message}) =
      _NoConnection;
}
