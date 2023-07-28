//
//  RecipeOriginAnnotation.swift
//  RecipeAppViper
//
//  Created by Ricardo on 28/07/2023.
//

import Foundation
import MapKit

class RecipeOriginAnnotation: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let coordinate: CLLocationCoordinate2D

  init(title: String?, locationName: String?, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.locationName = locationName
    self.coordinate = coordinate

    super.init()
  }

}
