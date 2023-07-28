//
//  RecipeMapMapper.swift
//  RecipeAppViper
//
//  Created by Ricardo Erira on 07/07/2023.
//

import Foundation
import MapKit

struct RecipeMapMapper {
    func map(entity:  RecipeMapEntity) -> RecipeOriginAnnotation {
        return RecipeOriginAnnotation(title: entity.name, locationName: entity.country, coordinate: CLLocationCoordinate2D.init(latitude: entity.latitude, longitude: entity.longitude))
    }
    
}
