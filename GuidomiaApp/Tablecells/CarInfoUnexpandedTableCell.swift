//
//  CarInfoUnexpandedTableCell.swift
//  GuidomiaApp
//
//  Created by GSS on 2021-04-26.
//

import UIKit

class CarInfoUnexpandedTableCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carPriceLabel: UILabel!
    @IBOutlet weak var star1ImageView: UIImageView!
    @IBOutlet weak var star2ImageView: UIImageView!
    @IBOutlet weak var star3ImageView: UIImageView!
    @IBOutlet weak var star4ImageView: UIImageView!
    @IBOutlet weak var star5ImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Update the cell with the values from JSON
    func update(with carInfo: CarInfo_Base) -> Void {
        
        if let make = carInfo.make{
            carNameLabel.text = make
        }
        
        if let model = carInfo.model{
            carNameLabel.text = carNameLabel.text ?? " " + " " + model
            carImageView.image = getCarImageBasedOnType(name: model)
        }

        if let price = carInfo.customerPrice{
            let priceInString = Double(price).formatPoints(num: price)
            carPriceLabel.text = "Price : \(priceInString)"
        }
        displayRating(value: Int(carInfo.rating ?? 0))
        
    }
    
    //MARK: - Get car image using the name from the JSON
    func getCarImageBasedOnType(name:String) -> UIImage?{
        if name == "Range Rover"{
            return UIImage(named: "Range_Rover")
        }else if name == "Roadster"{
            return UIImage(named: "Alpine_roadster")
        }else if name == "3300i"{
            return UIImage(named: "BMW_330i")
        }else if name == "GLE coupe"{
            return UIImage(named: "Mercedez_benz_GLC")
        }else{
            return nil
        }
    }
    
    //MARK: - Displays rating from the JSON
    func displayRating(value :Int){
        if value == 0{
            star1ImageView.tintColor = .clear
            star2ImageView.tintColor = .clear
            star3ImageView.tintColor = .clear
            star4ImageView.tintColor = .clear
            star5ImageView.tintColor = .clear
        }else if value == 1{
            star1ImageView.tintColor = orangeColor
            star2ImageView.tintColor = .clear
            star3ImageView.tintColor = .clear
            star4ImageView.tintColor = .clear
            star5ImageView.tintColor = .clear
        }else if value == 2{
            star1ImageView.tintColor = orangeColor
            star2ImageView.tintColor = orangeColor
            star3ImageView.tintColor = .clear
            star4ImageView.tintColor = .clear
            star5ImageView.tintColor = .clear
        }else if value == 3{
            star1ImageView.tintColor = orangeColor
            star2ImageView.tintColor = orangeColor
            star3ImageView.tintColor = orangeColor
            star4ImageView.tintColor = .clear
            star5ImageView.tintColor = .clear
        }else if value == 4{
            star1ImageView.tintColor = orangeColor
            star2ImageView.tintColor = orangeColor
            star3ImageView.tintColor = orangeColor
            star4ImageView.tintColor = orangeColor
            star5ImageView.tintColor = .clear
        }else if value == 5{
            star1ImageView.tintColor = orangeColor
            star2ImageView.tintColor = orangeColor
            star3ImageView.tintColor = orangeColor
            star4ImageView.tintColor = orangeColor
            star5ImageView.tintColor = orangeColor
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
