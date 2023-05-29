import 'dart:io';
import 'package:fight_buddy/handlers/user_handler.dart';
import 'package:fight_buddy/handlers/picture_handler.dart';
import 'package:fight_buddy/screens/registration/aboutyou.dart';
import 'package:fight_buddy/screens/registration/coverpicture.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfilePicture(),
    );
  }
}

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  ProfilePictureState createState() => ProfilePictureState();
}

class ProfilePictureState extends State<ProfilePicture> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(3, 137, 129, 50), //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.white10,
          //Någon titeltext?
          title: const Text(""),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  //Hoppa över och gå vidare
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutYouPage()));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    backgroundColor: Colors.white,
                    minimumSize: const Size(160, 10)),
                child: const Text(
                  "Hoppa över",
                  style: TextStyle(
                    color: Color.fromRGBO(3, 137, 129, 50),
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ]),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          const Text('Lägg till en profilbild',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 100,
          ),
          image != null
              ? Image.file(
                  image!,
                  width: 160,
                  height: 160,
                )
              : Image.asset(
                  'lib/assets/images/face.png',
                  fit: BoxFit.contain,
                  height: 150,
                ),
          const SizedBox(
            height: 50,
          ),
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
              setState(() {
                image = pickedImage;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Colors.white,
              fixedSize: const Size(250, 50),
            ),
            child: const Text('Ta en selfie',
                style: TextStyle(color: Colors.black54, fontSize: 15)),
            onPressed: () async {
              File pickedImage = await pickImageFromCamera();
              setState(() {
                image = pickedImage;
              });
            },
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: const Color.fromRGBO(3, 137, 129, 50),
                        fixedSize: const Size(250, 50),
                      ),
                      onPressed: () {
                        UserHandler().uploadImage(image!, "profilePicture");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CoverPicture()));
                      },
                      child: const Text('Gå vidare',
                          style: TextStyle(fontSize: 20))))),
          const SizedBox(
            height: 25,
          ),
        ],
      )),
    );
  }
}
