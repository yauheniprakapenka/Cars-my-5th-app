//
//  AddCarTableViewController.swift
//  cars
//
//  Created by yauheni prakapenka on 12/10/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class AddCarTableViewController: UITableViewController {
    
    @IBOutlet weak var chooseCarImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

}

// Скрыть клавиатуру по нажатию Done
extension AddCarTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
        chooseCarImageView.image = info[.editedImage] as? UIImage
        chooseCarImageView.contentMode = .scaleAspectFill
        chooseCarImageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
}
