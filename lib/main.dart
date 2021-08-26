import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iamin/transaction_data.dart';
import 'category_data.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  late AnimationController _controller;
  late List<Animation<double>> sizeAnimation;
  late List<List<AnimationController>> _containerControllerlist;
  late List<List<Animation<double>>> listOfTweens;
  var rng = Random();
  @override
  void initState(){
    super.initState();

    int temp = 10000;
    List<int> percentageList = [];
    for(var i=0;i<categoriesList.length;i++){
        int randMoney = rng.nextInt(temp);
        categoriesList[i].setMoney= randMoney;
        categoriesList[i].setPercentage = (randMoney/100).floor();
        percentageList.add((randMoney/100).floor());
        temp = temp -randMoney;
    }
    _startAnimation(percentageList);
  }

  @override
  Widget build(BuildContext context) {
    final _h = MediaQuery.of(context).size.height;
    final _w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("I AM IN WORLD"),
        ),
        body: RefreshIndicator(
          displacement: 20.0,
          onRefresh: () {
            return Future.delayed(
                const Duration(seconds: 2),
                    () {
                  for(var i=0;i<listOfTransaction.length;i++){
                    listOfTransaction[i].randMoney();
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage(title: "I AM IN WORLD")),
                  );
                });
          },
          child: ListView(
            children: [
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Padding(
                  padding: EdgeInsets.only(top: _h*0.1),
                ),
                Card(
                  elevation: 8.0,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 8.0, top: 5.0, bottom: 5.0),
                          child: Text(
                            "Card Balance",
                            style: TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, top: 5.0, bottom: 5.0),
                          child: Row(
                            children: const <Widget>[
                              Text(
                                "\u{20B9}0",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 15.0),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15.0,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 10.0, 8.0, 10.0),
                  child: Text(
                    "Payment Categories",
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: _h * 0.30,
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            Container(
                                    width: _w*0.35,
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                        gradient: LinearGradient(
                                            end: Alignment.topRight,
                                            begin: Alignment.bottomCenter,
                                            colors: [
                                      categoriesList[index].topColor,
                                      categoriesList[index].bottomColor
                                    ])
                                    ),
                                ),
                             SizedBox(
                               height: _h * 0.35,
                               width: _w * 0.35,
                               child: Directionality(
                                 textDirection: TextDirection.rtl,
                                 child: GridView.builder(
                                   scrollDirection: Axis.vertical,
                                   shrinkWrap: true,
                                   itemCount: sizeAnimation[index].value.toInt(),
                                   reverse: true,
                                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                         crossAxisCount: 4,
                                         mainAxisSpacing: 2.0,
                                         crossAxisSpacing: 2.0
                                     ),
                                     itemBuilder: (BuildContext context, int gridIndex){
                                     _containerControllerlist[index][gridIndex].forward();
                                      return BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                                          child: Container(
                                            decoration:  BoxDecoration(
                                             gradient: LinearGradient(
                                                 begin: Alignment.bottomCenter,
                                                 end: Alignment.topCenter,
                                                 colors: [Colors.white.withOpacity(0.1),Colors.transparent],
                                                 stops: [listOfTweens[index][gridIndex].value,1.0]
                                             )
                                            ),
                                          ),
                                          );
                                     }),
                               ),
                             ),
                             Positioned(
                               bottom: 5.0,
                              left: 5.0,
                              child: Text("\u{20B9} ${categoriesList[index].money.toString()}",),
                             ),
                             Positioned(
                              bottom: 5.0,
                              right: 20.0,
                              child: Text(categoriesList[index].percentage.toString()+" %"),
                            ),
                             Positioned(
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     SizedBox(width: _w*0.35*0.8,child: Text(categoriesList[index].categoryName,style: const TextStyle(fontSize: 13.0),textAlign: TextAlign.left,)),
                                     SizedBox(width: (_w*0.35),child: Text(categoriesList[index].lastpayment,style: const TextStyle(fontSize: 10.0,color: Colors.grey),))
                                   ],
                                 ),
                               ),
                             )

                          ],
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
                      child: Text(
                        "Latest Transaction",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Row(
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
                          child: Text(
                            "Show All",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            size: 15.0,
                          )
                        ),


                      ],
                    ),

                  ],
                ),
                SizedBox(
                  height: _h*0.30,
                  child: ListView.builder(
                    itemCount: listOfTransaction.length,
                    itemBuilder: (BuildContext context, int index) {
                      return  Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(color: Colors.black12, width: 2.0)
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.swap_horiz)),
                          title:  Text(listOfTransaction[index].transactionName),
                          subtitle: Text(listOfTransaction[index].date,style: const TextStyle(color: Colors.grey),),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              listOfTransaction[index].transactiontype=="debit"?Text("- \u{20B9} ${listOfTransaction[index].money}", style: const TextStyle(color: Colors.red,fontSize: 15.0),):Text("+ \u{20B9} ${listOfTransaction[index].money}",style: const TextStyle(color: Colors.green,fontSize: 15.0)),
                              Text(listOfTransaction[index].time,style: const TextStyle(fontSize: 12.0,color: Colors.grey))
                            ]
                          ),
                        ),
                      );

                    },),
                )
              ],

            ),
              ]
          ),
        )
    );
  }
  void _startAnimation(List<int> percentageLst){
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..addListener(
            ()  => setState(() {})
    )..forward();


    _containerControllerlist =  List.generate(
        categoriesList.length,
            (controllerindex) => List.generate(
                (percentageLst[controllerindex]*0.01*28).ceil(),
                    (index) => AnimationController(
                  duration:   Duration(milliseconds: (3/(percentageLst[controllerindex]*0.01*28).ceil()*1000).floor()),
                  vsync: this,
                )..addListener(() => setState(() {})))
    );

    listOfTweens = List.generate(categoriesList.length,
            (controllerIndex) => List.generate( (percentageLst[controllerIndex]*0.01*28).ceil(),
                    (index) {
              double endTween=1.0;
              if(index==(percentageLst[controllerIndex]*0.01*28).ceil()-1){
                endTween = (percentageLst[controllerIndex]*0.01*28)-index;
              }
              return Tween(
                    begin: 0.0,
                    end: endTween
                ).animate(
                    CurvedAnimation(
                        parent: _containerControllerlist[controllerIndex][index],
                        curve: Curves.easeIn
                    )
                );
            }
            )
    );



    sizeAnimation = List.generate(categoriesList.length,(index)=>Tween(
        begin: 0.0,
        end: (percentageLst[index]*0.01*28).ceil().toDouble()
    ).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Curves.linear
        )
    )
    );
  }

}
