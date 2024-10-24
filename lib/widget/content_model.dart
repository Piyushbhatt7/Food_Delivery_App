
class UnboardingContent{

  String image;
  String title;
  String description;
  UnboardingContent({required this.description, required this.image, required this.title});
}

List<UnboardingContent> contents = [

  UnboardingContent(
                    description: "Pich the food from our menu\n More than 35 times", 
                    image: "images/screen1.png", 
                    title: "Select from our\n    Best Menu"
                    ),
                  UnboardingContent(
                  description: "Cash on delivery also avalaible", 
                  image: "images/screen2.png", 
                  title: "Safe and Secure Online Payements"
                    ),
                  UnboardingContent(
                  description: "Delivery your food at your Doorsteps", 
                  image: "images/screen3.png", 
                  title: "Quick Delivery at your Doorsteps")
                 

];
 