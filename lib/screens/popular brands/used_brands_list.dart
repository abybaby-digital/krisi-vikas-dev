import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UsedBrandsList extends StatelessWidget {
  UsedBrandsList({Key? key}) : super(key: key);

   var img = [
     "https://www.tractorjunction.com/assets/images/upload/mahindra-1608095492.jpg",
     "https://www.tractorjunction.com/assets/images/upload/swaraj-1608095532.png",
     "https://www.tractorjunction.com/assets/images/upload/massey-ferguson-1579512590.png",
     "https://www.tractorjunction.com/assets/images/upload/sonalika-1608095516.png",
     "https://www.tractorjunction.com/assets/images/upload/farmtrac-1579511831.png",
     "https://www.tractorjunction.com/assets/images/upload/eicher-1608095225.png",
     "https://www.tractorjunction.com/assets/images/upload/john-deere-1579511882.png",
     "https://www.tractorjunction.com/assets/images/upload/powertrac-1579511958.png",
     "https://www.tractorjunction.com/assets/images/upload/new-holland-1579511945.png",

   ];

   var name = ["Mahindra","Swaraj", "Massey Ferguson","Sonalika","Farmtrac","Eicher","John Deere","Powertrac","New Holland",];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15,top: 10),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
         childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 2.5),
      ), 
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(5.0),
             child: Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(8),
                 color: Colors.white,
                 boxShadow: const [
                   BoxShadow(
                     color: Colors.grey,
                     blurRadius: 2
                   )
                 ]
               ),
              height: 200,
              child: InkWell(
                onTap: (){
                
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(img[index], height: 45,),
                    ),
                    Text(name[index], style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                    ),)
                  ]
                ),
              ),
              )
          );
        }),
    );
  }
}