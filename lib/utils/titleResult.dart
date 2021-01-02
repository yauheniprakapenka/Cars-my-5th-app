import '../Constants/strings.dart';

class TitleResult {
  static get(int scoreForRound) {
    String title;
    if (100 == scoreForRound) {
      title = Strings.resultAlertDialogExcellent;
    } else if (98 <= scoreForRound) {
      title = Strings.resultAlertDialogGood;
    } else {
      title = Strings.resultAlertDialogMiss;
    }
    return title;
  }
}
