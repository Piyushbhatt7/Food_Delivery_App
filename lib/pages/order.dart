import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/service/database.dart';
import 'package:food_delivery/service/shared_pref.dart';
import 'package:food_delivery/widget/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _Order();
}

class _Order extends State<Order> {


String? id, wallet;
int total = 0, amount2 = 0;

void startTimer()
{
  Timer(Duration(seconds: 1), (){
    amount2 = total;
    setState(() {
      
    });
  });
}

getthesharedpref() async {
  id  = await SharedPrefHelper().getUserId();
  wallet = await SharedPrefHelper().getUserWallet();
  setState(() {
    
  });
}

ontheload() async {
  await getthesharedpref();
  foodStream = await DatabaseMethods().getFoodCart(id!);
  setState(() {
    
  });
}

@override
void initState() {

  ontheload();
  startTimer();
  super.initState();
  
}


Stream? foodStream;

 Widget foodCart()  {
      return StreamBuilder(
        stream: foodStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData? ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index){
            DocumentSnapshot ds = snapshot.data.docs[index];
            total = total + int.parse(ds["Total"]);
            return   Container(
                 margin: EdgeInsets.only(left: 15.0 ,right: 5.0, bottom: 20.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10.0),
                   
                    child: Row(
                     //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 90,
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: 
                          Center(
                            child: 
                            Text(ds["Quntity"])),
                        ),
                        SizedBox(width: 20.0,),
                       ClipRRect(
                         borderRadius: BorderRadius.circular(60),
                        child: 
                        Image.network(ds["Image"],height: 90.0, width: 90.0, fit: BoxFit.cover,)),
                        SizedBox(width: 20.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ds["Name"], style: AppWidget.boldTextFeildStyle(),maxLines: 1,),
                            Text("\$"+ds["Total"], style: AppWidget.semiBoldTextFeildStyle(),),
                            
                          ],
                        ),
                      ],
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
        body: Container(
          padding: EdgeInsets.only(top: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Material(
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Center(
                    child: Text(
                      "Food Cart", 
                      style: AppWidget.HeaderlineTextFeildStyle(),
                    ),
                  ),
                ),
              ),
                  
                SizedBox(height: 20.0,),
            
               Container(
                height: MediaQuery.of(context).size.height/2,
                child: foodCart()),
                
                Spacer(),
                Divider(),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Price", style: AppWidget.boldTextFeildStyle(),),
                      Text("\$"+ total.toString(), style: AppWidget.semiBoldTextFeildStyle(),)
                    ],
                  ),
                ),
                  
                  SizedBox(height: 20.0,),

                GestureDetector(
                  onTap: () async{
                    int amount = int.parse(wallet!) - amount2;

                    await DatabaseMethods().updateUserwallet(id!, amount.toString());
                    await SharedPrefHelper().saveUserWallet(amount.toString());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 25.0),
                    child: Center(
                      child: Text("CheckOut", 
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 20.0, 
                        fontWeight: FontWeight.bold
                        
                      ),)),
                  ),
                )
            ],
          ),
        ),
      );
    }

}