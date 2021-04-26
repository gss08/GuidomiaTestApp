//
//  ExpandableTableCell.swift
//  GuidomiaApp
//
//  Created by GSS on 2021-04-26.
//

import UIKit

class ExpandableTableCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var prosConsHeaderLabel: UILabel!
    @IBOutlet weak var proConsValueLabel: UILabel!
    @IBOutlet weak var proConsTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var proConsBottomConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Update the cell with the values from JSON
    /**
       Update the cell with the values from JSON
     - Parameters :
     - itemName: returns the pros and cons for displaying in table expanded cell
     - isFirstCell:   used to display header for cons or pros
     - isPron:   differentiate item between pros and cons
     - isLast:   used to add extra space after the last item
     */
    
    func update(with itemName: String, isFirstCell:Bool,isPron:Bool,isLast:Bool) -> Void {
        if isFirstCell,isPron{
            proConsTopConstraint.constant = 6
            prosConsHeaderLabel.text = "Pros :"
        }else if isFirstCell,!isPron{
            proConsTopConstraint.constant = 6
            prosConsHeaderLabel.text = "Cons :"
        }else{
            proConsTopConstraint.constant = 0
            prosConsHeaderLabel.text = ""
        }
        if isLast{
            proConsBottomConstraint.constant = 20
        }else{
            proConsBottomConstraint.constant = 5
        }
        proConsValueLabel.text = itemName
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
