//
//  TableViewCell.swift
//  RealmvsMVVM
//
//  Created by win on 4/3/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblDistrict: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblProvince: UILabel!
    
    var item : Item? {
        didSet{
            lblCode.text = item?.code
            lblDistrict.text = item?.district
            lblProvince.text = item?.province
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
