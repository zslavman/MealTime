//
//  ViewController.swift
//  MealTime
//
//  Created by zslavman on 25.03.18.
//  Copyright © 2018 HomeMade. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var array = [Date]()
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM.dd.yy - HH:mm:ss"
        return dateFormater
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Время когда я ел вкусняшки"
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let date = array[indexPath.row]
        
        cell!.textLabel!.text = dateFormatter.string(from: date)
        return cell!
    }
    
    
    
    
    @IBAction func addButtonPressed(_ sender: AnyObject) {
        let date = Date()
        array.append(date)
        tableView.reloadData()
    }
    
}


