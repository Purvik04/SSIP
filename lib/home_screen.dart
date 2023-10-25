// ignore_for_file: prefer_const_constructors

import 'package:arogya_mitra/widgets/carousle_slider.dart';
import 'package:arogya_mitra/widgets/common_row.dart';
import 'package:arogya_mitra/widgets/search_bar.dart';
import 'package:arogya_mitra/widgets/service_circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  int _currentIndex = 0;
  Widget build(BuildContext context) {
    double kheight = MediaQuery.of(context).size.height;
    double kwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: SizedBox(),
        elevation: 0,
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              ),
              Text("Anna Ainsley",
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications,
                    color: Colors.black, size: 25)),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: kheight * 0.005,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: SearchBarWidget(),
              ),
              SizedBox(
                height: kheight * 0.01,
              ),
              Carousel(
                  imgURL1:
                      "https://media.istockphoto.com/vectors/prevention-of-covid19-infographic-poster-with-doctor-coronavirus-vector-id1216365040",
                  imgURL2:
                      "https://th.bing.com/th/id/OIP._KZBxvAp2wGHuMYrq6HBXQHaEW?pid=ImgDet&rs=1",
                  imgURL3:
                      "https://media.istockphoto.com/vectors/children-vaccination-and-immunization-concept-poster-doctor-with-vector-id1184156931?k=6&m=1184156931&s=170667a&w=0&h=X9NgWghAubwZCh1jBFbrlRIGrinN_gJ1jkK6wh5nNr8=",
                  Name1: "",
                  Name2: "",
                  Name3: ""),
              SizedBox(
                height: kheight * 0.015,
              ),
              CommonRowWidget(text: "Services", onTap: () {}),
              Container(
                height: kheight * 0.24,
                width: kwidth * 0.93,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 1,
                          offset: Offset(1, 1)),
                    ],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ServiceCircleWidget(
                            radius: 24,
                            onTap: () {},
                            text: "Disease",
                            imgUrl: "assets/images/mask.png"),
                        SizedBox(
                          width: kwidth * 0.1,
                        ),
                        ServiceCircleWidget(
                            radius: 24,
                            onTap: () {},
                            text: "Hospital",
                            imgUrl: "assets/images/hospital.png"),
                        SizedBox(
                          width: kwidth * 0.1,
                        ),
                        ServiceCircleWidget(
                            radius: 20,
                            onTap: () {},
                            text: "Test",
                            imgUrl: "assets/images/blood-test.png"),
                        SizedBox(
                          width: kwidth * 0.1,
                        ),
                        ServiceCircleWidget(
                            radius: 21,
                            onTap: () {},
                            text: "Clinic",
                            imgUrl: "assets/images/clinic.png"),
                      ],
                    ),
                    SizedBox(
                      height: kheight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ServiceCircleWidget(
                            radius: 24,
                            onTap: () {},
                            text: "Exersice",
                            imgUrl: "assets/images/treadmill.png"),
                        SizedBox(
                          width: kwidth * 0.1,
                        ),
                        ServiceCircleWidget(
                            radius: 24,
                            onTap: () {},
                            text: "Diet",
                            imgUrl: "assets/images/diet.png"),
                        SizedBox(
                          width: kwidth * 0.1,
                        ),
                        ServiceCircleWidget(
                            radius: 23,
                            onTap: () {},
                            text: "Vaccine",
                            imgUrl: "assets/images/vaccines.png"),
                        SizedBox(
                          width: kwidth * 0.1,
                        ),
                        ServiceCircleWidget(
                            radius: 24,
                            onTap: () {},
                            text: "Diabetes",
                            imgUrl: "assets/images/diet.png"),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: Color(0xFF0856DE),
        itemPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.home,
            ),
            title: const Text("Home"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.local_hospital,
            ),
            title: const Text("Hospital"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.message),
            title: const Text("Chat"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
          ),
        ],
      ),
    );
  }
}