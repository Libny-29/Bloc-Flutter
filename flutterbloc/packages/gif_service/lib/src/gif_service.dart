/// {@template gif_service}
/// My Gif service
/// {@endtemplate}
import 'dart:convert';

import 'package:http/http.dart' as http;
class GifService {
  /// {@macro gif_service}
  GifService({http.Client? httpClient})
  : _httpClient = httpClient ?? http.Client();

  final  http.Client _httpClient ;
  final String baseUrl = "api.giphy.com";
  final String endPoint = "/v1/gifs/trending";
  final String apiKey = "PBjAdIc3uV4CyDNqy6cnshc0KzyN3fSG";

  Future<List<String>> fetchGifs() async{
    final uri = Uri.http(baseUrl,endPoint, {'api_key' : apiKey});
    http.Response response ;
    List body;
    try{
      response = await _httpClient.get(uri) ; 
    }on Exception{
      throw Exception();
    }

    if(response.statusCode != 200){
      throw HttpResquestExeception();
    }

    try{
      body = jsonDecode(response.body)['data'] as List; 
    }on Exception{
      throw JsonDecodeExeception();
    }

   return body
   .map((url) => url['images']['original']['url'].toString())
   .toList();
  }
}

class HttpResquestExeception implements Exception{}
class JsonDecodeExeception implements Exception{}
