//
//  MapViewController.swift
//  Gil Vacation Photos
//
//  Created by ant on 7/15/17.
//  Copyright © 2017 gil wentzel. All rights reserved.
//
import CoreLocation
import Foundation
import MapKit
import UIKit
import Photos
import CoreGraphics
import PhotosUI

final class MapViewController: UIViewController, CLLocationManagerDelegate {
  @IBOutlet weak var mapView: MKMapView!

  var viewModel = MapViewModel()

  let manager = CLLocationManager()

  func requestPermission() {
    manager.requestWhenInUseAuthorization()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    if viewModel.hasPermission() {
      print("got perms!")
      manager.delegate = self
      mapView.showsUserLocation = true
      mapView.userTrackingMode = .follow
    } else {
      print("we require location perms")
      requestPermission()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if let userCoordinate = mapView.userLocation.location?.coordinate {
      mapView.setCenter(userCoordinate, animated: true)
    }

    let count = viewModel.coordinates.count
    print("draw annotations \(count)")
    for i in 0 ..< count {
      let location = viewModel.coordinates[i]
      let annotation = MapPin(coordinate: location.coordinate, title: "", subtitle: "")
      mapView.addAnnotation(annotation)
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

  }
  @IBOutlet weak var ShowPhotosButton: UIButton!
  //func freezeMap () {
   // self.mapView.isUserInteractionEnabled = false}
  // now check photo coordinates against  MKMapRect
  //func photosOnMap(){
    //for i in 0..<self.PhotoViewModel.selectedCoordinates.count{
      // try going to PhotoviewController now
   // }
 // }

}

extension MapViewModel {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("location updated \(locations)")
  }
}
func getAssetThumbnail (asset: PHAsset) -> UIImage {
  let manager = PHImageManager.default()
  let option =  PHImageRequestOptions()
  var thumbnail = UIImage()
  let size = CGSize(width: 100, height: 100)
  option.isSynchronous = true
  manager.requestImage(for:asset, targetSize: size, contentMode: .aspectFit, options: option, resultHandler: {(result, info) ->Void in
    thumbnail = result!
  })

return thumbnail
}
