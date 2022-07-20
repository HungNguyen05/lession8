import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lession8/photo.dart';

Future<Album> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Quan Ly Album"),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: fetchAlbum(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final Album album = snapshot.data!;
                return _buildContainer(context, album);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ));
  }
}

Widget _buildContainer(BuildContext context, Album album) {
  var _width = MediaQuery.of(context).size.width;
  var _height = MediaQuery.of(context).size.height;
  return Container(
    width: _width,
    height: _height,
    child: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    album.photos[index].url,
                    width: 80,
                    height: 80,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${album.photos[index].albumId}'),
                      Text("Title: ${album.photos[index].title}")
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: ((context, index) => Divider()),
        itemCount: album.photos.length),
  );
}
