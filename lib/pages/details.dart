import 'package:flutter/material.dart';
import 'package:food_delivery/service/database.dart';
import 'package:food_delivery/service/shared_pref.dart';
import 'package:food_delivery/widget/widget_support.dart';

class Details extends StatefulWidget{
 // const Details({super.key});
 String image, name, detail, price;
 Details({required this.detail, required this.image, required this.name, required this.price});


  @override
  State<Details> createState() => _DetailsState();

}

class _DetailsState extends State<Details> {

  int a = 1, total = 0;
  String? id;

  getthesharedpref () async{
     id = await SharedPrefHelper().getUserId();

     setState(() {
       
     });
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    ontheload();
    total = int.parse(widget.price);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,)),
          Image.network(widget.image,
          width: MediaQuery.of(context).size.height/2,
          fit: BoxFit.fill,
            ),

            SizedBox(height: 15.0,),
           
           

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: AppWidget.semiBoldTextFeildStyle(),),
                
              ],
            ),
      //SizedBox(width: 40.0,),

      Spacer(),
               
                GestureDetector(
                  onTap: () {

                    if(a>1)
                    {
                      --a;
                      total = total-int.parse(widget.price);
                    }
                    
                    setState(() {
                      
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8.0)),
                    child: 
                    Icon(Icons.remove, color: Colors.white,)
                  ),
                ),

                SizedBox(width: 15.0,),

                Text(a.toString(), style: AppWidget.semiBoldTextFeildStyle(),),

                SizedBox(width: 15.0,),

                 GestureDetector(
                  onTap: () {
                    
                    ++a;
                    total = total+int.parse(widget.price);
                    setState(() {
                      
                    });
                  },
                   child: Container(
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8.0)),
                    child: 
                    Icon(Icons.add, color: Colors.white,)
                                   ),
                 ),
              ],
            ),

            SizedBox(height: 10.0,),
            Text(widget.detail, style: AppWidget.LightTextFeildStyle(),),
         
          SizedBox(height: 20.0,),         
           
            Row(
              children: [
                Text("Delivery Time", style: AppWidget.semiBoldTextFeildStyle(),),
                SizedBox(width: 20.0,),
                Icon(Icons.alarm, color: Colors.black54,),
                SizedBox(width: 5.0,),
                Text("30 min", style: AppWidget.semiBoldTextFeildStyle(),),
              ],
            ),

            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Price", style: AppWidget.boldTextFeildStyle(),),
                      Text("\$"+total.toString(), style: AppWidget.HeaderlineTextFeildStyle(),)
                    ],
                  ),

                  SizedBox(width: 40.0,),
                  
                   GestureDetector(
                    onTap: () async{
                      Map<String, dynamic> addFoodtoCart = {
                        "Name": widget.name,
                        "Quntity": a.toString(),
                        "Total": total.toString(),
                        "Image": widget.image
                      };

                      await DatabaseMethods().addFoodToCart(addFoodtoCart, id!);
                       ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                       backgroundColor: Colors.orangeAccent,
                       content: Text("Food Added to Cart", style: TextStyle(fontSize: 18),),)));
                    },
                     child: Container(
                      //width: MediaQuery.of(context).size.width/3,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Add to cart", 
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 15.0, 
                            fontFamily: 'Poppins'),),
                     
                            SizedBox(width: 20.0,),
                     
                          Container(
                            padding: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),
                            child: Icon(Icons.shopping_cart_outlined, color: const Color.fromARGB(255, 238, 236, 236),),
                          ),
                     
                        ],
                      ),
                     ),
                   )

                ],
              ),
            )

       ],)
       
        
      ),
    );
  }
}

