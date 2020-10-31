import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
import 'package:shaher_website/ControlUI/Pages/SafeZone.dart';
import 'package:shaher_website/isSelected.dart';
import 'package:shaher_website/responsive/HomeView.dart';
import 'package:shaher_website/responsive/ProjectView.dart';
var selected ;
void main()async{
  runApp(ChangeNotifierProvider<isSelected>(
    create: (BuildContext context) => isSelected(-1,-1,{}),
    child: MyApp(),
  ));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    selected = Provider.of<isSelected>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:"Shaher Salouci | Architect",
      theme: ThemeData(
        tabBarTheme: TabBarTheme(
            unselectedLabelColor: Colors.black,
            unselectedLabelStyle: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontSize: 14,
                color: Colors.black
            )
        ),
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute:'/UI',
      routes: {
        '/UI':(context)=>HomeView(),
        '/ProjectDetails':(context)=>ProjectView(),
        '/flushbarRoute':(context)=>SafeZone(),
      },
    );
  }
}
