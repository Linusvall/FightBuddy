import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'package:fight_buddy/functions/styles.dart';
import 'package:fight_buddy/functions/widgets.dart';
import 'package:fight_buddy/functions/searchfield.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ChatMainPage extends StatefulWidget {
  const ChatMainPage({Key? key}) : super(key: key);

  @override
  State<ChatMainPage> createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {
  final firestore = FirebaseFirestore.instance;
  bool open = false;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('sv_SE', null);
    Intl.defaultLocale = 'sv_SE';
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 182, 170, 100),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*
                Container(
                  color: const Color.fromRGBO(0, 182, 170, 100),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: SearchFieldWidget(
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                */
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: Styles.friendsBox(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(0),
                          child: Container(
                            color: const Color.fromRGBO(255, 255, 255, 100),
                            padding: const EdgeInsets.all(8),
                            height: 140,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  height: 80,
                                  child: StreamBuilder(
                                    stream: firestore
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      }

                                      List savedUsers =
                                          snapshot.data!['savedUsers'] ?? [];

                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: savedUsers.length,
                                        itemBuilder: (context, i) {
                                          String user = savedUsers[i];
                                          return FutureBuilder(
                                            future: firestore
                                                .collection('users')
                                                .doc(user)
                                                .get(),
                                            builder:
                                                (context, AsyncSnapshot snap) {
                                              if (!snap.hasData) {
                                                return Container();
                                              }
                                              var userData = snap.data;
                                              return ChatUI.profileCircle(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return ChatPage(
                                                          id: user,
                                                          name: userData[
                                                              'firstName'],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                                name:
                                                    '${userData['firstName']} ${userData['lastName']}',
                                                coverPicture:
                                                    userData['profilePicture'],
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          child: Text(
                            'Senaste konversationerna',
                            style: Styles.h1().copyWith(color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: StreamBuilder(
                              stream: firestore.collection('rooms').snapshots(),
                              builder: (context, snapshot) {
                                List data = !snapshot.hasData
                                    ? []
                                    : snapshot.data!.docs
                                        .where((element) => element['users']
                                            .toString()
                                            .contains(FirebaseAuth
                                                .instance.currentUser!.uid))
                                        .toList();
                                return ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, i) {
                                    List users = data[i]['users'];
                                    var friend = users.where((element) =>
                                        element !=
                                        FirebaseAuth.instance.currentUser!.uid);
                                    var user = friend.isNotEmpty
                                        ? friend.first
                                        : users
                                            .where((element) =>
                                                element ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid)
                                            .first;
                                    return FutureBuilder(
                                      future: firestore
                                          .collection('users')
                                          .doc(user)
                                          .get(),
                                      builder: (context, AsyncSnapshot snap) {
                                        if (!snap.hasData) {
                                          return Container();
                                        }
                                        var userData = snap.data;
                                        return ChatUI.personCard(
                                          title:
                                              '${userData['firstName']} ${userData['lastName']}',
                                          subtitle: data[i]['last_message'],
                                          time: DateFormat('EEE HH:mm').format(
                                              data[i]['last_message_time']
                                                  .toDate()),
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return ChatPage(
                                                    id: user,
                                                    name:
                                                        '${userData['firstName']} ${userData['lastName']}',
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          coverPicture:
                                              userData['coverPicture'],
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
