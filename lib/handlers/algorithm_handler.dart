import 'package:fight_buddy/handlers/user_handler.dart';
import 'package:fight_buddy/handlers/user.dart' as fightbuddy;

//Måste lägga in så att man inte får upp sig själv som matchning
Future algorithm(fightbuddy.User user) async {
  List<String> uidList = [];
  List<String> users = await UserHandler().getAllUserIds();

  for (String str in users) {
    fightbuddy.User potentialMatch = await UserHandler.getUser(str);

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

  for (String value1 in user.martialArts) {
    for (String value2 in potentialMatch.martialArts) {
      if (value1 == value2) {
        foundCommonValue = true;
        break;
      }
    }
    if (foundCommonValue) {
      break;
    }
  }

  if (foundCommonValue == false) {
    return false;
  }

  if (!user.prefGender.contains(potentialMatch.gender)) {
    return false;
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
      if (foundCommonValue) {
        break;
      }
    }
  }

  if (foundCommonValue == false) {
    return false;
  }

  return true;
}
