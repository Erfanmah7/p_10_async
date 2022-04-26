import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({Key? key}) : super(key: key);

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  String textread = 'satus';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(textread),
            ElevatedButton(
              onPressed: () async {
                await write('test.txt', 'salammmmmmmm');
              },
              child: Text('write'),
            ),
            ElevatedButton(
              onPressed: () async {
                final resulttext = await read('test.txt');
                print(resulttext);
                setState(() {});
              },
              child: Text('read'),
            ),
          ],
        ),
      ),
    );
  }

  Future<File> write(String file_name, String text) async {
    try {
      final File file = await getFile(file_name);

      return file.writeAsString(text);
    } catch (e) {
      return File('');
    }
  }

  Future<String> read(String file_name) async {
    try {
      final File file = await getFile(file_name);
      textread = await file.readAsString();
      return textread;
    } catch (e) {
      return '-1';
    }
  }

  Future<File> getFile(String file_name) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = await directory.path;
    final File file = await File('$path/$file_name');
    return file;
  }
}
