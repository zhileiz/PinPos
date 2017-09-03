//
//  Category.swift
//  PinPos-Official
//
//  Created by Zhilei Zheng on 2017/9/2.
//  Copyright © 2017年 Zhilei Zheng. All rights reserved.
//

import Foundation
import SwiftIcons
import Realm
import RealmSwift


class Category:Object{
    private(set) var name:String = ""
    private(set) var color:String = "ffffff"
    private(set) var places = List<Place>()
    
    func update(name:String, color:String){
        self.name = name
        self.color = color
    }
    
    func addPlace(place:Place){
        places.append(place)
    }
    
    func getPlaces() -> [Place]{
        return places
    }
    
}
