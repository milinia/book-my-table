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
  internal enum Start {
    /// Начать
    internal static let button = StringConstants.tr("Localizable", "start.button", fallback: "Начать")
    /// Localizable.strings
    ///   BookMyTable
    /// 
    ///   Created by Evelina on 01.05.2023.
    internal static let title = StringConstants.tr("Localizable", "start.title", fallback: "Бронирование столиков онлайн - просто, быстро, удобно")
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
