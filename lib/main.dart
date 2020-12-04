import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
import 'package:shaher_website/ControlUI/Pages/SafeZone.dart';
import 'package:shaher_website/isSelected.dart';
import 'package:shaher_website/responsive/HomeView.dart';
import 'package:shaher_website/responsive/ProjectView.dart';
import 'package:sitemap/sitemap.dart';
var selected ;
void main()async{
  final sitemap = new Sitemap();

  sitemap.entries.add(new SitemapEntry()
    ..location = 'https://shahersalousi.000webhostapp.com'
    ..priority = 0.75
    ..addAlternate('UI', 'https://shahersalousi.000webhostapp.com/#/UI')
    );

  print(sitemap.generate());
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
