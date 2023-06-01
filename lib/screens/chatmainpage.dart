import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'package:fight_buddy/functions/widgets.dart';
import 'package:fight_buddy/functions/searchfield.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:fight_buddy/functions/styles.dart';

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
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 182, 170, 100),
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(25.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SearchFieldWidget(
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(children: [
        SearchFieldWidget(width: MediaQuery.of(context).size.width),
        SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    height: 80,
                                    child: StreamBuilder(
                                      stream: firestore
                                          .collection('rooms')
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        List data = !snapshot.hasData
                                            ? []
                                            : snapshot.data!.docs
                                                .where((element) =>
                                                    element['users']
                                                        .toString()
                                                        .contains(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid))
                                                .toList();
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: data.length,
                                          itemBuilder: (context, i) {
                                            List users = data[i]['users'];
                                            var friend = users.where(
                                                (element) =>
                                                    element !=
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid);
                                            var user = friend.isNotEmpty
                                                ? friend.first
                                                : users
                                                    .where((element) =>
                                                        element ==
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid)
                                                    .first;
                                            return FutureBuilder(
                                              future: firestore
                                                  .collection('users')
                                                  .doc(user)
                                                  .get(),
                                              builder: (context,
                                                  AsyncSnapshot snap) {
                                                return !snap.hasData
                                                    ? Container()
                                                    : ChatUI.profileCircle(
                                                        coverPicture: snap.data[
                                                            'coverPicture'],
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return ChatPage(
                                                                  id: user,
                                                                  name:
                                                                      '${snap.data['firstName']} ${snap.data['lastName']}',
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        },
                                                        name:
                                                            '${snap.data['firstName']} ${snap.data['lastName']}');
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
                                stream:
                                    firestore.collection('rooms').snapshots(),
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
                                          FirebaseAuth
                                              .instance.currentUser!.uid);
                                      var user = friend.isNotEmpty
                                          ? friend.first
                                          : users
                                              .where((element) =>
                                                  element ==
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid)
                                              .first;
                                      return FutureBuilder(
                                        future: firestore
                                            .collection('users')
                                            .doc(user)
                                            .get(),
                                        builder: (context, AsyncSnapshot snap) {
                                          return !snap.hasData
                                              ? Container()
                                              : ChatUI.personCard(
                                                  title:
                                                      '${snap.data['firstName']} ${snap.data['lastName']}',
                                                  subtitle: data[i]
                                                      ['last_message'],
                                                  time: DateFormat('EEE hh:mm')
                                                      .format(data[i][
                                                              'last_message_time']
                                                          .toDate()),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return ChatPage(
                                                            id: user,
                                                            name: snap.data[
                                                                'firstName'],
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  coverPicture:
                                                      snap.data['coverPicture'],
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
      ]),
    );
  }
}
