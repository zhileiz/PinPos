//
//  ListVC.swift
//  PinPos-Official
//
//  Created by Zhilei Zheng on 2017/9/2.
//  Copyright © 2017年 Zhilei Zheng. All rights reserved.
//

import UIKit
import Hue
import SwiftIcons

class ListVC: UITableViewController {

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let back = UIBarButtonItem()
        back.title = ""
        back.tintColor = UIColor(hex: "1364A5")
        navigationItem.backBarButtonItem = back
    }


}
