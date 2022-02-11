import '../../password_policy.dart';

/// This rule verify if password contains at least [minimumUpperCaseCharacters]
/// upper case character, also checks for unicode upper case characters.
///
/// Defaults to 1 upper case character minimum.
///
/// [isMandatory] is true by default.
class UpperCaseRule extends ValidationRule {
  UpperCaseRule({
    this.minimumUpperCaseCharacters = 1,
    bool isMandatory = true,
    String? name,
  }) : super(
          impact: minimumUpperCaseCharacters,
          mandatory: isMandatory,
          name: name ??
              "At least $minimumUpperCaseCharacters characters in upper case",
        );

  /// Minimal number of upper case characters in the password.
  final int minimumUpperCaseCharacters;

  @override
  double computeRuleScore(String password) {
    int nbUpperCaseCharacters =
        RegExp(r"\p{Lu}", unicode: true).allMatches(password).length;
    if (nbUpperCaseCharacters > minimumUpperCaseCharacters) return 1.0;

    return nbUpperCaseCharacters / minimumUpperCaseCharacters;
  }
}
