import 'package:currency_converter/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = API_URL+API_KEY;

void main() async {
  // print(await getData());

  runApp(
     MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        hintColor: Colors.amber,
      ),
    ),
  );
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  Map<dynamic, dynamic> data = json.decode(response.body);
  return data;
  // return json.decode(response.body)['results'];
}
