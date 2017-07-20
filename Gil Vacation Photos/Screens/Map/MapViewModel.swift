//
//  MapViewModel.swift
//  Gil Vacation Photos
//
//  Created by ant on 7/15/17.
//  Copyright © 2017 gil wentzel. All rights reserved.
//
import CoreLocation
import Foundation
import Photos

struct MapViewModel {
  var coordinates = [CLLocation]()
  var photos = [PHFetchResult<PHAsset>]()
  var  assets = [PHAsset]()
  
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

