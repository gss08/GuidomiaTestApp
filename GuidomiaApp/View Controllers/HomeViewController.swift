//
//  ViewController.swift
//  GuidomiaApp
//
//  Created by GSS on 2021-04-25.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let viewModel = HomeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addLeftNavigationTitle()
        
        /* Load data from JSON file
         */
        readJson()
    }
    
    /* Add navigation title to left navigation bar
     */
    func addLeftNavigationTitle(){
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "GUIDOMIA"
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 25)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
    
    // MARK: - Load data from JSON file and displays in tableView
    func readJson(){
        if let carInfoArray = viewModel.loadJson(filename: "car_list"){
            viewModel.carInfoArray = carInfoArray
            tableView.reloadData()
        }
    }
}

