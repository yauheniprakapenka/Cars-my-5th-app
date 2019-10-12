//
//  AddCarTableViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 12/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class AddCarTableViewController: UITableViewController {
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print("первая ячейка")
        } else {
            // Скрыть клавиатуру
            view.endEditing(true)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

}

// Скрыть клавиатуру по нажатию Done
extension AddCarTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
