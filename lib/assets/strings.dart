
class RegisterStrings{
  RegisterStrings._();
  static const String signIn = "Войти";
  static const String signUp = "Зарегистрироваться";
  static const String login = "Логин";
  static const String password = "Пароль";
  static const String apply = "ГОТОВО";
  static const String applyPassword = "Подтвердите пароль";
}

class ExceptionStrings{
  ExceptionStrings._();
  static const String weakPassword = 'Ненадежный пароль';
  static const String emailAlreadyUsed = 'Аккаунт с таким email уже существует';
  static const String signUpError = 'Произошла ошибка при регистрации';
  static const String signInError = 'Произошла ошибка при входе в аккаунт';
  static const String userNotFound = 'Пользователь не найден';
  static const String wrongPassword = 'Неверный пароль';
  static const String emptyFields = 'Поля не должны быть пустыми';
  static const String differentPassword = 'Пароли не совпадают';
}

class TypeOfEventStrings{
  TypeOfEventStrings._();
  static const String signIn = "вход";
  static const String signUp = "регистрация";
}