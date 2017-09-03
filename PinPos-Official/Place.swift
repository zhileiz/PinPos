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
    private(set) public var name:String = ""
    private(set) public var address:String = ""
    private(set) public var longitude:Double = 0.0
    private(set) public var latitude:Double = 0.0
    private(set) public var updatedAt:Date?
    private(set) public var categoryName:String = ""
    
    func update(name:String, addr:String, lng:Double, lat:Double, cat:Category){
        self.name = name;
        self.address = addr;
        self.longitude = lng;
        self.latitude = lat;
        self.updatedAt = Date()
        self.categoryName = cat.name
    }

}
