//
//  SearchVC.swift
//  PinPos-Official
//
//  Created by Zhilei Zheng on 2017/9/4.
//  Copyright © 2017年 Zhilei Zheng. All rights reserved.
//

import UIKit
import MapKit
import Hue

class SearchVC: UITableViewController {
    
    var mapView:MKMapView?
    var sourceVC:AddNewVC?
    let searchController = UISearchController(searchResultsController: nil)
    var matchingItems:[MKMapItem] = []

    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let mapVC = tabBarController?.viewControllers?[0] as? MapVC{
            mapView = mapVC.mapView
        }
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.isActive = true
        searchController.isEditing = true
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = UIColor(hex: "1364A5")
        searchController.searchBar.tintColor = UIColor.white
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.isNavigationBarHidden = true
        searchController.searchBar.isHidden = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultId", for: indexPath)
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        sourceVC?.nameField.text = selectedItem.name
        sourceVC?.latField.text = String(selectedItem.coordinate.latitude)
        sourceVC?.lngField.text = String(selectedItem.coordinate.longitude)
        sourceVC?.addrField.text = parseAddress(selectedItem: selectedItem)
        navigationController?.popViewController(animated: true)
    }

}

extension SearchVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            print("got response")
            guard let response = response else {
                print("no response")
                return
            }
            print(response.mapItems.count)
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
}

extension SearchVC: UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.isHidden = true
        searchController.dismiss(animated: false, completion: showBack)
    }
    
    func showBack(){
//        navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.popViewController(animated: true)
    }
}
