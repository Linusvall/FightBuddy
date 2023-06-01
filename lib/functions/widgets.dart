import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'searchfield.dart';
import 'styles.dart';

class ChatUI {
  static Widget personCard({
    title,
    time,
    subtitle,
    onTap,
    String? coverPicture,
    bool isOnline = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        elevation: 0,
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.all(5),
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: coverPicture != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          coverPicture,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.white,
                      ),
              ),
              if (isOnline)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                ),
            ],
          ),
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle) : null,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(time),
          ),
        ),
      ),
    );
  }

  static Widget profileCircle({onTap, name, String? coverPicture}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: coverPicture != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(coverPicture),
                      )
                    : null,
              ),
              child: coverPicture == null
                  ? const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(height: 5),
            Text(
              name,
              style: const TextStyle(
                height: 1.5,
                fontSize: 12,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  static Widget chatBox(bool check, message, time, String userId) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('User data not found');
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>?;
        final coverPicture = userData?['coverPicture'];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!check) const Spacer(),
              if (check)
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(242, 242, 247, 90),
                  radius: 13,
                  child: coverPicture != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(coverPicture),
                          radius: 13,
                        )
                      : const Icon(
                          Icons.person,
                          size: 13,
                          color: Colors.white,
                        ),
                ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 250),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(10),
                  decoration: Styles.messagesCardStyle(check),
                  child: Text(
                    '$message\n\n$time',
                    style:
                        TextStyle(color: check ? Colors.black : Colors.black),
                  ),
                ),
              ),
              if (!check)
                const CircleAvatar(
                  backgroundColor: Color.fromRGBO(209, 209, 214, 90),
                  radius: 13,
                  child: Icon(
                    Icons.person,
                    size: 13,
                    color: Colors.white,
                  ),
                ),
              if (check) const Spacer(),
            ],
          ),
        );
      },
    );
  }

  static messageField({required onSubmit}) {
    final con = TextEditingController();
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: Styles.messageCardStyle(),
      child: TextField(
        controller: con,
        decoration: Styles.messageFieldStyle(onSubmit: () {
          onSubmit(con);
        }),
      ),
    );
  }

  static searchField(
      {Function(String)? onChange, Function(bool)? onFocusChange}) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: Styles.messageCardStyle(),
      child: TextField(
        onChanged: onChange,
        decoration: Styles.searchTextFieldStyle(),
        onTap: () {
          onFocusChange?.call(true);
        },
        onEditingComplete: () {
          onFocusChange?.call(false);
        },
      ),
    );
  }

  static Widget searchResultsDropdown(
      {List<Map<String, dynamic>>? results,
      Function(Map<String, dynamic>)? onSelect}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: Styles.messageCardStyle(),
      child: Column(
        children: results!.map((result) {
          String fullName = '${result['firstName']} ${result['lastName']}';
          return ListTile(
            title: Text(fullName),
            onTap: () {
              onSelect!(result);
            },
          );
        }).toList(),
      ),
    );
  }
}
