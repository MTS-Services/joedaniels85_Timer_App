class Urls {
  static String baseUrl = 'https://joedaniels85.mtscorporate.com/api';

  static String registration = '$baseUrl/auth/registration';
  static String googleAuthentication = '$baseUrl/auth/google-register';
  static String completeRegistration = '$baseUrl/auth/registration/complete';
  static String signIn = '$baseUrl/auth/login';
  static String sendMail = '$baseUrl/auth/send-code';
  static String changePassword = '$baseUrl/auth/reset-password';
  static String getActivities= '$baseUrl/activity';
  static String achievements= '$baseUrl/user/achievements';
  static String progress= '$baseUrl/user/progress';
  static String submitDuration= '$baseUrl/user/activities';
  static String userProfile= '$baseUrl/user/profile';
}
