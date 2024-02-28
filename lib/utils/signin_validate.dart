
class SignInValidate {

  String errorUser = '';
  String errorMail = '';
  String errorType = '';
  String errorPass = '';
  String errorCpass = '';
  RegExp emailRegExp = RegExp("^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*");

  //Username

  String name(String userName) {

    if(userName.isEmpty) {
        errorUser = 'Please enter your name';
      } else {
      errorUser = '';
    }

    return errorUser;

  }

  String mail(String email) {

    if(email.isEmpty) {
        errorMail = 'Please enter the email address';
      }
    else if(!emailRegExp.hasMatch(email ?? '')) {
      errorMail = 'Please enter the valid email';
    }
    else {
      errorMail = '';
    }

    return errorMail;

  }

  String type(String currencyType) {

    if(currencyType.isEmpty) {
        errorType = 'Please enter the type of the currency';
      }
    else if(currencyType.length > 3) {
      errorType = 'Please enter 3 or less than 3 letters';
    }
    else {
      errorType = '';
    }

    return errorType;

  }

  String pass(String password) {

    if(password.isEmpty) {
        errorPass = 'Please enter a strong password';
      }
    else if(password.length < 6) {
      errorPass = 'Week Password, Enter at least 6 characters';
    }
    else {
      errorPass = '';
    }

    return errorPass;

  }

  String cPass(String confirmPassword, String password) {

    if(confirmPassword.isEmpty) {
        errorCpass = 'Please enter a strong password';
      }
    else if(password != confirmPassword) {
      errorCpass = 'Password do not match';
    }
    else {
      errorCpass = '';
    }

    return errorCpass;

  }

}
