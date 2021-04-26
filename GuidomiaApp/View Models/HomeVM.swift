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
    var proConsList = [ProConList]()
    var cellExpandedRow = 0
    
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
        if section - 1 == viewModel.cellExpandedRow{
            viewModel.proConsList.removeAll()

            /* Save all pros and cons from JSON to expandable array, which is used in displaying the pros,cons list
             */
            
            var isFirstPro = true
            if viewModel.carInfoArray[section - 1].prosList?.count ?? 0 > 0 {
                for pros in viewModel.carInfoArray[section - 1].prosList!{
                    viewModel.proConsList.append(ProConList(isFirst: isFirstPro, value: pros, isPro: true))
                    isFirstPro = false
                }
            }
            
            var isFirstCon = true
            if viewModel.carInfoArray[section - 1].consList?.count ?? 0 > 0 {
                for cons in viewModel.carInfoArray[section - 1].consList!{
                    viewModel.proConsList.append(ProConList(isFirst: isFirstCon, value: cons, isPro: false))
                    isFirstCon = false
                }
            }
            return viewModel.proConsList.count + 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* Display header view for cell
         */
        if indexPath.section == 0, indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerTableCell", for: indexPath) as! HeaderTableCell
            return cell
        }else if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "carInfoUnexpandedTableCell", for: indexPath) as! CarInfoUnexpandedTableCell
            
            /* Update cell with the values from JSON file
             */
            cell.update(with: viewModel.carInfoArray[indexPath.section - 1])
            return cell
        } else if indexPath.section - 1 == viewModel.cellExpandedRow{
            let cell = tableView.dequeueReusableCell(withIdentifier: "expandableTableCell", for: indexPath) as! ExpandableTableCell
            
            /* Update cell with the values from JSON file
             */
            
            let proCon = viewModel.proConsList[indexPath.row - 1]
            let isLastValue = indexPath.row - 1 == viewModel.proConsList.count - 1 ? true : false
            cell.update(with: proCon.value, isFirstCell: proCon.isFirst, isPron: proCon.isPro, isLast: isLastValue)
            
            return cell
        }
        return UITableViewCell()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellExpandedRow = indexPath.section - 1
        tableView.reloadData()
    }
}


struct ProConList {
    var isFirst = Bool()
    var value = String()
    var isPro = Bool()
}
