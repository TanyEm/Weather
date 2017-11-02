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
    var city = [CityItem]()
    let weatherGetter = WeatherGetter()
    
    required init?(coder aDecoder: NSCoder) {
        items = [CityItem]()
        
        let row0item = CityItem()
        row0item.cityName = "Saint-Peterburg"
        row0item.temp = "4"
        items.append(row0item)
        
        let row1item = CityItem()
        row1item.cityName = "Moscow"
        row1item.temp = "3"
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

    func configureCityName(for cell: AllCitysTableViewCell, with item: CityItem) {
//        let labelName = cell.viewWithTag(1000) as! UILabel
//        labelName.text = item.cityName
        cell.nameCity?.text = item.cityName

    }
//
    func configureCityTemp(for cell: AllCitysTableViewCell, with item: CityItem) {
//        let labelTemp = cell.viewWithTag(1001) as! UILabel
//        labelTemp.text = item.temp
        cell.tempCity?.text = item.temp
    }
    
    func addAndEditItemViewControllerDidCancel(
        _ controller: AddAndEditItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addAndEditItemViewController(_ controller: AddAndEditItemViewController, didFinishEditing item: CityItem) {
        if let index = items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureCityName(for: cell as! AllCitysTableViewCell, with: item)
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityItem", for: indexPath) as! AllCitysTableViewCell

        // Configure the cell...
        let item = items[indexPath.row]
        configureCityName(for: cell, with: item)
        configureCityTemp(for: cell, with: item)
        
//        cell.nameCity?.text = city [indexPath.row].cityName
//        cell.tempCity?.text = city [indexPath.row].temp
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)

        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }


    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case "AddCity"?:
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddAndEditItemViewController
            
            controller.delegate = self
            
        case "EditCity"?:
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddAndEditItemViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
            
        case "ShowCity"?:
            let path = self.tableView.indexPathForSelectedRow!
            let viewController = segue.destination as! CityWeatherViewController
            viewController.cityName = self.items[path.row].cityName
            
        default:
            print("Error")
        }
    }

}
