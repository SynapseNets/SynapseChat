import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Cryptography{
  static late Key? _key;

  static Key? get key => _key;
  
  static setUpKey(String key){
     _key = Key.fromUtf8(md5.convert(utf8.encode(key)).toString());
  }

  static setUpKeyFromHash(String hash){
    _key = Key.fromUtf8(hash);
  }

  static Future<String> getDatabaseFile() async{
    return join(await getDatabasesPath(), 'database.db');
  }

  static Future<String> getEncryptedFile() async{
    return join(await getDatabasesPath(), 'databaseenc.aes');
  }

  Future<void> encryptFile() async {
    File inFile = File(await getDatabaseFile());
    File outFile = File(await getEncryptedFile());
    print(inFile.path);

    bool outFileExists = outFile.existsSync();

    if(!outFileExists){
      outFile.createSync();
    }

    final fileContents = inFile.readAsStringSync(encoding: latin1);

    final encrypter = Encrypter(AES(_key!, mode: AESMode.ecb));

    final encrypted = encrypter.encrypt(fileContents);
    outFile.writeAsBytesSync(encrypted.bytes);

    inFile.deleteSync();
  }

  Future<void> decryptFile() async {
    File inFile = File(await getEncryptedFile());
    File outFile = File(await getDatabaseFile());

    bool outFileExists = outFile.existsSync();

    if(!outFileExists){
      outFile.createSync();
    }

    final videoFileContents = inFile.readAsBytesSync();

    final encrypter = Encrypter(AES(_key!, mode: AESMode.ecb));

    final encryptedFile = Encrypted(videoFileContents);
    final decrypted = encrypter.decrypt(encryptedFile);

    final decryptedBytes = latin1.encode(decrypted);
    outFile.writeAsBytesSync(decryptedBytes);

    inFile.deleteSync();
  }
}