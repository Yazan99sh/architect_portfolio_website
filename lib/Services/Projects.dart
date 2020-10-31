import 'package:http/http.dart';
import 'dart:convert';
Future <dynamic> projects()async{
  var response = await post('https://shahersalousi.000webhostapp.com/Shaher/Projects.php');
  if (response.statusCode == 200){
    return json.decode(response.body);
  }
  else
    return null;
}