//
//  RestaurantManager.swift
//  BookMyTable
//
//  Created by Evelina on 29.05.2023.
//

import Foundation


final class RestaurantNetworkManager {
    
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    private func handleJSONResponse<T: Decodable>(
        _ type: T.Type,
        response: NetworkResponse
    ) async throws -> T {
        guard response.statusCode == 200 else {
            switch response.statusCode {
            case 403:
                throw BaseError.forbidden

            default:
                throw BaseError.badStatusCode(code: response.statusCode)
            }
        }
        let decoder = JSONDecoder()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-mm-dd"
//        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard let data = try? decoder.decode(type, from: response.data) else {
            throw BaseError.failedToDecodeData
        }
        return data
    }
    
    func getRestaurants(num: Int) async throws -> [RestaurantData] {
        do {
            var result: NetworkResponse
            if created {
                result = try await networkManager.request(
                    RestaurantTarget.getRestaurants(number: num)
                )
            } else {
                result = try await networkManager.request(
                    RestaurantTarget.getRestaurants(number: num)
                )
            }
            return try await handleJSONResponse(ResponseData.self, response: result).tasks
        } catch {
            throw error
        }
    }
}
