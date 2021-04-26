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
    var backupCarInfoArray = [CarInfo_Base]()
    var proConsList = [ProConList]()
    var cellExpandedRow = 1
    var menuButtonPressed = true
    let pickerView = ToolbarPickerView()
    
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
        
        if viewModel.menuButtonPressed{
            return viewModel.carInfoArray.count + 2
        }
        
        return viewModel.carInfoArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.menuButtonPressed, section == 1{
            if section - 2 == viewModel.cellExpandedRow{
                viewModel.proConsList.removeAll()

                /* Save all pros and cons from JSON to expandable array, which is used in displaying the pros,cons list
                 */
                
                var isFirstPro = true
                if viewModel.carInfoArray[section - 2].prosList?.count ?? 0 > 0 {
                    for pros in viewModel.carInfoArray[section - 2].prosList!{
                        viewModel.proConsList.append(ProConList(isFirst: isFirstPro, value: pros, isPro: true))
                        isFirstPro = false
                    }
                }
                
                var isFirstCon = true
                if viewModel.carInfoArray[section - 2].consList?.count ?? 0 > 0 {
                    for cons in viewModel.carInfoArray[section - 2].consList!{
                        viewModel.proConsList.append(ProConList(isFirst: isFirstCon, value: cons, isPro: false))
                        isFirstCon = false
                    }
                }
                return viewModel.proConsList.count + 2
            }
        }else{
            if section - 1 == viewModel.cellExpandedRow{
                viewModel.proConsList.removeAll()

                /* Save all pros and cons from JSON to expandable array, which is used in displaying the pros,cons list
                 */
                
                var isFirstPro = true
                if viewModel.carInfoArray[section - 2].prosList?.count ?? 0 > 0 {
                    for pros in viewModel.carInfoArray[section - 2].prosList!{
                        viewModel.proConsList.append(ProConList(isFirst: isFirstPro, value: pros, isPro: true))
                        isFirstPro = false
                    }
                }
                
                var isFirstCon = true
                if viewModel.carInfoArray[section - 2].consList?.count ?? 0 > 0 {
                    for cons in viewModel.carInfoArray[section - 2].consList!{
                        viewModel.proConsList.append(ProConList(isFirst: isFirstCon, value: cons, isPro: false))
                        isFirstCon = false
                    }
                }
                return viewModel.proConsList.count + 1
            }
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
        }else if indexPath.section == 1, indexPath.row == 0,viewModel.menuButtonPressed{
            let cell = tableView.dequeueReusableCell(withIdentifier: "filtersTableCell", for: indexPath) as! FiltersTableCell
            cell.makeTextField.inputView = viewModel.pickerView
            cell.modelTextField.inputView = viewModel.pickerView
            
            cell.makeTextField.inputAccessoryView = viewModel.pickerView.toolbar
            cell.modelTextField.inputAccessoryView = viewModel.pickerView.toolbar
            
            // Button action for follow user
            cell.resetFilterButton.addTarget(self, action: #selector(resetFilterButtonTapped(_:)), for: .touchUpInside)

            return cell
        }else if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "carInfoUnexpandedTableCell", for: indexPath) as! CarInfoUnexpandedTableCell
            
            /* Update cell with the values from JSON file
             */
            
            if viewModel.menuButtonPressed{
                cell.update(with: viewModel.carInfoArray[indexPath.section - 2] )
            }else{
                cell.update(with: viewModel.carInfoArray[indexPath.section - 1])
            }
            
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
        }else if viewModel.menuButtonPressed, section == 1{
            return 0.001
        }else{
            return 24
        }
    }
    
    /* Custom view for footer with orange sepatation line
     */
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         if viewModel.menuButtonPressed, section == 1{
            return nil
        }else if section != 0{
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
    
    /* Expanding cells based on user selection
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellExpandedRow = indexPath.section - 1
        tableView.reloadData()
    }
    
    //MARK: - Reset filters
    @objc func resetFilterButtonTapped(_ sender:UIButton?){
         
         viewModel.carInfoArray = viewModel.backupCarInfoArray
        
        /* Clearing filter texts
         */
         let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? FiltersTableCell
         cell?.makeTextField.text = ""
         cell?.modelTextField.text = ""

         tableView.reloadData()
    }
}

extension HomeViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: UIPickerView Delegates, DataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.carInfoArray.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! FiltersTableCell
        if cell.makeTextField.isFirstResponder {
            return viewModel.carInfoArray[row].make
        }else{
            return viewModel.carInfoArray[row].model
        }
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! FiltersTableCell
        if cell.makeTextField.isFirstResponder {
            cell.makeTextField.text = viewModel.carInfoArray[row].make
        }else{
            cell.modelTextField.text = viewModel.carInfoArray[row].model
        }
    }
}

extension HomeViewController: ToolbarPickerViewDelegate {

    //MARK: - Select value on click of toolbar done button
    func didTapDone() {
        let row = viewModel.pickerView.selectedRow(inComponent: 0)
        viewModel.pickerView.selectRow(row, inComponent: 0, animated: false)
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! FiltersTableCell
        if cell.makeTextField.isFirstResponder {
            cell.makeTextField.text = viewModel.carInfoArray[row].make
            cell.makeTextField.resignFirstResponder()
            
            let filtertedMakeArray = viewModel.backupCarInfoArray.filter { $0.make == viewModel.carInfoArray[row].make }
            viewModel.carInfoArray = filtertedMakeArray
           
        }else{
            cell.modelTextField.text = viewModel.carInfoArray[row].model
            cell.modelTextField.resignFirstResponder()
            
            let filtertedMakeArray = viewModel.backupCarInfoArray.filter { $0.model == viewModel.carInfoArray[row].model }
            viewModel.carInfoArray = filtertedMakeArray
        }
        
       // viewModel.menuButtonPressed = false
        tableView.reloadData()
    }

    //MARK: - Dismiss pickerView and clearing textfield texts
    func didTapCancel() {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! FiltersTableCell
        if cell.makeTextField.isFirstResponder {
            cell.makeTextField.text = nil
            cell.makeTextField.resignFirstResponder()
        }else{
            cell.modelTextField.text = nil
            cell.modelTextField.resignFirstResponder()
        }

    }
}

struct ProConList {
    var isFirst = Bool()
    var value = String()
    var isPro = Bool()
}
