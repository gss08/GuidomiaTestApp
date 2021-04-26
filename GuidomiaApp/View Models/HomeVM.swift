//
//  HomeVM.swift
//  GuidomiaApp
//
//  Created by GSS on 2021-04-25.
//

import Foundation
import UIKit

class HomeVM{
    
}


extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0, indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerTableCell", for: indexPath) as! HeaderTableCell
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "carInfoUnexpandedTableCell", for: indexPath) as! CarInfoUnexpandedTableCell
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return 0.001
        }else{
            return 24
        }
    }
    
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
