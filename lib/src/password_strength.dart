// If modified remember to also modify Helper extension to match changes
/// Password strength from Weak to Unbreakable, in default implementations this
/// will refer to your password score.
enum Strength {
  WEAK,
  INTERMEDIATE,
  GOOD,
  STRONG,
  UNBREAKABLE,
}

/// `Strength` helper to convert score to `Strength`.
extension StrengthHelper on Strength{
  static Strength fromScore(double score) {
    int index = score * 10 ~/ 2 - 1;
    if (index < 0)
      index = 0;

    return Strength.values[index];
  }
}
