//
//  ViewController.swift
//  PinPos-Official
//
//  Created by Zhilei Zheng on 2017/9/2.
//  Copyright © 2017年 Zhilei Zheng. All rights reserved.
//

import UIKit
import MapKit
import SwiftIcons
import RealmSwift
import Hue
import SnapKit
import DZNEmptyDataSet

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var choiceView: UIView!
    @IBOutlet weak var categoryTable: UITableView!
    
    let manager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewAutoLayout()
        choiceViewAutoLayout()
        catTableViewAutoLayout()
        redrawTabBar()
        manager.delegate = self
        configureLocationServices()
    }
}

extension MapVC:MKMapViewDelegate {
    
    func mapViewAutoLayout(){
        mapView.delegate = self;
        mapView.snp.makeConstraints{(make) -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsetsMake(0, 0, 40, 0))
        }
    }
    
    func initialMapView(){
        let loc = manager.location
        let myLoc:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: loc!.coordinate.latitude, longitude: loc!.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: myLoc, span: span)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    
}

extension MapVC:CLLocationManagerDelegate{
    func configureLocationServices(){
        if authorizationStatus == .notDetermined {
            manager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        initialMapView()
    }
    
}

extension MapVC:UITableViewDelegate{
    func catTableViewAutoLayout(){
        categoryTable.delegate = self
        categoryTable.dataSource = self
        categoryTable.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(choiceView).offset(50)
            make.left.equalTo(view).offset(120)
            make.right.equalTo(view).offset(-120)
            make.height.equalTo(150)
        }
        categoryTable.layer.cornerRadius = 10;
        categoryTable.layer.masksToBounds = true;
        categoryTable.layer.borderWidth = 3
        categoryTable.layer.borderColor = UIColor(hex: "1364A5").cgColor
        categoryTable.isHidden = true
    }
}

extension MapVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoryTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        return cell
    }
    
}

extension MapVC {
    
    func choiceViewAutoLayout(){
        choiceView.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(view).offset(40)
            make.left.equalTo(view).offset(120)
            make.right.equalTo(view).offset(-120)
            make.height.equalTo(40)
        }
        choiceView.layer.cornerRadius = 10;
        choiceView.layer.masksToBounds = true;
        choiceView.layer.borderWidth = 3
        choiceView.layer.borderColor = UIColor(hex: "1364A5").cgColor
        if let thisView = choiceView as? ChoiceView{
            thisView.setUp()
            thisView.catTable = categoryTable
        } else {
            print("cannot cast")
        }
    }
    
    func redrawTabBar(){
        tabBarController?.tabBar.barTintColor = UIColor(hex: "1364A5")
        if let item1 = tabBarController?.tabBar.items?[0]{
            let size = CGSize(width: 40, height: 40)
            item1.setIcon(icon: .ionicons(.map), size: size, textColor: UIColor(hex:"D4D4D4"), selectedTextColor: UIColor.white)
        } else {
            print("no such item")
        }
        if let item2 = tabBarController?.tabBar.items?[1]{
            let size = CGSize(width: 40, height: 40)
            item2.setIcon(icon: .ionicons(.iosListOutline), size: size, textColor: UIColor(hex:"D4D4D4"), selectedTextColor: UIColor.white)
        } else {
            print("no such item")
        }
    }
}

