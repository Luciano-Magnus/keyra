import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

class TokenUtils {
  static String generateToken({int length = 64}) {
    final random = Random.secure();

    final bytes = List<int>.generate(length, (_) => random.nextInt(256));

    return base64UrlEncode(bytes).replaceAll('=', '');
  }

  static String hashToken(String token) {
    var key = utf8.encode(Uuid().v1());
    var bytes = utf8.encode(token);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);

    return digest.toString();
  }
}