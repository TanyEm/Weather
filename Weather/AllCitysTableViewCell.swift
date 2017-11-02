//
//  AllCitysTableViewCell.swift
//  Weather
//
//  Created by Tanya Tomchuk on 01/11/2017.
//  Copyright © 2017 Tanya Tomchuk. All rights reserved.
//

import UIKit

class AllCitysTableViewCell: UITableViewCell {

    @IBOutlet weak var nameCity: UILabel!
    @IBOutlet weak var tempCity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
