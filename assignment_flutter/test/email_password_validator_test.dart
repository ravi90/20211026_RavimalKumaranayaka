import 'package:assignment_flutter/pages/sign_in_page.dart';
import 'package:assignment_flutter/pages/sign_up_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //Unit tests for text field input validations
  test('empty email returns error string', () {
    var result = TextFieldValidator.validate('');
    expect(result, 'Please enter value');
  });

  test('non-empty email returns null', () {
    var result = TextFieldValidator.validate('email');
    expect(result, null);
  });

  test('empty password returns error string', () {
    var result = PwdFieldValidator.validate('');
    expect(result, 'Please enter value');
  });

  test('non-empty password returns null', () {
    var result = PwdFieldValidator.validate('pwd');
    expect(result, null);
  });
}
