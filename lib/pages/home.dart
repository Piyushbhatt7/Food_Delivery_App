import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/details.dart';
import 'package:food_delivery/service/database.dart';
import 'package:food_delivery/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool icecream = false, pizza = false, burger = false, salad = false;
  Stream? fooditemsStream;

  ontheload() async {
   fooditemsStream = await DatabaseMethods().getFoodItem("Ice-cream");

   setState(() {
     
   });
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget allItemsVertically()  {
      return StreamBuilder(
        stream: fooditemsStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData? ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index){
            DocumentSnapshot ds = snapshot.data.docs[index];
            return   GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Details(detail: ds["Detail"],name: ds["Name"],price: ds["Price"],image: ds["Image"],)));
                  },
                  child: Container(
          margin: EdgeInsets.only(right: 20.0),
           child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(20.0),
             child: Container(
              padding: EdgeInsets.all(2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(ds["Image"]),
                  SizedBox(width: 18.0,),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text(ds["Name"], style: AppWidget.semiBoldTextFeildStyle(),)),
                        SizedBox(height: 5.0,),
                         Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("Honey Goot Cheeze", style: AppWidget.LightTextFeildStyle(),)),
             
                         SizedBox(height: 5.0,),
                         Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("\$"+ds["Price"], style: AppWidget.semiBoldTextFeildStyle(),)),
                        
                    ],
                  ),
                ],
              ),
             ),   
           ),
         )
                );
          }): CircularProgressIndicator(

          );
        },
      );
    }


    Widget allItems()  {
      return StreamBuilder(
        stream: fooditemsStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData? ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index){
            DocumentSnapshot ds = snapshot.data.docs[index];
            return   GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  Details(detail: ds["Detail"],name: ds["Name"],price: ds["Price"],image: ds["Image"],)));
                  },
                  child: Container(
                
                    margin: EdgeInsets.all(4),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                      
                          ClipRRect(
                             borderRadius: BorderRadius.circular(15),
                            child: Image.network(ds["Image"], height: 120, width: 120, fit: BoxFit.cover,)),
                          Text(ds["Name"], style: AppWidget.boldTextFeildStyle(),),
                          SizedBox(height: 5.0),
                          
                           Text("Fresh and Healthy", style: AppWidget.LightTextFeildStyle(),),
                           SizedBox(height: 5.0),
                           
                           Text("\$"+ds["Price"], style: AppWidget.boldTextFeildStyle(),)
                        ],) ,
                      ),
                    ),
                  ),
                );
          }): CircularProgressIndicator(

          );
        },
      );
    }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.0, left:18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Hello Piyush,", style:AppWidget.boldTextFeildStyle()
              ),
               Container(
                margin: EdgeInsets.only(right: 20.0),
                padding: EdgeInsets.all(3),
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10) ),
            child: Icon(Icons.shopping_cart_outlined, color: Colors.white,),
          ),
            ],
          ),
        
          SizedBox(height: 20.0,),
        
           Text(
            "Delicious Food",
             style:AppWidget.HeaderlineTextFeildStyle(),
              ),
        
            Text(
            "Discover and Get Great Food",
             style:AppWidget.LightTextFeildStyle(),
              ),
        
              SizedBox(height: 20.0,),
        
            Container(
              margin: EdgeInsets.only(right: 20.0),
              child: showItem()),
            SizedBox(height: 10.0,),
            
          //  Container(
          //   height: 70.0,
          //   child: allItems()),
        
            SizedBox(height: 20.0),
        
          Container(
            height: 250,
            child: allItems()),
            
          SizedBox(height: 20.0,), 
        
           Container(
            margin: EdgeInsets.only(right: 20.0),
             child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(20.0),
               child: Container(
                padding: EdgeInsets.all(2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("images/salad3.png", height: 120, width: 120, fit: BoxFit.cover,),
                    SizedBox(width: 18.0,),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Text("Mediterranean Chickpea Salad", style: AppWidget.semiBoldTextFeildStyle(),)),
                          SizedBox(height: 5.0,),
                           Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Text("Honey Goot Cheeze", style: AppWidget.LightTextFeildStyle(),)),
               
                           SizedBox(height: 5.0,),
                           Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Text("\$28", style: AppWidget.semiBoldTextFeildStyle(),)),
                          
                      ],
                    ),
                  ],
                ),
               ),   
             ),
           ),
        
           SizedBox(height: 30.0,),
        
            Container(
            margin: EdgeInsets.only(right: 20.0),
             child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(20.0),
               child: Container(
                padding: EdgeInsets.all(2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("images/salad2.png", height: 120, width: 120, fit: BoxFit.cover,),
                    SizedBox(width: 18.0,),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Text("Veggies Taco Hash", style: AppWidget.semiBoldTextFeildStyle(),)),
                          SizedBox(height: 5.0,),
                           Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Text("Spicy Salad", style: AppWidget.LightTextFeildStyle(),)),
               
                           SizedBox(height: 5.0,),
                           Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Text("\$25", style: AppWidget.semiBoldTextFeildStyle(),)),
                          
                      ],
                    ),
                  ],
                ),
               ),   
             ),
           ),
        
        ],
        ),
        ),
      ),
    );
  }

  Widget showItem()
  {
    return   Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               
                GestureDetector(
                  onTap: () async{
                    icecream = true;
                    pizza = false;
                    burger = false;
                    salad = false;
                    fooditemsStream = await DatabaseMethods().getFoodItem("Ice-cream");
                    setState(() {
                      
                    });
                  },         
                  child: Material(
                    elevation: 6.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(color: icecream? Colors.black: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: Image.asset('images/ice-cream.png', height: 45, width: 45, fit: BoxFit.fill, color: icecream? Colors.white: Colors.black),
                    ),
                  ),
                ),

                     // for pizza
                
                 GestureDetector(
                  onTap: () async{
                    icecream = false;
                    pizza = true;
                    burger = false;
                    salad = false;
                    fooditemsStream = await DatabaseMethods().getFoodItem("Pizza");
                    setState(() {
                      
                    });
                  },
                 
                  child: Material(
                    elevation: 6.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(color: pizza? Colors.black: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: Image.asset('images/pizza.png', height: 40, width: 40, fit: BoxFit.cover, color: pizza? Colors.white: Colors.black),
                    ),
                  ),
                ),


                // for salad

                 GestureDetector(
                  onTap: () async{
                    icecream = false;
                    pizza = false;
                    burger = false;
                    salad = true;
                    fooditemsStream = await DatabaseMethods().getFoodItem("Salad");
                    setState(() {
                      
                    });
                  },
                 
                  child: Material(
                    elevation: 6.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(color: salad? Colors.black: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: Image.asset('images/salad.png', height: 40, width: 40, fit: BoxFit.cover, color: salad? Colors.white: Colors.black),
                    ),
                  ),
                ),


                 // for burger

                 GestureDetector(
                  onTap: () async{
                    icecream = false;
                    pizza = false;
                    burger = true;
                    salad = false;
                    fooditemsStream = await DatabaseMethods().getFoodItem("Burger");
                    setState(() {
                      
                    });
                  },
                 
                  child: Material(
                    elevation: 6.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(color: burger? Colors.black: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: Image.asset('images/burger.png', height: 40, width: 40, fit: BoxFit.cover, color: burger? Colors.white: Colors.black),
                    ),
                  ),
                ),

              ],
            );
  }
}