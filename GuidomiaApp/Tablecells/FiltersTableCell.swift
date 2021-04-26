//
//  FiltersTableCell.swift
//  GuidomiaApp
//
//  Created by GSS on 2021-04-26.
//

import UIKit

class FiltersTableCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var resetFilterButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
