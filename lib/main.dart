import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'API test App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? stringResponse;
  Map? mapResponse;
  Map? dataResponse;
  List? userResponce;
  int page = 1;

  // Future apiCall() async {
  //   http.Response response;
  //   response =
  //       await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       stringResponse = response.body;
  //       mapResponse = jsonDecode(response.body);
  //       // dataResponse = mapResponse!['data'];
  //       userResponce = mapResponse!['data'];
  //     });
  //   }
  //   print(userResponce!.length);
  // }

  Future apiCall() async {
    http.Response response;
    response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));
    if (response.statusCode == 200) {
      stringResponse = response.body;

      mapResponse = jsonDecode(response.body);

      dataResponse = mapResponse!['data'];
      userResponce = mapResponse!['data'];
    }
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  Future<void> loadNextPage() async {
    setState(() {
      page++;
    });
    await apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: userResponce == null ? 0 : userResponce!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          border: Border.all(
                              width: 2,
                              style: BorderStyle.solid,
                              color: const Color.fromARGB(255, 105, 255, 105)),
                          borderRadius: BorderRadius.circular(10)),
                      child: mapResponse == null
                          ? Container()
                          : Image.network(
                              mapResponse?['data'][index < 6 ? index : 0]
                                          ['avatar']
                                      .toString() ??
                                  'somthing',
                            ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Id: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: Color.fromARGB(255, 85, 85, 85)),
                        ),
                        Text(
                          "First Name: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: Color.fromARGB(255, 85, 85, 85)),
                        ),
                        Text(
                          "Last Name: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: Color.fromARGB(255, 85, 85, 85)),
                        ),
                        Text(
                          "Email: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: Color.fromARGB(255, 85, 85, 85)),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mapResponse == null
                            ? Container()
                            : Text(
                                mapResponse?['data'][index < 6 ? index : 0]
                                            ['id']
                                        .toString() ??
                                    'somthing',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                                textAlign: TextAlign.center,
                              ),
                        mapResponse == null
                            ? Container()
                            : Text(
                                mapResponse?['data'][index < 6 ? index : 0]
                                            ['first_name']
                                        .toString() ??
                                    'somthing',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                                textAlign: TextAlign.center,
                              ),
                        mapResponse == null
                            ? Container()
                            : Text(
                                mapResponse?['data'][index < 6 ? index : 0]
                                            ['last_name']
                                        .toString() ??
                                    'somthing',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                                textAlign: TextAlign.center,
                              ),
                        mapResponse == null
                            ? Container()
                            : Text(
                                mapResponse?['data'][index < 6 ? index : 0]
                                            ['email']
                                        .toString() ??
                                    'somthing',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(221, 46, 46, 46)),
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.center,
                              ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 40,
                    ),
                    mapResponse == null
                        ? Container()
                        : Text(
                            mapResponse?['data'][index < 6 ? index : 0]
                                        ['first_name']
                                    .toString() ??
                                'somthing',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            loadNextPage();
          });
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
