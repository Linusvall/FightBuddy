import 'package:fight_buddy/handlers/user_handler.dart';
import 'package:fight_buddy/handlers/user.dart' as fightbuddy;

Future findMatches(fightbuddy.User user) async {
  List<String> uidList = [];
  Set<String> users =
      await UserHandler().getUIDsFromMartialArt(user.martialArts);

  for (String str in users) {
    fightbuddy.User potentialMatch = await UserHandler().getUser(str);

    bool compatable = compareUserPreferences(user, potentialMatch);

    if (compatable == true) {
      uidList.add(str);
    }
  }
  UserHandler().updateUserMatchesList(uidList);
}

bool compareUserPreferences(
    fightbuddy.User user, fightbuddy.User potentialMatch) {
  bool foundCommonValue = false;

  if (user.uid == potentialMatch.uid) {
    return false;
  }

  if (!user.prefGender.contains("none")) {
    if (!user.prefGender.contains(potentialMatch.gender)) {
      if (!potentialMatch.prefGender.contains("none")) {
        if (!potentialMatch.prefGender.contains(user.gender)) {
          return false;
        }
      }
      return false;
    }
  }

  if (user.weight + user.prefWeight < potentialMatch.weight ||
      user.weight - user.prefWeight > potentialMatch.weight) {
    return false;
  }

  if (user.prefLevel == 'same') {
    foundCommonValue = false;
    for (String value1 in user.level) {
      for (String value2 in potentialMatch.level) {
        if (value1 == value2) {
          foundCommonValue = true;
          break;
        }
      }
    }
    if (foundCommonValue == false) {
      return false;
    }
  }

  return true;
}
