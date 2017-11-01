//
//  FullWeatherTableViewCell.swift
//  Weather
//
//  Created by Tanya Tomchuk on 31/10/2017.
//  Copyright © 2017 Tanya Tomchuk. All rights reserved.
//

import UIKit

class FullWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
