/// Interface that helps to create `ValidationRule`s.
abstract class ValidationRule {
  /// Used to compute the overall score of the password :
  ///
  /// passwordScore = SUM(rulesRespectedImpact) / SUM(totalRulesImpact)
  ///
  /// Defaults to 1.
  ///
  /// For example, in case of a Length rule it can be set to the value of the
  /// minimalLength.
  final int impact;

  /// Minimum score for the rule to be validated.
  ///
  /// Must be between 0.0 and 1.0. Defaults to 1.0.
  final double minimumScore;

  /// Calculate the score of the rule.
  ///
  /// For example, in case of a length rule it will be:
  /// passwordLength / requiredPasswordLength
  ///
  /// Must return a value between 0.0 and 1.0.
  double computeRuleScore(String password);

  /// Function that verify if the rule is respected or not.
  bool isRuleRespected(String password) =>
      computeRuleScore(password) >= minimumScore;

  /// Define if this rule is mandatory or not, if this rule is not respected
  /// and is mandatory, the password will not be validated.
  final bool mandatory;

  /// Name of the rule, this exists for convenience and will not be used by the
  /// PasswordPolicy. All defaults Rules provided by this package have a default
  /// name, so if you're using one of them, name cannot be null.
  ///
  /// Name can be used to display password policy errors to UI or can be used
  /// as identifiers.
  final String? name;

  /// Default constructor, define the [impact], the [minimumScore] and the
  /// [name] of this rule. Also define if the rule is mandatory or not.
  ValidationRule({
    this.impact = 1,
    this.minimumScore = 1.0,
    required this.mandatory,
    this.name,
  });
}
