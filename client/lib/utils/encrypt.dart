import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Cryptography{
  static late List<int> _key;
  
  static setUpKey(String key){
     _key = md5.convert(utf8.encode(key)).bytes;
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

    bool outFileExists = await outFile.exists();

    if(!outFileExists){
      await outFile.create();
    }

    final fileContents = inFile.readAsStringSync(encoding: latin1);

    final key = Key.fromUtf8(md5.convert(_key).toString());

    final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

    
    final encrypted = encrypter.encrypt(fileContents);
    await outFile.writeAsBytes(encrypted.bytes);

    await inFile.delete();
  }

  Future<void> decryptFile() async {
    File inFile = File(await getEncryptedFile());
    File outFile = File("databasedec.db");

    bool outFileExists = await outFile.exists();

    if(!outFileExists){
      await outFile.create();
    }

    final videoFileContents = inFile.readAsBytesSync();

    final key = Key.fromUtf8(md5.convert(_key).toString());

    final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

    final encryptedFile = Encrypted(videoFileContents);
    final decrypted = encrypter.decrypt(encryptedFile);

    final decryptedBytes = latin1.encode(decrypted);
    await outFile.writeAsBytes(decryptedBytes);

    await inFile.delete();
  }
}