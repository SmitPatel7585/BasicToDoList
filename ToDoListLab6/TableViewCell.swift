//
//  TableViewCell.swift
//  ToDoListLab6
//
//  Created by user235217 on 2/18/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var name: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
