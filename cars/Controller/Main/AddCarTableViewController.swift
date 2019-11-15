//
//  AddCarTableViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 12/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class AddCarTableViewController: UITableViewController {
    
    var newCar: CarModel?
    var networkDataFetcher = NetworkDataFetcher()
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var manufacturerTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    @IBOutlet weak var yearCheckImageView: UIImageView!
    @IBOutlet weak var manufacturerCheckImageView: UIImageView!
    @IBOutlet weak var modelCheckImageView: UIImageView!
    @IBOutlet weak var bodyCheckImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        
        textFieldAddTargetForEditingChanged()
        
        setupEditScreen()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            presentActionSheet()
        } else {
            view.endEditing(true) // Скрыть клавиатуру
        }
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private func presentActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: "Откуда добавим фото?", preferredStyle: .actionSheet)
        
        let photo = UIAlertAction(title: "Галерея", style: .default) { _ in
                   self.chooseImagepicker(source: .photoLibrary)
               }
        
        let camera = UIAlertAction(title: "Камера", style: .default) { _ in
            self.chooseImagepicker(source: .camera)
        }
        
        let automatic = UIAlertAction(title: "Автоматически", style: .default) { _ in
            guard let manufacturerField = self.manufacturerTextField.text, manufacturerField != "" else {
                print(" пусто ")
                self.manufacturerTextField.shake()
                self.manufacturerTextField.attributedPlaceholder = NSAttributedString(string: "Введите производителя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                return
            }
            self.networkDataFetcher.fetchImage(searchTerm: "\(self.manufacturerTextField.text!)") { [weak self] (searchResults) in
                searchResults?.results.map({ (photo) in
                    print(photo.urls["small"] as Any)
                    let url = URL(string: photo.urls["small"]!)
                    self!.carImageView.load(url: url!)
                })
            }
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        actionSheet.addAction(photo)
        actionSheet.addAction(camera)
        actionSheet.addAction(cancel)
        actionSheet.addAction(automatic)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    fileprivate func textFieldAddTargetForEditingChanged() {
        yearTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        manufacturerTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        modelTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        bodyTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    func saveNewCar() {
        newCar = CarModel(year: yearTextField.text!,
                     manufacturer: manufacturerTextField.text!,
                     model: modelTextField.text!,
                     body: bodyTextField.text!,
                     carImage: carImageView.image!)
    }
    
    private func setupEditScreen() {
        if newCar != nil {
            carImageView.image = newCar?.carImage
            yearTextField.text = newCar?.year
            manufacturerTextField.text = newCar?.manufacturer
            modelTextField.text = newCar?.model
            bodyTextField.text = newCar?.body
            
            navigationItem.leftBarButtonItem = nil
            title = newCar?.manufacturer
            saveButton.isEnabled = true
            
            let backButton = navigationController?.navigationBar.topItem
            backButton?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }

}

// Скрыть клавиатуру по нажатию Done
extension AddCarTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if yearTextField.text?.isEmpty == true || manufacturerTextField.text?.isEmpty == true || modelTextField.text?.isEmpty == true || bodyTextField.text?.isEmpty == true {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
        
        if yearTextField.text?.isEmpty == true {
            yearCheckImageView.image = #imageLiteral(resourceName: "checkGrey")
        } else {
            yearCheckImageView.image = #imageLiteral(resourceName: "checkGreen")
        }
        
        if manufacturerTextField.text?.isEmpty == true {
            manufacturerCheckImageView.image = #imageLiteral(resourceName: "checkGrey")
        } else {
            manufacturerCheckImageView.image = #imageLiteral(resourceName: "checkGreen")
        }
        
        if modelTextField.text?.isEmpty == true {
            modelCheckImageView.image = #imageLiteral(resourceName: "checkGrey")
        } else {
               modelCheckImageView.image = #imageLiteral(resourceName: "checkGreen")
           }
        
        if bodyTextField.text?.isEmpty == true {
            bodyCheckImageView.image = #imageLiteral(resourceName: "checkGrey")
        } else {
            bodyCheckImageView.image = #imageLiteral(resourceName: "checkGreen")
            }
        }
    
    }

// Работа с изображением
extension AddCarTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagepicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        carImageView.image = info[.editedImage] as? UIImage
//        carImageView.contentMode = .scaleAspectFill
        carImageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
}


