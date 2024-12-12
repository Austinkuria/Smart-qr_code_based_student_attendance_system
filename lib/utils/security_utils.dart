// lib/utils/security_utils.dart

import 'package:crypto/crypto.dart';
import 'dart:convert';

class SecurityUtils {
  static String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }
}