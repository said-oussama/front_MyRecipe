// import 'package:flutter/material.dart';
// import 'package:Haven/core/api_client.dart';
// import 'package:Haven/screens/login_screen.dart';
// import 'package:intl/intl.dart';

// class HomeScreen extends StatefulWidget {
//   final String accesstoken;
//   const HomeScreen({Key? key, required this.accesstoken}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final ApiClient _apiClient = ApiClient();

//   Future<Map<String, dynamic>> getUserData() async {
//     dynamic userRes;
//     userRes = await _apiClient.getUserProfileData(widget.accesstoken);
//     return userRes;
//   }

// // Future<void> logout() async {
// //   await _apiClient.logout(widget.accesstoken);
// //   Navigator.pushReplacement(
// //       context, MaterialPageRoute(builder: (context) => const LoginScreen()));
// // }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SizedBox(
//           width: size.width,
//           height: size.height,
//           child: FutureBuilder<Map<String?, dynamic>>(
//             future: getUserData(),
//             builder: (BuildContext context,
//                 AsyncSnapshot<Map<String?, dynamic>> snapshot) {
//               if (snapshot.hasData) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Container(
//                     height: size.height,
//                     width: size.width,
//                     color: Colors.blueGrey,
//                     child: const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//                 }
//                 final data = snapshot.data;
//                 // String fullName = snapshot.data!['FullName'];
//                 // String firstName = snapshot.data!['FirstName'];
//                 // String lastName = snapshot.data!['LastName'];
//                 // String birthDate = snapshot.data!['BirthDate'];
//                 // String email = snapshot.data!['Email'][0]['Value'];
//                 // String gender = snapshot.data!['Gender'];
//                 if (data != null) {
//                   final username = data['username'] as String?;
//                   final email = data['email'] as String?;
//                   final role = data['role'] as String?;
//                   final createdAt = data['createdAt'] as String?;
//                   DateTime date = DateTime.parse(createdAt!);
//                   String formattedDate =
//                       DateFormat('dd-MM-y \'at\' HH:mm').format(date);

//                   //final birthDate = data['otpcode'] as String?;
//                   //final email = data['email'] as String?; //?[0]['Value']
//                   //final gender = data['updatedAt'] as String?;

//                   return Container(
//                     width: size.width,
//                     height: size.height,
//                     color: Colors.blueGrey.shade400,
//                     child: SingleChildScrollView(
//                       physics: const BouncingScrollPhysics(),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 50, horizontal: 20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Align(
//                               alignment: Alignment.topCenter,
//                               child: Container(
//                                 padding: const EdgeInsets.all(5),
//                                 clipBehavior: Clip.hardEdge,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.transparent,
//                                   border: Border.all(
//                                       width: 1, color: Colors.blue.shade100),
//                                 ),
//                                 child: Container(
//                                   height: 100,
//                                   width: 100,
//                                   clipBehavior: Clip.hardEdge,
//                                   decoration: const BoxDecoration(
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: const Image(
//                                       image: AssetImage('assets/image.png'),
//                                       fit: BoxFit.cover),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Align(
//                               alignment: Alignment.topCenter,
//                               child: Text(
//                                 username ?? "username not found",
//                                 style: const TextStyle(
//                                     fontSize: 25,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Align(
//                               alignment: Alignment.topCenter,
//                               child: Text(
//                                 email ?? "mail not found",
//                                 style: const TextStyle(
//                                     fontSize: 18, color: Colors.black),
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Container(
//                               width: size.width,
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 10, horizontal: 10),
//                               decoration: BoxDecoration(
//                                   color: Colors.white54,
//                                   borderRadius: BorderRadius.circular(5)),
//                               child: const Text('PROFILE DETAILS',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w700)),
//                             ),
//                             const SizedBox(height: 20),
//                             Container(
//                               width: size.width,
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 5, horizontal: 5),
//                               decoration: BoxDecoration(
//                                   color: const Color(0xFF48484A),
//                                   borderRadius: BorderRadius.circular(5)),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text('Role:',
//                                       style: TextStyle(
//                                           fontSize: 16, color: Colors.white38)),
//                                   const SizedBox(height: 7),
//                                   Text(role ?? "role not defined",
//                                       style: const TextStyle(
//                                           fontSize: 19, color: Colors.white)),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Container(
//                               width: size.width,
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 5, horizontal: 5),
//                               decoration: BoxDecoration(
//                                   color: const Color(0xFF48484A),
//                                   borderRadius: BorderRadius.circular(5)),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text('Creation date: ',
//                                       style: TextStyle(
//                                           fontSize: 16, color: Colors.white38)),
//                                   const SizedBox(height: 7),
//                                   Text(formattedDate,
//                                       style: const TextStyle(
//                                           fontSize: 19, color: Colors.white)),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             // Container(
//                             //   width: size.width,
//                             //   padding: const EdgeInsets.symmetric(
//                             //       vertical: 5, horizontal: 5),
//                             //   decoration: BoxDecoration(
//                             //       color: const Color(0xFF48484A),
//                             //       borderRadius: BorderRadius.circular(5)),
//                             //   child: Column(
//                             //     mainAxisSize: MainAxisSize.min,
//                             //     mainAxisAlignment: MainAxisAlignment.start,
//                             //     crossAxisAlignment: CrossAxisAlignment.start,
//                             //     children: [
//                             //       const Text('Birthday:',
//                             //           style: TextStyle(
//                             //               fontSize: 16, color: Colors.white38)),
//                             //       const SizedBox(height: 7),
//                             //       Text(birthDate ?? "birthdate not found",
//                             //           style: const TextStyle(
//                             //               fontSize: 19, color: Colors.white)),
//                             //     ],
//                             //   ),
//                             // ),
//                             // const SizedBox(height: 20),
//                             // Container(
//                             //   width: size.width,
//                             //   padding: const EdgeInsets.symmetric(
//                             //       vertical: 5, horizontal: 5),
//                             //   decoration: BoxDecoration(
//                             //       color: const Color(0xFF48484A),
//                             //       borderRadius: BorderRadius.circular(5)),
//                             //   child: Column(
//                             //     mainAxisSize: MainAxisSize.min,
//                             //     mainAxisAlignment: MainAxisAlignment.start,
//                             //     crossAxisAlignment: CrossAxisAlignment.start,
//                             //     children: [
//                             //       const Text('Gender:',
//                             //           style: TextStyle(
//                             //               fontSize: 16, color: Colors.white38)),
//                             //       const SizedBox(height: 7),
//                             //       Text(gender ?? "gender not found",
//                             //           style: const TextStyle(
//                             //               fontSize: 19, color: Colors.white)),
//                             //     ],
//                             //   ),
//                             // ),
//                             // const SizedBox(height: 20),

//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                                 // Navigator.pushReplacement(
//                                 //     context,
//                                 //     MaterialPageRoute(
//                                 //         builder: (context) =>
//                                 //             const LoginScreen()));
//                               },
//                               style: TextButton.styleFrom(
//                                   backgroundColor: Colors.redAccent.shade700,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(5)),
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 15, horizontal: 25)),
//                               child: const Text(
//                                 'Logout',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//               } else {
//                 debugPrint(snapshot.error.toString());
//               }
//               return const SizedBox();
//             },
//           )),
//     );
//   }
// }
