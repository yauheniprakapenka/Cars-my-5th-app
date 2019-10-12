//
//  AddCarTableViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 12/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class AddCarTableViewController: UITableViewController {
    
    var newCar: Car?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var manufacturerTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        
        textFieldAddTargetForEditingChanged()
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
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        actionSheet.addAction(photo)
        actionSheet.addAction(camera)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    fileprivate func textFieldAddTargetForEditingChanged() {
        yearTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        manufacturerTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        modelTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        bodyTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    func saveNewCar() {
        newCar = Car(year: yearTextField.text!,
                     manufacturer: manufacturerTextField.text!,
                     model: modelTextField.text!,
                     body: bodyTextField.text!,
                     carImage: carImageView.image!)
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
        carImageView.contentMode = .scaleAspectFill
        carImageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
}
