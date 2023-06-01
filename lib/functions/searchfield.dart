import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/chat.dart';
import 'widgets.dart';

class SearchFieldWidget extends StatefulWidget {
  final double width;

  const SearchFieldWidget({Key? key, required this.width}) : super(key: key);

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final firestore = FirebaseFirestore.instance;
  final controller = TextEditingController();
  String search = '';
  bool show = false;
  bool isSearchFieldFocused = false;
  double dialogHeight = 0;
  int matchingUsersCount = 0;

  double _calculateDialogHeight() {
    const double maxUserHeight = 4 * 70;
    const double appBarHeight = 70;
    const double searchFieldHeight = 36.0;

    double height = appBarHeight;

    if (isSearchFieldFocused) {
      if (matchingUsersCount > 0) {
        height +=
            matchingUsersCount > 5 ? maxUserHeight : matchingUsersCount * 90;
      } else {
        height += searchFieldHeight;
      }
    } else {
      if (search.isEmpty) {
        height = appBarHeight;
      }
    }

    return height;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore.collection('users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List data = !snapshot.hasData
            ? []
            : snapshot.data!.docs
                .where((element) =>
                    RegExp(search, caseSensitive: false)
                        .hasMatch(element['firstName']) ||
                    RegExp(search, caseSensitive: false)
                        .hasMatch(element['lastName']))
                .toList();

        matchingUsersCount = data.length;

        if (dialogHeight != _calculateDialogHeight()) {
          Timer(const Duration(milliseconds: 200), () {
            setState(() {
              dialogHeight = _calculateDialogHeight();
              show = dialogHeight > 0;
            });
          });
        }

        return Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: dialogHeight,
              width: widget.width,
              decoration: BoxDecoration(
                color: widget.width == 0
                    ? const Color.fromRGBO(0, 182, 170, 100)
                    : const Color.fromRGBO(100, 182, 170, 100),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(widget.width == 0 ? 100 : 0),
                  bottomRight: Radius.circular(widget.width == 0 ? 100 : 0),
                  bottomLeft: Radius.circular(widget.width == 0 ? 100 : 0),
                ),
              ),
              child: widget.width == 0
                  ? null
                  : !show
                      ? null
                      : Column(
                          children: [
                            ChatUI.searchField(
                              onChange: (a) {
                                setState(() {
                                  search = a;
                                });
                              },
                              onFocusChange: (hasFocus) {
                                setState(() {
                                  isSearchFieldFocused = hasFocus;
                                });
                              },
                            ),
                            if (isSearchFieldFocused)
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: dialogHeight - 36.0,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, i) {
                                      return ChatUI.searchFieldPersonCard(
                                        title:
                                            '${data[i]['firstName']} ${data[i]['lastName']}',
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return ChatPage(
                                                  id: data[i].id.toString(),
                                                  name: data[i]['firstName'],
                                                );
                                              },
                                            ),
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
          ],
        );
      },
    );
  }
}
