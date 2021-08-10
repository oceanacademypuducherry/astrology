import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
}

Future fetchAlbum1() async {
  final response = await http.get(Uri.parse('http://192.168.0.21:5000'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(jsonDecode(response.body));
    return jsonDecode(response.body)['userId'];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void main() {
  print("Enter your name :");

  // prompt for user input
  String? name = stdin.readLineSync();

  // this is a synchronous method that reads user input
  print("Hello Mr. ${name}");
  print("End of main");
  fetchAlbum1();
}
