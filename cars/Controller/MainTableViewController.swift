//
//  TableViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 12/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var car = Car.getCars()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return car.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        cell.manufacturerModelBodyLabel.text = car[indexPath.row].manufacturer + " \(car[indexPath.row].model)" + " \(car[indexPath.row].body)"
        cell.yearLabel.text = car[indexPath.row].year
        cell.carImageView.image = car[indexPath.row].carImage
        cell.carImageView.layer.cornerRadius = 10
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    @IBAction func mainVCSegue(_ segue: UIStoryboardSegue) {
        guard let addCarVC = segue.source as? AddCarTableViewController else { return }
        
        addCarVC.saveNewCar()
        car.append(addCarVC.newCar!)
        tableView.reloadData()
    }
    
}
