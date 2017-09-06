//
//  CalloutOverlay.swift
//  PinPos-Official
//
//  Created by Zhilei Zheng on 2017/9/5.
//  Copyright © 2017年 Zhilei Zheng. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class CalloutOverlay: NSObject, MKOverlay {
    
    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
    
    
    
    init(annotation: MKAnnotation) {
        self.coordinate = annotation.coordinate
        let point = MKMapPointForCoordinate(annotation.coordinate)
        self.boundingMapRect = MKMapRect(origin: point, size: MKMapSize(width: 150, height: 30))
    }
    
    
}
