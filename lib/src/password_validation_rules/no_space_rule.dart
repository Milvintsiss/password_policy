import '../../password_policy.dart';

/// This rule verify if password contains whitespaces, newlines, tabs, vertical
/// unicode whitespaces. If any is present the password is not validated.
///
/// This rule does not check for horizontal Unicode whitespace for convenience
/// as Flutter adds them between characters in TextFormField, if you want to
/// check for horizontal Unicode whitespace set [doCheckForHorizontalWhitespaces]
/// to true.
///
/// [isMandatory] is true by default.
class NoSpaceRule extends ValidationRule {
  final bool doCheckForHorizontalWhitespaces;

  NoSpaceRule({
    int impact = 1,
    bool isMandatory = true,
    String? name,
    this.doCheckForHorizontalWhitespaces = false,
  }) : super(
          impact: impact,
          mandatory: isMandatory,
          name: name ?? "Should not contain spaces",
        );

  @override
  double computeRuleScore(String password) {
    if (doCheckForHorizontalWhitespaces) {
      return RegExp(r"[\s\v\h]").allMatches(password).isEmpty ? 1.0 : 0.0;
    } else {
      return RegExp(r"[\s\v]").allMatches(password).isEmpty ? 1.0 : 0.0;
    }
  }
}
