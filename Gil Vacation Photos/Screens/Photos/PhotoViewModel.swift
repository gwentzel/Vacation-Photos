//
//  PhotoViewModel.swift
//  Gil Vacation Photos
//
//  Created by ant on 7/15/17.
//  Copyright © 2017 gil wentzel. All rights reserved.
//
import CoreLocation
import Foundation
import Photos

struct PhotoViewModel {
  var selectedPhotos = [UIImage]()
  var selectedCoordinates = [CLLocation]()

  func hasPermission() -> Bool {
    let status = PHPhotoLibrary.authorizationStatus()
    switch status {
    case .authorized:
      return true
    case .denied, .notDetermined, .restricted:
      return false
    }
  }
}