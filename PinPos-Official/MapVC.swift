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
import Realm
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
    let realm = try! Realm()
    var category = Category()
    var categories = [Category]()
    var activeCategory = Category()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateRealm()
        mapViewAutoLayout()
        choiceViewAutoLayout()
        catTableViewAutoLayout()
        redrawTabBar()
        manager.delegate = self
        configureLocationServices()
        addMarkers()
        activeCategory = category
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addMarkers()
        categoryTable.reloadData()
        redrawByCategory(cat: activeCategory)
    }
    
    
    func tempAdd(){
        let category1 = Category()
        let category2 = Category()
        let category3 = Category()
        category.update(name: "Any", color: "1364A5")
        category1.update(name: "Food", color: "FB9822")
        category2.update(name: "Sight", color: "0D8915")
        category3.update(name: "Life", color: "5910A7")
        try! realm.write {
            realm.add(category)
            realm.add(category1)
            realm.add(category2)
            realm.add(category3)
        }
    }
    
    func populateRealm(){
        let cats = realm.objects(Category.self)
        self.category = cats.first!
        for cat in cats{
            print(cat.name)
            self.categories.append(cat)
        }
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
    
    func addMarkers(){
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        let locs = realm.objects(Place.self)
        for loc in locs {
            if loc.categoryName == activeCategory.name || activeCategory.name == "Any" {
                let coordinate = CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = loc.name
                annotation.subtitle = "lng:\(loc.longitude), lat:\(loc.latitude)"
                let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
                mapView.addAnnotation(pinAnnotationView.annotation!)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let hex = activeCategory.color
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        if !(annotation is MKUserLocation){
        annotationView?.image = UIImage(icon: .ionicons(.location), size: CGSize(width:50,height:50), textColor: UIColor(hex:hex))
        } else {
            annotationView?.image = #imageLiteral(resourceName: "myLoc")
        }
        
        return annotationView
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
        categoryTable.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cat = categories[indexPath.row]
        redrawByCategory(cat: cat)
    }
    
    func redrawByCategory(cat:Category){
        activeCategory = cat
        let hex = cat.color
        categoryTable.layer.borderColor = UIColor(hex: hex).cgColor
        tabBarController?.tabBar.barTintColor = UIColor(hex: hex)
        choiceView.layer.borderColor = UIColor(hex: hex).cgColor
        if let tempView = choiceView as? ChoiceView{
            tempView.setUpByCategory(cat: cat)
        }
        categoryTable.isHidden = true
        addMarkers()
    }
    
}

extension MapVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        print(category.name)
        if let cell = categoryTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? CategoryTableCell{
            cell.setUpView(cat: category)
            return cell
        } else {
            print("fail to draw")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
            thisView.setUpByCategory(cat: category)
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
