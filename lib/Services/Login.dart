import 'dart:convert';
import 'package:http/http.dart';
Future<bool> login(String pass)async{
  var response = await post('https://shahersalousi.000webhostapp.com/Shaher/Login.php',body: {
    'password':pass,
  });
  if (response.statusCode == 200){
    var jsonResponse=json.decode(response.body);
    
    if (jsonResponse.toString().contains('password')){
      return true;
    }
    else {
      return false;
    }
  }
  else {
    return false;
  }
}