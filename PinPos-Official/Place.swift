//
//  Place.swift
//  PinPos-Official
//
//  Created by Zhilei Zheng on 2017/9/2.
//  Copyright © 2017年 Zhilei Zheng. All rights reserved.
//

import Foundation
import Timepiece
import RealmSwift
import Realm

class Place: Object{
    dynamic var name:String = ""
    dynamic var address:String = ""
    dynamic var longitude:Double = 0.0
    dynamic var latitude:Double = 0.0
    dynamic var updatedAt:Date?
    dynamic var categoryName:String = ""
    
    func update(name:String, addr:String, lng:Double, lat:Double, cat:Category){
        self.name = name;
        self.address = addr;
        self.longitude = lng;
        self.latitude = lat;
        self.updatedAt = Date()
        self.categoryName = cat.name
    }

}
