//
//  MapViewModel.swift
//  Gil Vacation Photos
//
//  Created by ant on 7/15/17.
//  Copyright © 2017 gil wentzel. All rights reserved.
//
import CoreLocation
import Foundation

struct MapViewModel {
  var coordinates = [CLLocation]()

  func hasPermission() -> Bool {
    let status = CLLocationManager.authorizationStatus()
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      return true
    case .denied, .notDetermined, .restricted:
      return false
    }
  }
}

