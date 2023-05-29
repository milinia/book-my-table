//
//  NetworkManager.swift
//  BookMyTable
//
//  Created by Evelina on 29.05.2023.
//

import Foundation
import Moya

protocol NetworkManager {
    func request(_ request: TargetType) async throws -> NetworkResponse
}
