import 'package:http/http.dart';
Future deleteImage(String image)async{
  var response = await post('https://shahersalousi.000webhostapp.com/Shaher/Image/deleteImage.php',body: {
    'image':image,
  });
  print(response.body);
}