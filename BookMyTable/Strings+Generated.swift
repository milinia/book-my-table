// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum StringConstants {
  /// Localizable.strings
  ///   BookMyTable
  /// 
  ///   Created by Evelina on 01.05.2023.
  internal static let registation = StringConstants.tr("Localizable", "registation", fallback: "Регистрация")
  internal enum Main {
    /// Список
    internal static let list = StringConstants.tr("Localizable", "main.list", fallback: "Список")
    /// На карте
    internal static let map = StringConstants.tr("Localizable", "main.map", fallback: "На карте")
    /// Поиск
    internal static let search = StringConstants.tr("Localizable", "main.search", fallback: "Поиск")
  }
  internal enum Registation {
    /// Введите номер телефона
    internal static let phoneNumber = StringConstants.tr("Localizable", "registation.phone_number", fallback: "Введите номер телефона")
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
