import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:core';
import 'package:fight_buddy/handlers/user.dart' as fightbuddy;
import 'dart:io';

import '../assets/theme/colors.dart';
import '../handlers/picture_handler.dart';
import '../handlers/user_handler.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        //Realtime updates of changes to users information
        stream: UserHandler.getUserStream(
            FirebaseAuth.instance.currentUser!.uid, FirebaseFirestore.instance),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            fightbuddy.User thisUser = fightbuddy.User.fromMap(
                ((snapshot.data) as DocumentSnapshot).data()
                    as Map<String, dynamic>);
            return Scaffold(
                backgroundColor: fightbuddyLightgreen,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(200),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(thisUser.coverPicture),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: fightbuddyLightgreen),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: const Text(
                                  "Byt bild",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onTap: () {
                                  changePicturePopup(
                                    "Byt omslagsbild",
                                    thisUser.coverPicture,
                                    "coverPicture",
                                  );
                                },
                              ),
                              const Icon(Icons.edit),
                              const SizedBox(width: 25),
                              Text(
                                "${thisUser.firstName} ${thisUser.lastName}",
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(thisUser.profilePicture),
                        ),
                        GestureDetector(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text("Byt bild",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline)),
                              Icon(Icons.edit)
                            ],
                          ),
                          onTap: () {
                            changePicturePopup("Byt profilbild",
                                thisUser.profilePicture, "profilePicture");
                          },
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: GestureDetector(
                              child: Row(children: const [
                                Text("Redigera",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline)),
                                Icon(Icons.edit),
                              ]),
                              onTap: () {
                                updateInformationPopUp(thisUser.information);
                              },
                            )),
                        Container(
                          width: 350,
                          height: 90,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 221, 223, 223),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Center(
                                child: Text(thisUser.information,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ))),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _box(thisUser.martialArts, " Kampsportsstilar", 350,
                            100),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            _box(thisUser.newMartialArts, " Vill prova", 180,
                                82),
                            _box1(thisUser.club, " Medlem i", 180, 168),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          }
          return Container();
        });
  }

  _box1(String list, String title, double size, double boxSize) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: size,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: fightbuddyDarkgreen, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                  height: 50,
                  child: Center(
                      child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          width: boxSize,
                          height: 5,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: fightbuddyDarkgreen, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(list),
                          ),
                        ),
                      );
                    },
                  ))),
            ],
          ),
        ));
  }

  _box(List<String> list, String title, double size, double boxSize) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: size,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: fightbuddyDarkgreen, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                  height: 50,
                  child: Center(
                      child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          width: boxSize,
                          height: 5,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: fightbuddyDarkgreen, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(list[index]),
                          ),
                        ),
                      );
                    },
                  ))),
            ],
          ),
        ));
  }

  changePicturePopup(String title, String currentPicture, String path) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 160,
                  height: 160,
                  child: Image.network(
                    currentPicture,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.white,
                    fixedSize: const Size(250, 50),
                  ),
                  child: const Text(
                    'Välj bild',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  onPressed: () async {
                    File pickedImage = await pickImageFromGallery();
                    UserHandler().deleteImage(currentPicture);
                    UserHandler().uploadImage(pickedImage, path);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.white,
                    fixedSize: const Size(250, 50),
                  ),
                  child: const Text(
                    'Ta en selfie',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  onPressed: () async {
                    File pickedImage = await pickImageFromCamera();
                    UserHandler().deleteImage(currentPicture);
                    UserHandler().uploadImage(pickedImage, path);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Avbryt',
                  style: TextStyle(color: fightbuddyLightgreen)),
            ),
          ],
        );
      },
    );
  }

  updateInformationPopUp(String information) {
    TextEditingController controller = TextEditingController();
    controller.text = information;
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Ändra information"),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  controller.value = controller.value.copyWith(
                    text: value,
                    selection: TextSelection.collapsed(offset: value.length),
                  );
                },
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                UserHandler().updateAboutYouInformation(controller.text);
                Navigator.of(context).pop();
              },
              child: const Text(
                "Uppdatera",
                style: TextStyle(color: fightbuddyLightgreen),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Avbryt',
                style: TextStyle(color: fightbuddyLightgreen),
              ),
            ),
          ],
        );
      },
    );
  }
}
