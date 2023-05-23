import 'package:flutter/material.dart';
import 'package:fight_buddy/handlers/user.dart' as fightbuddy;
import '../assets/theme/colors.dart';

class MatchProfilePage extends StatefulWidget {
  final fightbuddy.User user;
  const MatchProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  MatchProfilePageState createState() => MatchProfilePageState();
}

class MatchProfilePageState extends State<MatchProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fightbuddy.User user = widget.user;
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
                  image: NetworkImage(user.profilePicture),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100))),
          child: Column(
            children: [
              Container(
                child: _userCard(user, context),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                  ),
                  Icon(Icons.abc),
                  Icon(Icons.add_chart_sharp)
                ],
              ),
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
                      child: Text(user.information,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _box(user.martialArts, " Kampsportsstilar", 350, 100),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  _box(user.newMartialArts, " Vill prova", 180, 81),
                  _box(user.club, " Medlem i", 180, 82),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ));
  }
}

_box(List<String> list, String title, double size, double boxSize) {
  return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: size,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                          border:
                              Border.all(color: fightbuddyDarkgreen, width: 2),
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

Widget _userCard(fightbuddy.User user, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.profilePicture),
            ),
            tileColor: Colors.white,
            title: Text(
              "${user.firstName} ${user.lastName}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            subtitle: Text(
                "${user.age} år   ${user.weight}kg   ${user.gender}    ${user.place}",
                style: const TextStyle(
                  color: Colors.black,
                )),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ],
      ));
}
