import 'package:flutter_secure_dotenv/flutter_secure_dotenv.dart';

part 'flutter_secure_dotenv_generator_example.g.dart';

/// Example usage of the flutter_secure_dotenv_generator.
///
/// For non-encrypted mode, use a simple factory constructor:
///   const factory Env() = _$Env;
///
/// For encrypted mode, configure ENCRYPTION_KEY, IV, and OUTPUT_FILE
/// in build.yaml, and use:
///   const factory Env(String encryptionKey, String iv) = _$Env;
@DotEnvGen(
  filename: '.env',
  fieldRename: FieldRename.screamingSnake,
)
abstract class Env {
  const factory Env() = _$Env;

  const Env._();

  @FieldKey(defaultValue: "")
  String get apiBaseUrl;

  @FieldKey(defaultValue: "")
  String get apiWebSocketUrl;
}
