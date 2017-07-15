//
//  MapPin.swift
//  Gil Vacation Photos
//
//  Created by ant on 7/15/17.
//  Copyright © 2017 gil wentzel. All rights reserved.
//

import Foundation
import MapKit

class MapPin: NSObject, MKAnnotation {
  var coordinate: CLLocationCoordinate2D
  var title: String?
  var subtitle: String?

  init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
  }
}
