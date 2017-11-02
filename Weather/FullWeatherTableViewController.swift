//
//  MoreDayTampTableViewController.swift
//  Weather
//
//  Created by Tanya Tomchuk on 31/10/2017.
//  Copyright © 2017 Tanya Tomchuk. All rights reserved.
//

import UIKit

class FullWeatherTableViewController: UITableViewController {
    
    var fullCityTemp = [FullCityWeather]()
    var cityNameForMoreDay = ""
//    let spinner = UIActivityIndicatorView()
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let fullWeatherGetter = FullWeatherGetter()
        fullWeatherGetter.fullGetWeather(cityNameForMoreDay: cityNameForMoreDay, callback: {(result) -> () in
            DispatchQueue.main.async {
                self.fullCityTemp = result.list as! [FullCityWeather]
                self.tableView.reloadData()
            }
        })
    }
    

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fullCityTemp.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TempCell", for: indexPath) as! FullWeatherTableViewCell

        // Configure the cell...
        
        print(String(format: "Process row %d...", indexPath.row))
//        print(self.fullCityTemp [indexPath.row])
        cell.data?.text = self.fullCityTemp [indexPath.row].dt_txt
        cell.temp?.text = String(format: "%.2f°C", (self.fullCityTemp [indexPath.row].main?.temp)!)
        cell.status?.text = self.fullCityTemp [indexPath.row].weather[0]?.status
        cell.maxTemp?.text = String(format: "Max: %.0f°C", (self.fullCityTemp [indexPath.row].main?.temp_max)!)
        cell.minTemp?.text = String(format: "Min: %.0f°C", (self.fullCityTemp [indexPath.row].main?.temp_min)!)

        return cell
    }

}
