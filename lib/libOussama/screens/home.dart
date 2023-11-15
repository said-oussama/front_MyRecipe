import 'package:hungry/views/screens/home_page.dart';
import 'package:hungry/views/screens/page_switcher.dart';

import '../../libOussama/screens/ChangePasswordPage.dart';
import '../../libOussama/screens/wallet.dart';
import 'package:flutter/material.dart';
import '../../libOussama/core/api_client.dart';
import '../../libOussama/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../libOussama/utils/exports.dart';

import '../core/AppColor.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String accesstoken;
  final String token;

  //const HomeScreen({Key? key, required this.accesstoken}) : super(key: key);
  const HomeScreen({
    Key? key,
    required this.accesstoken,
    required this.token,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> getUserData() async {
    dynamic userRes;
    userRes = await _apiClient.getUserProfileData(widget.accesstoken);
    return userRes;
  }

  @override
  Widget build(BuildContext context) {
    String token = widget.token;
    print(token);
    print(token);

    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          elevation: 0,
          centerTitle: true,
          title: Text('My Profile',
              style: TextStyle(
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Edit',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
            ),
            
          ],
        ),
        //backgroundColor: Color.fromARGB(255, 255, 255, 255),
        backgroundColor: Colors
            .transparent, // Définissez la couleur de fond du Scaffold comme transparente
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/couver.jpg"), // Remplacez "votre_image.png" par le chemin de votre image
              fit: BoxFit.cover, // Pour que l'image couvre tout l'écran
            ),
          ),
          child: SizedBox(
              width: size.width,
              height: size.height,
              child: FutureBuilder<Map<String?, dynamic>>(
                future: getUserData(),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String?, dynamic>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        height: size.height,
                        width: size.width,
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    final data = snapshot.data;

                    if (data != null) {
                      final username = data['username'] as String?;
                      final email = data['email'] as String?;
                      final role = data['role'] as String?;
                      final code = data['code'] as String?;
                      final createdAt = data['createdAt'] as String?;
                      DateTime date = DateTime.parse(createdAt!);
                      // String formattedDate =
                      //     DateFormat('dd-MM-y \'at\' HH:mm').format(date);

                      return Container(
                        width: size.width,
                        height: size.height,
                        //color: Color.fromARGB(255, 11, 170, 77),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 50, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(0, 0, 0, 0),
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Image(
                                          image: AssetImage(
                                              'assets/images/eur.png'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    username ?? "username not found",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: Color.fromARGB(255, 10, 0, 0),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: MediaQuery.of(context)
                                        .size
                                        .width, // Largeur maximale de l'écran
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 170, 226,
                                          170), // Couleur du rectangle gris
                                      borderRadius: BorderRadius.circular(
                                          10), // Bords arrondis du rectangle
                                    ),
                                    child: Text(
                                      email ?? "email not found",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: MediaQuery.of(context)
                                        .size
                                        .width, // Largeur maximale de l'écran
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 170, 226,
                                          170), // Couleur du rectangle gris
                                      borderRadius: BorderRadius.circular(
                                          10), // Bords arrondis du rectangle
                                    ),
                                    child: Text(
                                      role ?? "role not found",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: MediaQuery.of(context)
                                        .size
                                        .width, // Largeur maximale de l'écran
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 170, 226,
                                          170), // Couleur du rectangle gris
                                      borderRadius: BorderRadius.circular(
                                          10), // Bords arrondis du rectangle
                                    ),
                                    child: Text(
                                      createdAt ?? "createdAt not found",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                ),

                                // const SizedBox(height: 20),
                                // Container(
                                //   width: size.width,
                                //   padding: const EdgeInsets.symmetric(
                                //       vertical: 10, horizontal: 10),
                                //   decoration: BoxDecoration(
                                //       color: Colors.white54,
                                //       borderRadius: BorderRadius.circular(5)),
                                //   child: const Text(' your recipes :',
                                //       style: TextStyle(
                                //           fontSize: 14,
                                //           color: Colors.black,
                                //           fontWeight: FontWeight.w700)),
                                // ),
                                // const SizedBox(height: 20),
                                // Container(
                                //     width: size.width,
                                //     padding: const EdgeInsets.symmetric(
                                //         vertical: 10, horizontal: 10),
                                //     decoration: BoxDecoration(
                                //         color: Colors.white54,
                                //         borderRadius: BorderRadius.circular(5)),
                                //     child: Column(children: [
                                //       const Image(
                                //           image: AssetImage("image/2.jpg")),
                                //       const Text('makrouna',
                                //           style: TextStyle(
                                //               fontSize: 14,
                                //               color: Colors.black,
                                //               fontWeight: FontWeight.w700)),
                                //     ])),
                                // const SizedBox(height: 20),
                                // Container(
                                //     width: size.width,
                                //     padding: const EdgeInsets.symmetric(
                                //         vertical: 10, horizontal: 10),
                                //     decoration: BoxDecoration(
                                //         color: Colors.white54,
                                //         borderRadius: BorderRadius.circular(5)),
                                //     child: Column(children: [
                                //       const Image(
                                //           image: AssetImage("image/pizza.jpg")),
                                //       const Text('pizza',
                                //           style: TextStyle(
                                //               fontSize: 14,
                                //               color: Colors.black,
                                //               fontWeight: FontWeight.w700)),
                                //     ])),
                                // const SizedBox(height: 20),
                                // Container(
                                //     width: size.width,
                                //     padding: const EdgeInsets.symmetric(
                                //         vertical: 10, horizontal: 10),
                                //     decoration: BoxDecoration(
                                //         color: Colors.white54,
                                //         borderRadius: BorderRadius.circular(5)),
                                //     child: Column(children: [
                                //       const Image(
                                //           image:
                                //               AssetImage("image/recom1.jpg")),
                                //       const Text('mekla bnina',
                                //           style: TextStyle(
                                //               fontSize: 14,
                                //               color: Colors.black,
                                //               fontWeight: FontWeight.w700)),
                                //     ])),
                                // const SizedBox(height: 20),
                                // Container(
                                //     width: size.width,
                                //     padding: const EdgeInsets.symmetric(
                                //         vertical: 10, horizontal: 10),
                                //     decoration: BoxDecoration(
                                //         color: Colors.white54,
                                //         borderRadius: BorderRadius.circular(5)),
                                //     child: Column(children: [
                                //       const Image(
                                //           image:
                                //               AssetImage("image/recom2.jpg")),
                                //       const Text('By T-shirt',
                                //           style: TextStyle(
                                //               fontSize: 14,
                                //               color: Colors.black,
                                //               fontWeight: FontWeight.w700)),
                                //     ])),
                                const SizedBox(
                                  height: 30,
                                  width: 50,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ChangePasswordPage(
                                          userEmail: email ?? ''),
                                    ));
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    side: BorderSide(
                                        color:
                                            AppColor.secondary.withOpacity(0.5),
                                        width: 1),
                                    backgroundColor: Color(0xFF107873),
                                  ),
                                  child: Text('Change Password',
                                      style: TextStyle(
                                          color: AppColor.secondary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'inter')),
                                ),
                                // const SizedBox(
                                //   height: 30,
                                //   width: 50,
                                // ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          PageSwitcher(token: token
                                              //userEmail: email ?? ''
                                              ),
                                    ));
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    side: BorderSide(
                                        color:
                                            AppColor.secondary.withOpacity(0.5),
                                        width: 1),
                                    backgroundColor: Color(0xFF107873),
                                  ),
                                  child: Text('acceuil',
                                      style: TextStyle(
                                          color: AppColor.secondary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'inter')),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    side: BorderSide(
                                        color:
                                            AppColor.secondary.withOpacity(0.5),
                                        width: 1),
                                    backgroundColor: Color(0xFF107873),
                                  ),
                                  child: Text('Logout',
                                      style: TextStyle(
                                          color: AppColor.secondary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'inter')),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    debugPrint(snapshot.error.toString());
                  }
                  return const SizedBox();
                },
              )),
        ));
  }
}
