import "../../password_policy.dart";

/// This rule verify if password contains at least [minimumLowerCaseCharacters]
/// lower case character, also checks for unicode lower case characters.
///
/// Defaults to 1 lower case character minimum.
///
/// [isMandatory] is true by default.
class LowerCaseRule extends ValidationRule {
  LowerCaseRule({
    this.minimumLowerCaseCharacters = 1,
    bool isMandatory = true,
    String? name,
  }) : super(
          impact: minimumLowerCaseCharacters,
          mandatory: isMandatory,
          name: name ??
              "At least $minimumLowerCaseCharacters characters in lower case",
        );

  /// Minimal number of lower case characters in the password.
  final int minimumLowerCaseCharacters;

  @override
  double computeRuleScore(String password) {
    int nbLowerCaseCharacters =
        RegExp(r"\p{Ll}", unicode: true).allMatches(password).length;
    if (nbLowerCaseCharacters > minimumLowerCaseCharacters) return 1.0;

    return nbLowerCaseCharacters / minimumLowerCaseCharacters;
  }
}
