//
//  AddAndEditItemViewController.swift
//  Weather
//
//  Created by Tanya Tomchuk on 25/10/2017.
//  Copyright © 2017 Tanya Tomchuk. All rights reserved.
//

import Foundation
import UIKit

protocol AddAndEditItemViewControllerDelegate: class {
    func addAndEditItemViewControllerDidCancel(_ controller: AddAndEditItemViewController)
    func addAndEditItemViewController(_ controller: AddAndEditItemViewController,didFinishAdding item: CityItem)
    func addAndEditItemViewController(_ controller: AddAndEditItemViewController, didFinishEditing item: CityItem)
}

class AddAndEditItemViewController: UITableViewController, UITextFieldDelegate {
    
    var itemToEdit: CityItem?
    
    weak var delegate: AddAndEditItemViewControllerDelegate?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBAction func cancel() {
        delegate?.addAndEditItemViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let item = itemToEdit {
            item.cityName = textField.text!
            delegate?.addAndEditItemViewController(self, didFinishEditing: item)
        } else {
            let item = CityItem()
            item.cityName = textField.text!
            delegate?.addAndEditItemViewController(self, didFinishAdding: item)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit City"
            textField.text = item.cityName
            doneBarButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string)

        doneBarButton.isEnabled = (newText.characters.count > 0)
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}
