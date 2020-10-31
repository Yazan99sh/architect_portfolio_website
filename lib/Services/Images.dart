import 'package:http/http.dart';
import 'dart:convert';
Future <dynamic> images(String title)async{
  var response = await post('https://shahersalousi.000webhostapp.com/Shaher/Images.php',body: {
    'projectTitle':title
  });
  if (response.statusCode == 200){
    return json.decode(response.body);
  }
  else
    return null;
}