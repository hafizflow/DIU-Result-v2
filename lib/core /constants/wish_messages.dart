class WishMessages {
  static String motivationalMessage(double gradePoint) {
    if (gradePoint == 4.00) {
      return 'Perfect!';
    } else if (gradePoint >= 3.75) {
      return 'Awesome!';
    } else if (gradePoint >= 3.50) {
      return 'Great work!';
    } else if (gradePoint >= 3.25) {
      return 'Well done!';
    } else if (gradePoint >= 3.00) {
      return 'Nice try!';
    } else if (gradePoint >= 2.75) {
      return 'Not bad!';
    } else if (gradePoint >= 2.50) {
      return 'Keep going!';
    } else if (gradePoint >= 2.25) {
      return 'Try harder!';
    } else if (gradePoint >= 2.00) {
      return 'Just made it!';
    } else {
      return 'Better luck next time!';
    }
  }
}
