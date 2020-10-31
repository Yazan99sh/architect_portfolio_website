import 'package:flutter/material.dart';
// ignore: camel_case_types
class isSelected with ChangeNotifier {
 int selected;
 int tapped;
 Map data;
 isSelected(this.selected,this.tapped,this.data);
 int getSelectIndex() => selected;
 int getSelectTapped() => tapped;
 Map getData() => data;
 setIndex(int index) async {
   selected = index;
   notifyListeners();
 }
 setTap(int index) async {
   tapped = index;
   notifyListeners();
 }
 setData(Map dat) async {
   data = dat;
   notifyListeners();
 }
}