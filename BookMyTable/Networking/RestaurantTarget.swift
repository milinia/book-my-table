//
//  RestaurantTarget.swift
//  BookMyTable
//
//  Created by Evelina on 29.05.2023.
//

import Foundation

enum RestaurantTarget {
    case getRestaurants(number: num)
    
    var baseURL: URL {
        return NetworkConfiguration.url
    }

    var path: String {
        switch self {
        case .getRestaurants():
            return "/restaurants"
        }
    }

    var method: Method {
        switch self {
        case .getRestaurants:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getRestaurants:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getRestaurants(let num):
            return [
                "number": num
            ]
        }
    }

    var needsAuth: Bool {
        return true
    }
}
