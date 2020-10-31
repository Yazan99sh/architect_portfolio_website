import 'package:http/http.dart';
Future sendEmail(String message, String email, String name,String subject)async{
  var response = await post('https://shahersalousi.000webhostapp.com/Shaher/mail.php',body: {
    'message':message,
    'name':name,
    'subject':subject,
    'From':email
  });
  if (response.statusCode == 200){
    return true;
  }
  else {
    return false;
  }
}