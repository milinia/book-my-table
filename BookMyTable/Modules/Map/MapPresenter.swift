//
//  MapPresenter.swift
//  BookMyTable
//
//  Created by Evelina on 25.04.2023.
//

import Foundation

class MapPresenter {
    
    private let restaturantService: RestaurantService = RestaurantService()
    weak let view: MapViewController
    
    func getRestaurants(page: Int) {
        Task {
            do {
                if userJWT != nil {
                    let restaurantData = try await restaturantService.fetchRestaurants(num: page)
                    
                    await MainActor.run {
                        view.setAnnotations(annotaions: restaurantData)
                    }
                } else {
                }
            } catch {
            }
        }
    }
}
