import 'dart:async';

import 'package:chatty/providers/auth_provider.dart';
import 'package:chatty/screens/chat/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchTextController = TextEditingController();
  StreamController<bool> btnClearController = StreamController<bool>();
  String _textSearch = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthNotifier>(context, listen: false).logout(context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // StreamBuilder<QuerySnapshot>(
            //   stream: FirebaseFirestore.instance
            //       .collection('users')
            //       .snapshots(),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<QuerySnapshot> snapshot) {
            //     if (snapshot.hasError) {
            //       return const Text('Something went wrong');
            //     }

            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(
            //         child: Text("Loading"),
            //       );
            //     }

            //     return Expanded(
            //       child: ListView.builder(
            //           itemCount: snapshot.data!.docs.length,
            //           itemBuilder: (context, index) {
            //             final data = snapshot.data!.docs[index];
            //             return GestureDetector(
            //               onTap: () {
            //                 Navigator.of(context).push(
            //                   MaterialPageRoute(
            //                     builder: (context) => ChatScreen(
            //                       name: data['name'].toString(),
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Container(
            //                 decoration: const BoxDecoration(),
            //                 //padding: Ed,
            //                 width: MediaQuery.of(context).size.width,
            //                 child: ListTile(
            //                   title: Text(
            //                     data['name'],
            //                   ),
            //                   subtitle: Text(
            //                     data['email'],
            //                   ),
            //                   leading: const CircleAvatar(
            //                     radius: 30,
            //                     backgroundImage: NetworkImage(
            //                         'https://pixlr.com/images/index/remove-bg.webp'),
            //                   ),
            //                 ),
            //               ),
            //             );
            //           }),
            //     );
            //     // return ListView(
            //     //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
            //     //     Map<String, dynamic> data =
            //     //         document.data()! as Map<String, dynamic>;
            //     //     return GestureDetector(
            //     //       onTap: () {
            //     //         Navigator.of(context).push(
            //     //           MaterialPageRoute(
            //     //             builder: (context) => ChatScreen(name: ),
            //     //           ),
            //     //         );
            //     //       },
            //     //       child: Container(
            //     //         decoration: const BoxDecoration(),
            //     //         //padding: Ed,
            //     //         width: MediaQuery.of(context).size.width,
            //     //         child: ListTile(
            //     //           title: Text(
            //     //             data['name'],
            //     //           ),
            //     //           subtitle: Text(
            //     //             data['email'],
            //     //           ),
            //     //           leading: const CircleAvatar(
            //     //             radius: 30,
            //     //             backgroundImage: NetworkImage(
            //     //                 'https://pixlr.com/images/index/remove-bg.webp'),
            //     //           ),
            //     //         ),
            //     //       ),
            //     //     );
            //     //   }).toList(),
            //     // );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchField() {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.person_search,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.search,
              controller: searchTextController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  btnClearController.add(true);
                  setState(() {
                    _textSearch = value;
                  });
                } else {
                  btnClearController.add(false);
                  setState(() {
                    _textSearch = '';
                  });
                }
              },
              decoration: const InputDecoration.collapsed(
                hintText: 'Search Here..',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          StreamBuilder(
            stream: btnClearController.stream,
            builder: (context, snapshot) {
              return snapshot.data == true
                  ? GestureDetector(
                      onTap: () {
                        searchTextController.clear();
                        btnClearController.add(false);
                        setState(
                          () {
                            _textSearch = '';
                          },
                        );
                      },
                      child: const Icon(
                        Icons.clear_rounded,
                        color: Colors.grey,
                        size: 20,
                      ),
                    )
                  : const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
