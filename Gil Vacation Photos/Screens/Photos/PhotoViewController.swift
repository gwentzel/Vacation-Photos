//
//  PhotoViewController.swift
//  Gil Vacation Photos
//
//  Created by ant on 7/15/17.
//  Copyright © 2017 gil wentzel. All rights reserved.
//
import Foundation
import Photos
import UIKit

class PhotoViewController: UIViewController  {

  var viewModel = PhotoViewModel()

  let imageManager = PHImageManager.default()

  @IBOutlet var btnLoadPhotos: UIView!

  func loopThroughPhotosInBackground() {
    DispatchQueue.global(qos: .userInitiated).async { // 1
      // go get photos
      // Note that if the request is not set to synchronous
      // the requestImageForAsset will return both the image
      // and thumbnail; by setting synchronous to true it
      // will return just the thumbnail
      let requestOptions = PHImageRequestOptions()
      requestOptions.isSynchronous = true

      // Sort the images by creation date
      let fetchOptions = PHFetchOptions()
      fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: true)]

      let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
      let count = fetchResult.count
      for i in 0 ..< count {
        let result = fetchResult.object(at: i)
        if let coordinate = result.location?.coordinate {
          print("coordinate \(coordinate)")
          self.viewModel.selectedCoordinates.append(result.location!)
          self.viewModel.selectedAssets.append(result)
          self.viewModel.selectedPhotos.append(PHFetchResult<PHAsset>())
    //   self.viewModel.galleryImages = PHAsset.fetchAssets(with: <#T##PHAssetMediaType#>.image, options: nil)
        }
      }
      DispatchQueue.main.async { // 2
        self.performSegue(withIdentifier: "gotoMap", sender: self)
      }
    }

  }

  @IBAction func tappedLoadPhotos(_ sender: Any) {
    print("HI GIL YOU TAPPED ME")
    if viewModel.hasPermission() {
      loopThroughPhotosInBackground()
    } else {
      print("Please open your settings and enable permissions")
      PHPhotoLibrary.requestAuthorization({ status in
        if self.viewModel.hasPermission() {
          self.loopThroughPhotosInBackground()
        } else {
          print("still nothing")
        }
      })
    }
//    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//      imagePicker.delegate = self
//      imagePicker.sourceType = .photoLibrary
//      imagePicker.allowsEditing = true
//      self.present(imagePicker, animated: true, completion: nil)
//    }
  }

  override func viewDidLoad() {
    // load data
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // prepare child views with the data
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // animations, now the user can see the view
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
  }

}

extension PhotoViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("segue \(String(describing: segue.identifier))")
    if let mapViewController = segue.destination as? MapViewController {
      mapViewController.viewModel.coordinates = viewModel.selectedCoordinates
      mapViewController.viewModel.assets =  viewModel.selectedAssets
    }
  }
}

extension PhotoViewController {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
    print("cancelled selection")
  }

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    picker.dismiss(animated: true, completion: nil)

    print("selected photo", info)
    // get the coordinate of the selected photo
    if (picker.sourceType == .photoLibrary) {


        // If the fetch result isn't empty,
        // proceed with the image request
//        if fetchResult.count > 0 {
//          // Perform the image request
//          imgManager.requestImage(for: fetchResult.object(at: 0), targetSize: CGSize(width: 100, height: 100), contentMode: PHImageContentMode.aspectFit, options: requestOptions, resultHandler: { (image, meta) in
//            fetchResult.object(at: 0).location?.coordinate
//            print("meta \(meta)")
//          })
//          imgManager.requestImageForAsset(fetchResult.objectAtIndex(fetchResult.count - 1 - index) as PHAsset, targetSize: view.frame.size, contentMode: PHImageContentMode.AspectFill, options: requestOptions, resultHandler: { (image, _) in
//
//            // Add the returned image to your array
//            self.images.addObject(image)
//
//            // If you haven't already reached the first
//            // index of the fetch result and if you haven't
//            // already stored all of the images you need,
//            // perform the fetch request again with an
//            // incremented index
//            if index + 1 < fetchResult.count && self.images.count < self.totalImageCountNeeded {
//              self.fetchPhotoAtIndexFromEnd(index + 1)
//            } else {
//              // Else you have completed creating your array
//              println("Completed array: \(self.images)")
//            }
//          })
//        }
//      }
    }
  }
}
