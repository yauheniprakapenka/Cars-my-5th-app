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
    var indexPathForSelectedCell = 0
    var editMode = false

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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        car.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexpath = tableView.indexPathForSelectedRow else { return }
            let currentCar = car[indexpath.row]
            indexPathForSelectedCell = indexpath.row
            let addCarVC = segue.destination as! AddCarTableViewController
            addCarVC.newCar = currentCar
            editMode = true
        }
    }
    
    @IBAction func mainVCSegue(_ segue: UIStoryboardSegue) {
        guard let addCarVC = segue.source as? AddCarTableViewController else { return }
        
        addCarVC.saveNewCar()
        
        if editMode {
            car[indexPathForSelectedCell] = addCarVC.newCar!
            editMode = false
        } else {
            car.append(addCarVC.newCar!)
        }
        
        tableView.reloadData()
    }
    
}
