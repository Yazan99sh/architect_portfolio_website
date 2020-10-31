import 'dart:convert';
import 'package:http/http.dart';
Future newProject(String title,String info ,file)async{
  String base64Image = base64Encode(file.bytes);
  Pattern p =file.path.toString()[2];
  String fileName = file.path.split(p).last;
  var response = await post('https://shahersalousi.000webhostapp.com/Shaher/ProjectImage/newProject.php',body: {
    'title':"$title",
    'info':"$info",
    'image':"$fileName",
    'file':"$base64Image"
  });
  print(response.body);
  if (response.statusCode == 200){
    return true;
  }
  else {
    return false;
  }
}