
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

class FieldsStrings{
  FieldsStrings._();
  static const String uid = 'uid';
  static const String date = 'date';
  static const String blin = 'blin';
  static const String suicide = 'suicide';
  static const String giveUp = 'giveUp';
  static const String chetko = 'chetko';
}

class TitleStrings{
  TitleStrings._();
  static const String counterPageTitle = 'Выбери своего бойца!';
  static const String homePageTitle = 'Есть два стула';
  static const String statScreenTitle = 'Статистика';
  static const String statisticPageTitle = 'Выберите дату';
  static const String mainTitle = 'Прикол';
}

class FirebaseStrings{
  FirebaseStrings._();
  static const String mainCollection = 'users';
  static const String optionalCollection = 'dates';
}

class ImagePath{
  ImagePath._();
  static const String blin = 'images/blin.png';
  static const String suicide = 'images/suicide.jpg';
  static const String giveUp = 'images/give_up.jpg';
  static const String chetko = 'images/chetko.png';
}

class DrawerButtonStrings{
  DrawerButtonStrings._();
  static const String back = 'Назад';
  static const String stat = 'Статистика';
  static const String exit = 'Выйти из аккаунта';
}

