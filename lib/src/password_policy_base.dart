import '../password_policy.dart';
import 'password_strength.dart' show StrengthHelper;

/// Implements a password policy.
class PasswordPolicy {
  /// A list of all rules to apply to this PasswordPolicy
  ///
  /// A rule could be one of the following default ones: `DigitRule`,
  /// `LengthRule`, `LowerCaseRule`, `UpperCaseRule`, `SpecialCharacterRule`,
  /// `NoSpaceRule`.
  ///
  /// Or you can create your own rule by extending the `ValidationRule` class.
  ///
  /// Example rule that checks if password contains the string "1026":
  ///
  /// ```dart
  /// class Contain1026Rule extends ValidationRule {
  ///   Contain1026Rule() : super(
  ///     impact: 1,
  ///     mandatory: true,
  ///     name: "Milvintsiss",
  ///   );
  ///
  ///   @override
  ///   double computeRuleScore(String password) {
  ///     if (password.contains("1026"))
  ///       return 1.0;
  ///
  ///     return 0.0;
  ///   }
  /// }
  /// ```
  final List<ValidationRule> validationRules;

  /// Minimum score for the password to be validated.
  ///
  /// Must be between 0.0 and 1.0. Defaults to 1.0.
  final double minimumScore;

  /// Define a new PasswordPolicy applying all [validationRules] to given password.
  PasswordPolicy({
    required this.validationRules,
    this.minimumScore = 1.0,
  }) : assert(minimumScore >= 0.0 && minimumScore <= 1.0);
}

/// Used to verify the strength of a password.
class PasswordCheck {
  /// Password string that have to be verified.
  final String password;

  /// PasswordPolicy object containing all [ValidationRule]s and
  /// minimum score required.
  final PasswordPolicy passwordPolicy;

  /// Takes the given [password] and verify it with the given [passwordPolicy].
  PasswordCheck({required this.password, required this.passwordPolicy});

  /// Either or not the password apply to the PasswordPolicy.
  bool get isValid =>
      areMandatoryRulesRespected && score >= passwordPolicy.minimumScore;

  /// Score of the password depending of the [ValidationRule]s.
  ///
  /// Score value is between 0.0 and 1.0.
  ///
  /// 1.0 is the maximum score, meaning all rules are fully respected.
  double get score {
    int totalRulesImpact = passwordPolicy.validationRules
        .map<int>((rule) => rule.impact)
        .fold(0, (a, b) => a + b);
    double totalAppliedImpact = passwordPolicy.validationRules
        .map<double>((rule) => rule.impact * rule.computeRuleScore(password))
        .fold(0, (a, b) => a + b);

    return totalAppliedImpact / totalRulesImpact;
  }

  /// Either or not the password apply to all mandatory rules.
  bool get areMandatoryRulesRespected => !passwordPolicy.validationRules.any(
        (rule) => rule.mandatory && !rule.isRuleRespected(password),
      );

  /// Return the `Strength` of the password depending of the password [score].
  Strength get strength => StrengthHelper.fromScore(score);

  /// Mandatory rules that aren't respected by given [password].
  List<ValidationRule> get notRespectedMandatoryRules =>
      passwordPolicy.validationRules
          .where((rule) => rule.mandatory && !rule.isRuleRespected(password))
          .toList();

  /// Optional Rules that aren't respected by given [password].
  List<ValidationRule> get notRespectedOptionalRules =>
      passwordPolicy.validationRules
          .where((rule) => !rule.mandatory && !rule.isRuleRespected(password))
          .toList();

  /// Rules that aren't respected by given [password].
  List<ValidationRule> get notRespectedRules => passwordPolicy.validationRules
      .where((rule) => !rule.isRuleRespected(password))
      .toList();

  /// Rules that are respected by given [password].
  List<ValidationRule> get respectedRules => passwordPolicy.validationRules
      .where((rule) => rule.isRuleRespected(password))
      .toList();
}
