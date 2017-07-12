//
//  PhotoAuthorization.swift
//  Gil Vacation Photos
//
//  Created by ant on 7/12/17.
//  Copyright © 2017 gil wentzel. All rights reserved.
//

import Foundation
import PhotoAuthorization

let status = PHPhotoLibrary.authorizationStatus()
switch status {
case : .authorized  //goto  Mapview segue
default : break//exit app




}
