//
//  HomeVM.swift
//  GuidomiaApp
//
//  Created by GSS on 2021-04-25.
//

import Foundation
import UIKit
import CoreData

class HomeVM{
    
    // MARK: - Properties
    var carInfoArray = [CarInfo_Base]()
    
    
    // MARK: - Load JSON file and returns the response in CarInfo_Base format
    func loadJson(filename fileName: String) -> [CarInfo_Base]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try! decoder.decode([CarInfo_Base].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}


extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        /* Count is incrememted by 1 because of header cell which should be displayed each time
         */
        return viewModel.carInfoArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* Display header view for cell
         */
        if indexPath.section == 0, indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerTableCell", for: indexPath) as! HeaderTableCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "carInfoUnexpandedTableCell", for: indexPath) as! CarInfoUnexpandedTableCell
            
            /* Update cell with the values from JSON file
             */
            cell.update(with: viewModel.carInfoArray[indexPath.section - 1])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            /* Hide footer
             */
            return 0.001
        }else{
            return 24
        }
    }
    
    /* Custom view for footer with orange sepatation line
     */
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section != 0{
            let footerContentView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 24))
            footerContentView.backgroundColor = .white
            
            let footerView =   UIView(frame: CGRect(x: 15, y: 10, width: screenWidth - 30, height: 4))
            footerView.tintColor = .white
            footerView.backgroundColor = orangeColor
            footerView.layer.cornerRadius = 2
            footerContentView.addSubview(footerView)
            return footerContentView
        }else{
            return nil
        }
    }    
    
}
