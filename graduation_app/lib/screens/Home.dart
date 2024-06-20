import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:graduation_app/screens/services/Alzheimer_screen.dart';
import 'package:graduation_app/screens/services/Brain%20tumor_screen.dart';
import 'package:graduation_app/screens/services/Brain_Stroke_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List imgList = [
    'assets/images/Alzheimer_.png',
    'assets/images/Brain tumor_.png',
    'assets/images/brain stroke.png',
  ];
  List nameList = [
    'Detection of Alzheimer\'s Disease',
    'Brain Tumor Detection',
    'Brain Stroke Detection',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: const BoxDecoration(
              color: Color(0xff150A28),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 15),
                  child: Text(
                    "Hi, Khaled",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      wordSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search here....",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 25,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Services",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff150A28),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  itemCount: imgList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio:
                        (MediaQuery.of(context).size.height - 100 - 50) /
                            (2.7 * 111),
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Material(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffE5E5EB),
                            //color: Colors.black,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Image.asset(
                                      imgList[
                                          index], // Replace with your image path
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  //SizedBox(height: 5),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        nameList[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                  ),

                                  //SizedBox(height: 5),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  if (nameList[index] ==
                                      'Detection of Alzheimer\'s Disease') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AlzheimerDiseseService()),
                                    );
                                  } else if (nameList[index] ==
                                      'Brain Tumor Detection') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BrainTumorService()),
                                    );
                                  } else if (nameList[index] ==
                                      'Brain Stroke Detection') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Brain_Stroke_Service()),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(11),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff2A1B45),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'Explore',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
