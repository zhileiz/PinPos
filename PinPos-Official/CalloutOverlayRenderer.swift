//
//  CalloutOverlayRenderer.swift
//  PinPos-Official
//
//  Created by Zhilei Zheng on 2017/9/5.
//  Copyright © 2017年 Zhilei Zheng. All rights reserved.
//


import UIKit
import MapKit

class ParkMapOverlayView: MKOverlayRenderer {
    var place:Place
    var hex:String
    
    var navigationBtn = UIButton(type: .custom)
    
    
    init(overlay:MKOverlay, place:Place, hex:String) {
        self.place = place
        self.hex = hex
        super.init(overlay: overlay)
    }
    
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        context.dr
    }
    

}
