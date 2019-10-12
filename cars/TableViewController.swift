//
//  TableViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 12/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let data: [CarModel] = [CarModel(year: "1995", manufacturer: "BMW", model: "5", body: "E39", carImage: #imageLiteral(resourceName: "bmw-m5-e39-8")),
                            CarModel(year: "2010", manufacturer: "Nissan", model: "Juke", body: "B", carImage: #imageLiteral(resourceName: "nissan-juke"))]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell

        cell.manufacturerModelBodyLabel.text = data[indexPath.row].manufacturer + " \(data[indexPath.row].model)" + " \(data[indexPath.row].body)"
        cell.yearLabel.text = data[indexPath.row].year
        cell.carImageView.image = data[indexPath.row].carImage
        cell.carImageView.layer.cornerRadius = 12
        
        return cell
    }
    
}
