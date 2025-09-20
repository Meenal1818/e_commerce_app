import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  String imgPath;
  String name;
  String price;
  VoidCallback onTap;

  ProductCard({
    required this.imgPath,
    required this.name,
    required this.price,
    required this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int selectedIndex = 0;

  List<Color> mColors = [
    Colors.black,
    Colors.blue,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade200,
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 11, vertical: 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.network(widget.imgPath, width: 100, height: 100,)),
                  Spacer(),
                  Text(widget.name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  Row(
                    children: [
                      Text(widget.price),
                      Spacer(),
                      SizedBox(
                        height: 24,
                        child: Row(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: mColors.length,
                              itemBuilder: (_, index){
                                return InkWell(
                                  onTap: (){
                                    selectedIndex = index;
                                    setState(() {});
                                  },
                                  child: selectedIndex == index ? Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: mColors[index], width: 1)
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 2),
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: mColors[index]
                                      ),
                                    ),
                                  ) : Container(
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: mColors[index]
                                    ),
                                  ),
                                );
                              },
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: Center(
                                child: Text("+2", style: TextStyle(color: Colors.grey, fontSize: 10),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      )
                  ),
                  child: Center(
                    child: Icon(Icons.favorite_border,size: 20, color: Colors.white,),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}