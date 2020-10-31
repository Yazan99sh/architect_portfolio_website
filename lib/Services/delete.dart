import 'package:http/http.dart';
Future deleteProject(String title,String image)async{
  var response = await post('https://shahersalousi.000webhostapp.com/Shaher/ProjectImage/deleteProject.php',body: {
    'image':image,
    'title':title,
  });
  print(response.body);
  var response2 = await post('https://shahersalousi.000webhostapp.com/Shaher/Image/deleteProjectImage.php',body: {
    'title':title,
  });

}