//
//  AllCitysTableViewController.swift
//  Weather
//
//  Created by Tanya Tomchuk on 25/10/2017.
//  Copyright © 2017 Tanya Tomchuk. All rights reserved.
//

import UIKit

class AllCitysTableViewController: UITableViewController, AddAndEditItemViewControllerDelegate {
    
    var items: [CityItem]
    
    required init?(coder aDecoder: NSCoder) {
        items = [CityItem]()
        
        let row0item = CityItem()
        row0item.cityName = "Saint-Peterburg"
        items.append(row0item)
        
        let row1item = CityItem()
        row1item.cityName = "Moscow"
        items.append(row1item)
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func configureCityName(for cell: UITableViewCell, with item: CityItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.cityName
    }
    
    func addAndEditItemViewControllerDidCancel(
        _ controller: AddAndEditItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addAndEditItemViewController(_ controller: AddAndEditItemViewController, didFinishEditing item: CityItem) {
        if let index = items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureCityName(for: cell, with: item)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func addAndEditItemViewController(_ controller: AddAndEditItemViewController, didFinishAdding item: CityItem) {
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) {
//            let item = items[indexPath.row]
//        }
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityItem", for: indexPath)

        // Configure the cell...
        let item = items[indexPath.row]
        configureCityName(for: cell, with: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)

        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }


    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddCity" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddAndEditItemViewController
            
            controller.delegate = self
        } else if segue.identifier == "EditCity" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddAndEditItemViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }

}
