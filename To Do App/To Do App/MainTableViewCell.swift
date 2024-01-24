//
//  MainTableViewCell.swift
//  To Do App
//
//  Created by LinhMAC on 25/01/2024.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var desciptionLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func blinData(title: String, desciption: String){
        titleLb.text = title
        desciptionLb.text = desciption
    }
    
}
