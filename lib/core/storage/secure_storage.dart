import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure storage for sensitive data like tokens and credentials.
/// Uses platform keychain/keystore for encryption.
class SecureStorage {
  SecureStorage._();

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  // ── Token Keys ──
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userIdKey = 'user_id';

  // ── Access Token ──
  static Future<String?> getAccessToken() => _storage.read(key: _accessTokenKey);
  static Future<void> setAccessToken(String token) =>
      _storage.write(key: _accessTokenKey, value: token);
  static Future<void> deleteAccessToken() => _storage.delete(key: _accessTokenKey);

  // ── Refresh Token ──
  static Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);
  static Future<void> setRefreshToken(String token) =>
      _storage.write(key: _refreshTokenKey, value: token);
  static Future<void> deleteRefreshToken() => _storage.delete(key: _refreshTokenKey);

  // ── User ID ──
  static Future<String?> getUserId() => _storage.read(key: _userIdKey);
  static Future<void> setUserId(String id) =>
      _storage.write(key: _userIdKey, value: id);

  // ── Generic ──
  static Future<String?> read(String key) => _storage.read(key: key);
  static Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);
  static Future<void> delete(String key) => _storage.delete(key: key);

  // ── Clear All ──
  static Future<void> clearAll() => _storage.deleteAll();

  // ── Check ──
  static Future<bool> containsKey(String key) => _storage.containsKey(key: key);
}
