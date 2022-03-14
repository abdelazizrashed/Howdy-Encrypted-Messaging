bool isPasswordStrongEnough(String password) {
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  var _password = password.trim();
  if (_password.isEmpty) {
    return false;
  } else if (_password.length < 8) {
    return false;
  } else {
    if (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password)) {
      return false;
    } else {
      return true;
    }
  }
}
