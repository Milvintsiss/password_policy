import '../../password_policy.dart';

/// This rule verify if password contains at least [minimumSpecialCharacters]
/// special character (punctuation and symbols), also checks for unicode
/// special characters.
///
/// Defaults to 1 special character minimum.
///
/// [isMandatory] is true by default.
class SpecialCharacterRule extends ValidationRule {
  SpecialCharacterRule({
    this.minimumSpecialCharacters = 1,
    bool isMandatory = true,
    String? name,
  }) : super(
          impact: minimumSpecialCharacters,
          mandatory: isMandatory,
          name: name ?? "At least $minimumSpecialCharacters special characters",
        );

  /// Minimal number of special characters in the password.
  final int minimumSpecialCharacters;

  @override
  double computeRuleScore(String password) {
    int nbSpecialCharacters =
        RegExp(r"[\p{P}\p{S}]", unicode: true).allMatches(password).length;
    if (nbSpecialCharacters > minimumSpecialCharacters) return 1.0;

    return nbSpecialCharacters / minimumSpecialCharacters;
  }
}
