//
//  Services_Custom_Cell.swift
//  Friends2Friends
//
//  Created by mbp13i5 on 18/08/17.
//  Copyright © 2017 GoHash. All rights reserved.
//

import UIKit

class Services_Custom_Cell: UITableViewCell {
    
    // header row 
    
    @IBOutlet weak var icon_img: UIImageView!
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var sub_title_lbl: UILabel!
    @IBOutlet weak var action_on_off_img: UIImageView!
    @IBOutlet weak var header_btn: UIButton!
    
    // sub_row 
    
    @IBOutlet weak var sub_row_lbl: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
