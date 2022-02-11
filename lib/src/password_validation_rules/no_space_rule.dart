import '../../password_policy.dart';

/// This rule verify if password contains whitespaces, newlines, tabs, vertical
/// unicode whitespaces or horizontal Unicode whitespace. If any is present the
/// password is not validated.
///
/// [isMandatory] is true by default.
class NoSpaceRule extends ValidationRule {
  NoSpaceRule({
    int impact = 1,
    bool isMandatory = true,
    String? name,
  }) : super(
          impact: impact,
          mandatory: isMandatory,
          name: name ?? "Should not contain spaces",
        );

  @override
  double computeRuleScore(String password) =>
      RegExp(r"[\s\v\h]").allMatches(password).isEmpty ? 1.0 : 0.0;
}
