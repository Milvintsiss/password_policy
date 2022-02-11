import '../../password_policy.dart';

/// This rule verify if password is longer or equal to [minimalLength].
///
/// [minimalLength] defaults to 8.
///
/// [isMandatory] is true by default.
class LengthRule extends ValidationRule {
  LengthRule({
    this.minimalLength = 8,
    bool isMandatory = true,
    String? name,
  }) : super(
          impact: minimalLength,
          mandatory: isMandatory,
          name: name ?? "Minimal length: $minimalLength",
        );

  /// Minimal length required to the password to be valid.
  final int minimalLength;

  @override
  double computeRuleScore(String password) {
    if (password.length > minimalLength) return 1.0;

    return password.length / minimalLength;
  }
}
