import 'package:flutter/material.dart';
import 'package:p_10_async/screens/file_screen.dart';
import 'package:p_10_async/widget/body_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Async'),
        leading: IconButton(
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return FileScreen();
                }),
              );
            });
          },
          icon: const Icon(
            Icons.more_vert_rounded,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await add();
              setState(() {});
            },
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: loading(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            List<String> resultList = snapshot.data;
            return bodyMaker(resultList);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget bodyMaker(List<String> list) {
    if (list.isEmpty) {
      return const Center(
        child: Text(
          'no item found',
          style: TextStyle(fontSize: 30),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return BodyContainer(
            num: list[index],
            onPressd: () async {
              await delete(list[index]);
              setState(() {});
            },
          );
        },
        itemCount: list.length,
      );
    }
  }

  Future<bool> add() async {
    try {
      SharedPreferences perf = await SharedPreferences.getInstance();
      int counter = perf.getInt('counter') ?? 0;
      counter++;
      await perf.setInt('counter', counter);
      //return
      List<String> itemList = perf.getStringList('Items') ?? [];
      //add
      itemList.add('Item $counter');
      //save
      await perf.setStringList('Items', itemList);
      return true;
      //perf.clear();
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(String item) async {
    try {
      SharedPreferences perf = await SharedPreferences.getInstance();
      List<String> itemList = perf.getStringList('Items') ?? [];
      itemList.remove(item);
      await perf.setStringList('Items', itemList);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<String>> loading() async {
    SharedPreferences perf = await SharedPreferences.getInstance();
    List<String> itemList = perf.getStringList('Items') ?? [];
    return itemList;
  }
}
