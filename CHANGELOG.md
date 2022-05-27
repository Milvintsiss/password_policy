## 1.2.0 - 05/27/22

* [BREAKING CHANGE] Don't check for horizontal Unicode whitespaces by default anymore for NoSpaceRule
  but adds option to check for it. This was added for convenience as Flutter adds horizontal Unicode
  whitespaces between characters in TextFormFields.

## 1.1.0 - 02/12/22

* Follow recommended dart lints
  * [BREAKING CHANGE] Rename all Strength enum values to lowerCamelCase format
    (WEAK, INTERMEDIATE, GOOD, STRONG, UNBREAKABLE) => (weak, intermediate, good, strong, unbreakable)

## 1.0.0 - 02/11/22

* First version of password_policy
