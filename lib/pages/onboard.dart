import 'package:flutter/material.dart';
import 'package:food_delivery/pages/signup.dart';
import 'package:food_delivery/widget/content_model.dart';
import 'package:food_delivery/widget/widget_support.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {

  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);


    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index)
                {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i){
                return Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
               
                child: Column(
                  children: [
                    Image.asset(
                      contents[i].image, 
                      height: 400, 
                      width: MediaQuery.of(context).size.width, 
                      fit: BoxFit.fill,),
              
                    SizedBox(height: 20.0,),
                    Text(contents[i].title, style: AppWidget.boldTextFeildStyle(),),
                     SizedBox(height: 5.0,),
                     Text(contents[i].description, style: AppWidget.LightTextFeildStyle(),),

                  ],
                ),
                
                );
                
              },),
            ),

           Container(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                    contents.length, 
                    (index) => buildDot(index, context), // Pass context instead of contents
                
                ),
                 ),
               ),


            GestureDetector(
              onTap: () {
                if(currentIndex== contents.length-1){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
                }
                _controller.nextPage(duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
              },
              child: Container(
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20.0)),
                height: 60,
                margin: EdgeInsets.all(40),
                width: double.infinity,
                child: Center(child: Text(
                  currentIndex== contents.length-1?"START": "NEXT",
                   style: TextStyle(
                    color: Colors.white, 
                    fontSize: 20.0, 
                    fontWeight: FontWeight.bold))),
              ),
            )
          ],
        ),
      );
    }

    Container buildDot(int index, BuildContext context) {
      return Container(
        height: 10.0,
        width: currentIndex == index ? 18:7,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.black38
        ),
      );
    }

}