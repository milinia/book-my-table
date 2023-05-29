// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum StringConstants {
  /// Вход
  internal static let authentication = StringConstants.tr("Localizable", "authentication", fallback: "Вход")
  /// Регистрация
  internal static let registration = StringConstants.tr("Localizable", "registration", fallback: "Регистрация")
  /// Бронирование
  internal static let reservation = StringConstants.tr("Localizable", "reservation", fallback: "Бронирование")
  /// Подтвердите свой номер телефона
  internal static let verify = StringConstants.tr("Localizable", "verify", fallback: "Подтвердите свой номер телефона")
  internal enum Authentication {
    /// Продолжить
    internal static let button = StringConstants.tr("Localizable", "authentication.button", fallback: "Продолжить")
    /// Хотите создать аккаунт?
    internal static let registration = StringConstants.tr("Localizable", "authentication.registration", fallback: "Хотите создать аккаунт?")
  }
  internal enum Main {
    /// Список
    internal static let list = StringConstants.tr("Localizable", "main.list", fallback: "Список")
    /// На карте
    internal static let map = StringConstants.tr("Localizable", "main.map", fallback: "На карте")
    /// Поиск
    internal static let search = StringConstants.tr("Localizable", "main.search", fallback: "Поиск")
  }
  internal enum Profile {
    /// Мои бронирования
    internal static let reservations = StringConstants.tr("Localizable", "profile.reservations", fallback: "Мои бронирования")
  }
  internal enum Recommendation {
    /// Подборки
    internal static let collection = StringConstants.tr("Localizable", "recommendation.collection", fallback: "Подборки")
  }
  internal enum Registration {
    /// Нажимая кнопку «Дальше», Вы принимаете пользовательское соглашение и политику конфиденциальности 
    internal static let agreement = StringConstants.tr("Localizable", "registration.agreement", fallback: "Нажимая кнопку «Дальше», Вы принимаете пользовательское соглашение и политику конфиденциальности ")
    /// Заполните поля, чтобы бронировать столики в нашем приложении
    internal static let info = StringConstants.tr("Localizable", "registration.info", fallback: "Заполните поля, чтобы бронировать столики в нашем приложении")
    /// Войти
    internal static let login = StringConstants.tr("Localizable", "registration.login", fallback: "Войти")
    /// Мы отправим SMS на этот номер, чтобы восстановить Ваш аккаунт
    internal static let message = StringConstants.tr("Localizable", "registration.message", fallback: "Мы отправим SMS на этот номер, чтобы восстановить Ваш аккаунт")
    /// Ваше имя
    internal static let name = StringConstants.tr("Localizable", "registration.name", fallback: "Ваше имя")
    /// Дальше
    internal static let next = StringConstants.tr("Localizable", "registration.next", fallback: "Дальше")
    /// Введите номер телефона
    internal static let phoneNumber = StringConstants.tr("Localizable", "registration.phoneNumber", fallback: "Введите номер телефона")
    internal enum Confirm {
      /// Введите 4-значный код из SMS
      internal static let message = StringConstants.tr("Localizable", "registration.confirm.message", fallback: "Введите 4-значный код из SMS")
    }
  }
  internal enum Reservation {
    /// Забронировать
    internal static let button = StringConstants.tr("Localizable", "reservation.button", fallback: "Забронировать")
    /// Отмена
    internal static let cancel = StringConstants.tr("Localizable", "reservation.cancel", fallback: "Отмена")
    /// Выбрать
    internal static let choose = StringConstants.tr("Localizable", "reservation.choose", fallback: "Выбрать")
    /// Выберите удобную дату
    internal static let chooseDate = StringConstants.tr("Localizable", "reservation.choose_date", fallback: "Выберите удобную дату")
    /// Пожелания к бронированию (необязательно)
    internal static let comment = StringConstants.tr("Localizable", "reservation.comment", fallback: "Пожелания к бронированию (необязательно)")
    /// Дата
    internal static let date = StringConstants.tr("Localizable", "reservation.date", fallback: "Дата")
    /// Количество гостей
    internal static let guests = StringConstants.tr("Localizable", "reservation.guests", fallback: "Количество гостей")
    /// Выбранный стол
    internal static let table = StringConstants.tr("Localizable", "reservation.table", fallback: "Выбранный стол")
    /// Время
    internal static let time = StringConstants.tr("Localizable", "reservation.time", fallback: "Время")
    internal enum Detail {
      /// Адрес
      internal static let address = StringConstants.tr("Localizable", "reservation.detail.address", fallback: "Адрес")
      /// Отменить бронь
      internal static let cancel = StringConstants.tr("Localizable", "reservation.detail.cancel", fallback: "Отменить бронь")
      /// Оставить отзыв
      internal static let review = StringConstants.tr("Localizable", "reservation.detail.review", fallback: "Оставить отзыв")
      /// Статус
      internal static let status = StringConstants.tr("Localizable", "reservation.detail.status", fallback: "Статус")
    }
  }
  internal enum Restaurant {
    /// Местоположение
    internal static let address = StringConstants.tr("Localizable", "restaurant.address", fallback: "Местоположение")
    /// Кухня
    internal static let cuisine = StringConstants.tr("Localizable", "restaurant.cuisine", fallback: "Кухня")
    /// Описание
    internal static let description = StringConstants.tr("Localizable", "restaurant.description", fallback: "Описание")
    /// Меню
    internal static let menu = StringConstants.tr("Localizable", "restaurant.menu", fallback: "Меню")
    /// Фотографии
    internal static let photos = StringConstants.tr("Localizable", "restaurant.photos", fallback: "Фотографии")
    /// Отзывы
    internal static let reviews = StringConstants.tr("Localizable", "restaurant.reviews", fallback: "Отзывы")
    /// Показать все
    internal static let show = StringConstants.tr("Localizable", "restaurant.show", fallback: "Показать все")
    /// Время работы
    internal static let time = StringConstants.tr("Localizable", "restaurant.time", fallback: "Время работы")
  }
  internal enum Start {
    /// Начать
    internal static let button = StringConstants.tr("Localizable", "start.button", fallback: "Начать")
    /// Localizable.strings
    ///   BookMyTable
    /// 
    ///   Created by Evelina on 01.05.2023.
    internal static let title = StringConstants.tr("Localizable", "start.title", fallback: "Бронирование столиков онлайн - просто, быстро, удобно")
  }
  internal enum TabBar {
    /// Главная
    internal static let feed = StringConstants.tr("Localizable", "tabBar.feed", fallback: "Главная")
    /// Брони
    internal static let reservations = StringConstants.tr("Localizable", "tabBar.reservations", fallback: "Брони")
    /// Поиск
    internal static let search = StringConstants.tr("Localizable", "tabBar.search", fallback: "Поиск")
  }
  internal enum Verify {
    /// Отправить код еще раз
    internal static let again = StringConstants.tr("Localizable", "verify.again", fallback: "Отправить код еще раз")
    /// Подтвердить
    internal static let button = StringConstants.tr("Localizable", "verify.button", fallback: "Подтвердить")
    /// Введите код, который мы отправили на номер 
    internal static let message = StringConstants.tr("Localizable", "verify.message", fallback: "Введите код, который мы отправили на номер ")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension StringConstants {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
