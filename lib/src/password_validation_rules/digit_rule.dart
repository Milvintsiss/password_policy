import '../../password_policy.dart';

/// This rule verify if password contains at least [minimumNbDigits] digits.
///
/// Defaults to 1 digit minimum.
///
/// [isMandatory] is true by default.
class DigitRule extends ValidationRule {
  DigitRule({
    this.minimumNbDigits = 1,
    bool isMandatory = true,
    String? name,
  }) : super(
          impact: minimumNbDigits,
          mandatory: isMandatory,
          name: name ?? "$minimumNbDigits digits minimum",
        );

  /// Minimal number of digits in the password.
  final int minimumNbDigits;

  @override
  double computeRuleScore(String password) {
    int nbDigits = RegExp(r"[0-9]").allMatches(password).length;
    if (nbDigits > minimumNbDigits) return 1.0;

    return nbDigits / minimumNbDigits;
  }
}
