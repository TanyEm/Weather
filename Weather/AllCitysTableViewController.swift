//
//  AllCitysTableViewController.swift
//  Weather
//
//  Created by Tanya Tomchuk on 25/10/2017.
//  Copyright © 2017 Tanya Tomchuk. All rights reserved.
//

import UIKit
import CoreData

class AllCitysTableViewController: UITableViewController, AddAndEditItemViewControllerDelegate {
    var cities =  [City]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        // iOS not collapsing large navbar workaround
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let newCities = City.mr_findAll() as? [City] {
            cities = newCities
        }
    }

    func configureCityName(for cell: AllCitysTableViewCell, with item: City) {
        cell.nameCity?.text = item.cityName
    }

    func configureCityTemp(for cell: AllCitysTableViewCell, with item: City, for indexPath:  IndexPath) {

        let weatherGetter = WeatherGetter()
        weatherGetter.getWeather(cityName: cities[indexPath.row].cityName!, callback: {(result) -> () in
            print(result)

            DispatchQueue.main.async {
                guard let tempCity = result.main?.temp else { return }
                print(tempCity)
                cell.tempCity?.text = "\(tempCity)"
            }
        })
    }
    
    func addAndEditItemViewControllerDidCancel(
        _ controller: AddAndEditItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addAndEditItemViewController(_ controller: AddAndEditItemViewController, didFinishEditing item: City) {
        if let index = cities.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureCityName(for: cell as! AllCitysTableViewCell, with: item)
            }
        }
        self.tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func addAndEditItemViewController(_ controller: AddAndEditItemViewController, didFinishAdding item: City) {
        let newRowIndex = cities.count
        cities.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityItem", for: indexPath) as! AllCitysTableViewCell

        // Configure the cell...
        let item = cities[indexPath.row]
        configureCityName(for: cell, with: item)
        configureCityTemp(for: cell, with: item, for: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let cityToDelete = cities[indexPath.row]
        if !cityToDelete.mr_deleteEntity() {
            // ERROR OCCURED
            print("ERROR DURING ENTITY DELETION")
        }
        
        cities.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        // No need in background context cause of 1 object deletion
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore { didSave, error in
            if !didSave {
                print(error)
            } else {
                print("SUCCESSFULLY SAVED CONTEXT")
            }
        }
    }


    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case "AddCity"?:
            let navigationController = segue.destination as? UINavigationController
            let controller = navigationController?.topViewController as? AddAndEditItemViewController
            
            controller?.delegate = self
            
        case "EditCity"?:
            let navigationController = segue.destination as? UINavigationController
            let controller = navigationController?.topViewController as? AddAndEditItemViewController
            controller?.delegate = self
            
            if let indexPath = tableView.indexPath(for: (sender as? UITableViewCell)!) {
                controller?.itemToEdit = cities[indexPath.row]
            }
            
        case "ShowCity"?:
            let path = self.tableView.indexPathForSelectedRow!
            let viewController = segue.destination as? CityWeatherViewController
            viewController?.cityName = self.cities[path.row].cityName!
            
        default:
            print("Error")
        }
    }

}
