//
//  ListVC.swift
//  PinPos-Official
//
//  Created by Zhilei Zheng on 2017/9/2.
//  Copyright © 2017年 Zhilei Zheng. All rights reserved.
//

import UIKit
import MapKit
import Hue
import SwiftIcons
import RealmSwift
import Realm

class ListVC: UITableViewController {
    
    let realm = try! Realm()
    var places = [Place]()
    var categories = [Category]()

    @IBAction func addNew(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addNew", sender: sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "EAEAEA")
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 20)!,
            NSForegroundColorAttributeName: UIColor(hex: "1364A5")]
        if let item = self.navigationItem.rightBarButtonItem{
            item.setIcon(icon: .icofont(.pencilAlt2), iconSize: 20, color: UIColor(hex: "1364A5"))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.barTintColor = UIColor(hex: "1364A5")
        populatePlace()
        populateCategories()
        tableView.reloadData()
    }
    
    func populatePlace(){
        self.places.removeAll()
        let plx = realm.objects(Place.self)
        for p in plx{
            print(p.name)
            self.places.append(p)
        }
    }
    
    func populateCategories(){
        self.categories.removeAll()
        let cats = realm.objects(Category.self)
        for cat in cats{
            print(cat.name)
            self.categories.append(cat)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        var category = Category()
        for cat in categories{
            if cat.name == place.categoryName{
                category = cat
                break
            }
        }
        let coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        if let mapVC = tabBarController?.customizableViewControllers?[0] as? MapVC{
            mapVC.activeCategory = category
            mapVC.mapView.setCenter(coordinate, animated: true)
            self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers?[0]
            mapVC.getRouteTo(coordinate: coordinate, name: place.name)
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = places[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "placeId", for: indexPath) as? PlacesTableCell{
            cell.setUpView(place: place)
            return cell
        } else {
            print("Failed to draw place cell")
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let back = UIBarButtonItem()
        back.title = ""
        back.tintColor = UIColor(hex: "1364A5")
        navigationItem.backBarButtonItem = back
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            let place = places.remove(at: indexPath.row)
            try! realm.write {
                realm.delete(place)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}
