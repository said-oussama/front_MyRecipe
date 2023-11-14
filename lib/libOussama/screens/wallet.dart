// import 'package:flutter/material.dart';
// import 'package:solana_wallets_flutter/solana_wallets_flutter.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Solana Wallet Demo',
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String _walletAddress = '';

//   Future<void> _connectToWallet() async {
//     final SolanaWalletsFlutter wallet = SolanaWalletsFlutter();
//     final String? walletAddress = await wallet.connectToWallet();

//     if (walletAddress != null) {
//       setState(() {
//         _walletAddress = walletAddress;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Solana Wallet Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Wallet Address:',
//             ),
//             Text(
//               _walletAddress,
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _connectToWallet,
//         tooltip: 'Connect to Wallet',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
