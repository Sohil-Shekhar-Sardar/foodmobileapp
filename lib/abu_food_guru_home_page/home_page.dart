import 'dart:ui';

import 'package:abu_food_guru/core/abu_food_guru_colors.dart';
import 'package:abu_food_guru/core/abu_food_guru_sizeConfig.dart';
import 'package:abu_food_guru/core/abu_food_guru_string_en.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;
  int currentIndexSlider = 0;
  final PageController controller = PageController();

  List<String> images = [
    "https://picsum.photos/id/240/200/300",
    "https://picsum.photos/id/241/200/300",
    "https://picsum.photos/id/241/200/300",
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              height: SizeConfig.screenHeight*0.18,
              width: SizeConfig.screenWidth,
              child: Column(
                children: [
                  TopBarLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
                  SearchBar(SizeConfig.screenHeight, SizeConfig.screenWidth),
                ],
              ),
            ),
            Container(
              height: SizeConfig.screenHeight*0.67,
              width: SizeConfig.screenWidth,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SpeacialOffer(SizeConfig.screenHeight, SizeConfig.screenWidth),
                  FoodItems(SizeConfig.screenHeight, SizeConfig.screenWidth),
                  FoodInfo(SizeConfig.screenHeight, SizeConfig.screenWidth),
                  PopularMenu(SizeConfig.screenHeight, SizeConfig.screenWidth),
                ],
              ),
            ),
            Container(
              height: SizeConfig.screenHeight*0.1,
              width: SizeConfig.screenWidth,
              color: CommonColor.WHITE_COLOR,
              child: SalomonBottomBar(
                currentIndex: _currentIndex,
                onTap: (i) => setState(() => _currentIndex = i),
                items: [
                  /// Home
                  SalomonBottomBarItem(
                    icon:Image(image: AssetImage("assets/images/Home.png")),
                    title: Text("Home"),
                    selectedColor: CommonColor.ORANGE_COLOR,
                  ),

                  /// Likes
                  SalomonBottomBarItem(
                    icon:Image(image: AssetImage("assets/images/Profile.png")),
                    title: Text("Profile"),
                    selectedColor: CommonColor.ORANGE_COLOR,
                  ),

                  /// Search
                  SalomonBottomBarItem(
                    icon:Image(image: AssetImage("assets/images/Icon Cart.png"),
                      height: SizeConfig.screenWidth*0.08,
                    ),
                    title: Text("Cart"),
                    selectedColor: CommonColor.ORANGE_COLOR,
                  ),

                  /// Profile
                  SalomonBottomBarItem(
                    icon:Image(image: AssetImage("assets/images/Chat.png"),
                    ),
                    title: Text("Chat"),
                    selectedColor: CommonColor.ORANGE_COLOR,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget TopBarLayout(double parentHeight, double parentWidth) {
    return
      Stack(
        children:[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image(
                  image: AssetImage("assets/images/design.png"),
                  color: Colors.white.withOpacity(0.4),
                  colorBlendMode: BlendMode.modulate,
                  height: parentHeight*0.12,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight*0.02),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: parentWidth*0.04),
                child: Image(
                  image: AssetImage("assets/images/menu_icon.png"),
                  height: parentHeight * 0.05,
                  width: parentWidth * 0.08,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: parentWidth*0.01),
                    child: Image(
                      image: AssetImage("assets/images/location.png"),
                      height: parentHeight * 0.05,
                      width: parentWidth * 0.05,
                    ),
                  ),
                  Text(
                    StringEn.LOCATION_NAME,
                    style: TextStyle(
                        color: CommonColor.HINT_TEXT_COLOR,
                        fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                        fontWeight: FontWeight.normal,
                        fontFamily: "RobotoCondensed-Regular"),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: parentWidth*0.05),
                child: Image(
                  image: AssetImage("assets/images/profile_img.png"),
                  height: parentHeight * 0.1,
                  width: parentWidth * 0.1,
                ),
              ),
            ],
        ),
          ),
      ]
      );
  }

  Widget SearchBar(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(right: parentWidth*0.05,left: parentWidth*0.08),
      child: Container(
        height: parentHeight * 0.05,
        decoration: BoxDecoration(
          color: CommonColor.ORANGE_COLOR.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
              prefixIcon:
              Padding(
                padding: EdgeInsets.only(left: parentWidth*0.04),
                child: Image(image: AssetImage("assets/images/search_icon.png"),
                ),
              ),
              hintText: StringEn.SEARCH,
              hintStyle: TextStyle(
                  color: CommonColor.BLACK_COLOR,
                  fontWeight: FontWeight.normal,
                  fontFamily: "RobotoCondensed-Regular",
                  fontSize: SizeConfig.blockSizeHorizontal * 4.2)
          ),
        ),
      ),
    );
  }

  Widget SpeacialOffer(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight*0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: parentHeight * 0.2,
            width: parentWidth*0.9,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  currentIndexSlider = index % images.length;
                });
              },
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      height: parentHeight*0.2,
                      width: parentWidth*0.9,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/Rectangle 384.png")
                      )
                    ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: parentHeight*0.02,left: parentWidth*0.01),
                                child: Text(
                                  StringEn.SPECIAL_OFFER,
                                  style: TextStyle(
                                      color: CommonColor.WHITE_COLOR,
                                      fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "RobotoSlab-Regular"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: parentHeight*0.01,left: parentWidth*0.04),
                                child: Text(
                                  StringEn.DESERT_INTOWN,
                                  style: TextStyle(
                                      color: CommonColor.WHITE_COLOR,
                                      fontSize: SizeConfig.blockSizeHorizontal * 3,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "RobotoCondensed-Regular"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: parentHeight*0.02,right: parentWidth*0.08),
                                child: Container(
                                  height: parentHeight*0.04,
                                  width: parentWidth*0.18,
                                  decoration: BoxDecoration(
                                    color: CommonColor.WHITE_COLOR,
                                    borderRadius: BorderRadius.circular(6)
                                  ),
                                    child: Center(
                                      child: Text(
                                          StringEn.BUY_NOW,
                                          style: TextStyle(
                                              color: CommonColor.ORANGE_COLOR,
                                              fontSize: SizeConfig.blockSizeHorizontal * 2.8,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "RobotoSlab-Regular"),
                                        ),
                                    ),
                                  ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: parentHeight*0.025,left: parentWidth*0.01),
                            child: Container(
                              height: parentHeight*0.17,
                              width: parentWidth*0.55,
                              decoration: BoxDecoration(image: DecorationImage(
                                    image: AssetImage("assets/images/burgers_img.png"),
                                  fit: BoxFit.cover,
                                ),

                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10)
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                ]
                );
              },
            ),
          ),
          SizedBox(
            height: parentHeight*0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < images.length; i++)
                buildIndicator(currentIndexSlider == i)
            ],
          ),
        ],
      ),
    );
  }

  Widget BuyNow(double parentHeight, double parentWidth) {
    return Container(
          height: parentHeight * 0.1,
          width: parentWidth * 0.1,
          decoration: BoxDecoration(
            color: CommonColor.ORANGE_COLOR.withOpacity(0.4),
            borderRadius: BorderRadius.circular(10),
          ),
      child:Text(
        StringEn.BUY_NOW,
        style: TextStyle(
            color: CommonColor.HINT_TEXT_COLOR,
            fontSize: SizeConfig.blockSizeHorizontal * 5,
            fontWeight: FontWeight.normal,
            fontFamily: "RobotoCondensed-Regular"),
      ) ,
    );
  }

  Widget FoodItems(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight*0.02),
      child: Container(
        height: parentHeight*0.05,
        width: parentWidth,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
              Padding(
                padding: EdgeInsets.only(left: parentWidth*0.05),
                child: Container(
                  height: parentHeight*0.05,
                  width: parentWidth*0.31,
                  decoration: BoxDecoration(
                    color: CommonColor.ORANGE_COLOR,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                          image: AssetImage("assets/images/burgericon.png"),
                        height: parentHeight*0.03,
                      ),
                      Text(
                        StringEn.BURGER,
                        style: TextStyle(
                            color: CommonColor.WHITE_COLOR,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.4,
                            fontWeight: FontWeight.normal,
                            fontFamily: "RobotoCondensed-Regular"),
                      )
                    ],
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(left: parentWidth*0.05),
              child: Container(
                height: parentHeight*0.06,
                width: parentWidth*0.31,
                decoration: BoxDecoration(
                    color: CommonColor.WHITE_COLOR,
                    borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: CommonColor.ORANGE_COLOR)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: parentHeight*0.01),
                      child: Image(
                        image: AssetImage("assets/images/pizzaicon.png"),
                        height: parentHeight*0.3,
                      ),
                    ),
                    Text(
                      StringEn.PIZZA,
                      style: TextStyle(
                          color: CommonColor.ORANGE_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 4.4,
                          fontWeight: FontWeight.normal,
                          fontFamily: "RobotoCondensed-Regular"
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: parentWidth*0.05),
              child: Container(
                height: parentHeight*0.06,
                width: parentWidth*0.31,
                decoration: BoxDecoration(
                    color: CommonColor.WHITE_COLOR,
                    border: Border.all(color: CommonColor.ORANGE_COLOR),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                      image: AssetImage("assets/images/hotdogicon.png"),
                      height: parentHeight*0.03,
                    ),
                    Text(
                      StringEn.SANDWICH,
                      style: TextStyle(
                          color: CommonColor.ORANGE_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal * 4.4,
                          fontWeight: FontWeight.normal,
                          fontFamily: "RobotoCondensed-Regular"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget FoodInfo(double parentHeight, double parentWidth) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: parentWidth*0.05,top: parentHeight*0.02),
          child: Container(
            height: parentHeight*0.28,
            width: parentWidth*0.4,
            decoration:BoxDecoration(
              color: CommonColor.WHITE_COLOR,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
              BoxShadow(
              color: CommonColor.HINT_TEXT_COLOR,
              offset: const Offset(1.0, 1.0),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
              ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: parentWidth*0.02,top: parentHeight*0.01),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: parentHeight*0.025,
                      ),
                      Text(
                        "3.8",
                        style: TextStyle(
                          color: CommonColor.BLACK_COLOR,
                          fontSize: SizeConfig.blockSizeHorizontal*4,
                          fontFamily: "RobotoCondensed-Regular",
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
                Image(
                    image: AssetImage("assets/images/burgerfirst.png")
                ),
                Text(
                  StringEn.CHICKEN_BURGER,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.blockSizeHorizontal*5,
                    fontFamily: "RobotoCondensed-Regular",
                    color: CommonColor.BLACK_COLOR
                  ),
                ),
                Text(
                  StringEn.INGREDIENT,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.blockSizeHorizontal*3.5,
                      fontFamily: "RobotoCondensed-Regular",
                      color: CommonColor.HINT_TEXT_COLOR
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          "\$",
                          style: TextStyle(
                            color: CommonColor.ORANGE_COLOR,
                            fontSize: SizeConfig.blockSizeHorizontal*4
                          ),

                        ),
                        Text(
                          "20.00",
                          style: TextStyle(
                              color: CommonColor.ORANGE_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal*4,
                            fontWeight: FontWeight.w600
                          ),

                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth*0.06),
                      child: Image(
                          image:AssetImage("assets/images/Group 3.png"),
                        height: parentHeight*0.04,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: parentWidth*0.1,top: parentHeight*0.02),
          child: Container(
            height: parentHeight*0.28,
            width: parentWidth*0.4,
            decoration:BoxDecoration(
                color: CommonColor.WHITE_COLOR,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: CommonColor.HINT_TEXT_COLOR,
                    offset: const Offset(1.0, 1.0),
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                  ),
                ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: parentWidth*0.02,top: parentHeight*0.01),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: parentHeight*0.025,
                      ),
                      Text(
                        "4.5",
                        style: TextStyle(
                            color: CommonColor.BLACK_COLOR,
                            fontSize: SizeConfig.blockSizeHorizontal*4,
                            fontFamily: "RobotoCondensed-Regular",
                            fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
                Image(
                    image: AssetImage("assets/images/burger.png")
                ),
                Text(
                  StringEn.CHESE_BURGER,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.blockSizeHorizontal*5,
                      fontFamily: "RobotoCondensed-Regular",
                      color: CommonColor.BLACK_COLOR
                  ),
                ),
                Text(
                  StringEn.INGREDIENTSEC,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.blockSizeHorizontal*3.5,
                      fontFamily: "RobotoCondensed-Regular",
                      color: CommonColor.HINT_TEXT_COLOR
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          "\$",
                          style: TextStyle(
                              color: CommonColor.ORANGE_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal*4
                          ),

                        ),
                        Text(
                          "15.00",
                          style: TextStyle(
                              color: CommonColor.ORANGE_COLOR,
                              fontSize: SizeConfig.blockSizeHorizontal*4,
                              fontWeight: FontWeight.w600
                          ),

                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth*0.06),
                      child: Image(
                        image:AssetImage("assets/images/Group 3.png"),
                        height: parentHeight*0.04,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ) ;
  }

  Widget PopularMenu(double parentHeight, double parentWidth) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: parentWidth*0.05,top: parentHeight*0.01),
              child: Text(
                StringEn.POPULAR_MEAL,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.blockSizeHorizontal*4,
                  color: CommonColor.BLACK_COLOR,
                  fontFamily: "RobotoCondensed-Regular"
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: parentWidth*0.05,top: parentHeight*0.01),
              child: Row(
                children: [
                  Text(
                    StringEn.SEE_ALL,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.blockSizeHorizontal*3.2,
                        color: CommonColor.HINT_TEXT_COLOR,
                        fontFamily: "RobotoCondensed-Regular"
                    ),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: CommonColor.HINT_TEXT_COLOR,
                  )
                ],
              ),
            )
          ],
        ),
        Padding(
          padding:EdgeInsets.only(top: parentHeight*0.01,bottom: parentHeight*0.02),
          child: Container(
            height: parentHeight*0.1,
            width: parentWidth*0.9,
            decoration:BoxDecoration(
                color: CommonColor.WHITE_COLOR,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: CommonColor.HINT_TEXT_COLOR,
                    offset: const Offset(1.0, 1.0),
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                  ),
                ]
            ),
            child: ListTile(
              leading: Image(
                  image: AssetImage("assets/images/Photo Menu.png")
              ),
              title: Text(
                StringEn.PEPPER_PIZZA,
                style: TextStyle(
                    color: CommonColor.BLACK_COLOR,
                    fontSize: SizeConfig.blockSizeHorizontal*6,
                    fontWeight: FontWeight.w500
                ),
              ),
              subtitle: Text(
                StringEn.PIZZA_BOX,
                style: TextStyle(
                    color: CommonColor.HINT_TEXT_COLOR,
                    fontSize: SizeConfig.blockSizeHorizontal*4,
                    fontWeight: FontWeight.normal
                ),
              ),
              trailing: Text(
                "\$15",
                style: TextStyle(
                  color: CommonColor.ORANGE_COLOR,
                  fontSize: SizeConfig.blockSizeHorizontal*7,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        )

      ],
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 12 : 10,
        width: isSelected ? 12 : 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? CommonColor.ORANGE_COLOR : Colors.grey,
        ),
      ),
    );
  }

}


