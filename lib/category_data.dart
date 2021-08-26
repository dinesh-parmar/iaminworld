import 'package:flutter/material.dart';

class Category{
  final String categoryName;
  final String lastpayment;
  int money;
  int percentage=0;
  final Color topColor;
  final Color bottomColor;

  void set setMoney(int money){
    this.money = money;
  }
  void set setPercentage(int percentage){
    this.percentage=percentage;
  }

  Category(this.categoryName,this.lastpayment,this.money,this.topColor,this.bottomColor);


}



List<Category> categoriesList = [
  Category("Mobile Home Dealers", "Last payment 17 Aug", 4694, const Color(0xFF42275A), const Color(0xFF734B6D)),
  Category("Taxi Cab and Limousines", "Last payment on 19 Aug", 456, const Color(0xFF2b5876), const Color(0xFF4e4376)),
  Category("Miscenallous Apparel and Accessory Shops", "Last payment on 8 Aug",245, const Color(0xFF141e30), const Color(0xFF243b55)),
  Category("Electric Gas, Sanitary and Water Utilities", "Last payment on 10 Aug",140, const Color(0xFFde6262), const Color(0xFFffb88c)),
  Category("Miscenallous General Merchandise", "Last payment on 15 Aug",20, const Color(0xFF3a1c71), const Color(0xFF19547b))
];



