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
  internal enum Authentication {
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
    /// Подтвердите свой номер телефона
    internal static let confirm = StringConstants.tr("Localizable", "registration.confirm", fallback: "Подтвердите свой номер телефона")
    /// Уже есть аккаунт?
    internal static let login = StringConstants.tr("Localizable", "registration.login", fallback: "Уже есть аккаунт?")
    /// Имя
    internal static let name = StringConstants.tr("Localizable", "registration.name", fallback: "Имя")
    /// Дальше
    internal static let next = StringConstants.tr("Localizable", "registration.next", fallback: "Дальше")
    /// Введите номер телефона
    internal static let phoneNumber = StringConstants.tr("Localizable", "registration.phoneNumber", fallback: "Введите номер телефона")
    internal enum Confirm {
      /// Введите 4-значный код из SMS
      internal static let message = StringConstants.tr("Localizable", "registration.confirm.message", fallback: "Введите 4-значный код из SMS")
    }
    internal enum PhoneNumber {
      /// Мы отправим SMS на этот номер, чтобы верифицировать его
      internal static let message = StringConstants.tr("Localizable", "registration.phoneNumber.message", fallback: "Мы отправим SMS на этот номер, чтобы верифицировать его")
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
