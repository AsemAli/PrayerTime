//
//  CustomTableViewCell.swift
//  Prayer Time
//
//  Created by Asem Qaffaf on 10/13/18.
//  Copyright © 2018 Asem Qaffaf. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var prayerBody: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
