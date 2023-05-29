//
//  RestaurantService.swift
//  BookMyTable
//
//  Created by Evelina on 29.05.2023.
//

import Foundation


final class RestaurantService {
    
    private let manager: RestaurantNetworkManager
    
    init(networkManager: RestaurantNetworkManager) {
        self.manager = networkManager
    }
    
    func fetchRestaurants(num: Int) async throws -> [RestaurantData] {
        do {
            return try await manager.getRestaurants(num: Int)
        } catch {
            throw error
        }
    }
}
