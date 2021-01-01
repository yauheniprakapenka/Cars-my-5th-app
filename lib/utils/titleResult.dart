class TitleResult {
  static get(int scoreForRound) {
    String title;
    if (97 <= scoreForRound) {
      title = "Отлично!";
    } else if (95 <= scoreForRound) {
      title = "Хорошо";
    } else {
      title = "Мимо";
    }
    return title;
  }
}
