import 'package:password_policy/password_policy.dart';

void main() {
  PasswordPolicy passwordPolicy = PasswordPolicy(
    // minimum score inferior to 1.0, this mean the password does not have to
    // match all rules to be valid, except if all rules are mandatory.
    minimumScore: 0.8,
    validationRules: [
      // ask for a password with a minimal length of 10
      LengthRule(minimalLength: 10),

      // ask to use at least 3 upper case characters
      UpperCaseRule(minimumUpperCaseCharacters: 3),

      // ask to use digits but the rule is set as not mandatory so if the password
      // do not satisfy this rule but have a sufficient overall score it will be
      // valid.
      DigitRule(minimumNbDigits: 3, isMandatory: false),

      // ask to not use spaces (including tabs, newlines, etc)
      NoSpaceRule(),

      // Our custom rule defined below
      Contain1026Rule(),
    ],
  );

  PasswordCheck passwordCheck =
      PasswordCheck(password: "MyPassword", passwordPolicy: passwordPolicy);

  print("Password score: ${passwordCheck.score}");
  print("Password strength: ${passwordCheck.strength.name}");
  if (passwordCheck.isValid) {
    print("Congrats! Your password is secure!");
  } else {
    print("You password does not apply to our PassordPolicy, please review the"
        "following rules: ");
    for (ValidationRule rule in passwordCheck.notRespectedMandatoryRules) {
      print(rule.name);
    }
  }
}

// Here we create a rule that checks if the password contains the string "1026"
// If the password does not contain the string it will be invalidated by this
// rule.
class Contain1026Rule extends ValidationRule {
  Contain1026Rule()
      : super(
          impact: 1,
          mandatory: true,
          name: "Milvintsiss",
        );

  @override
  double computeRuleScore(String password) {
    if (password.contains("1026")) return 1.0;

    return 0.0;
  }
}
