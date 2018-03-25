//
//  ViewController.swift
//  MealTime
//
//  Created by zslavman on 25.03.18.
//  Copyright © 2018 HomeMade. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countTF: UILabel!
    
    var array = [Date]()
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var instances: [Happydate] = [] // массив экземпляров Кор Дата
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM.dd.yy - HH:mm:ss"
        return dateFormater
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        fetchData()
    }
        
    
    
    
    
    // Получение данных (способ 2)
    func fetchData(){
        
        let fetch_Raquest: NSFetchRequest<Happydate> = Happydate.fetchRequest()
        do {
            instances = try context.fetch(fetch_Raquest)
            tableView.reloadData()
            countTF.text = String(instances.count)
        }
        catch { print("Не удалось получить данные ") }
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Время когда я ел вкусняшки"
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instances.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        //        let date = array[indexPath.row]
        let dateToPrint:Happydate = instances[indexPath.row]
        cell!.textLabel!.text = dateFormatter.string(from: dateToPrint.fixationTime as! Date)
        
        //        cell!.textLabel!.text = dateFormatter.string(from: date)
        
        return cell!
    }
    
    
    
    
    @IBAction func onAddClick(_ sender: UIBarButtonItem) {
        
        //        let date = Date()
        //        array.append(date)
        //        tableView.reloadData()
        
        let date = Date() // запоминаем дату во время нажатия на "+"
        let inst: Happydate = Happydate(context: context)
        inst.fixationTime = date as NSDate
        instances.append(inst)
        countTF.text = String(instances.count)
        do {
            try context.save()
            tableView.reloadData()
        }
        catch { print("Не удалось сохранить данные") }
    }
    
    
    
    @IBAction func onDeleteClick(_ sender: UIBarButtonItem) {
        
        instances.removeAll()
        countTF.text = String(instances.count)

        
        // медленный способ
//        let fetchRequest = NSFetchRequest<Happydate>(entityName: "Happydate")
//        do {
//            let items = try context.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
//            
//            for item in items {
//                context.delete(item)
//            }
//            try context.save()
//            tableView.reloadData()
//        }
//        catch { print("Не удалось сохранить данные") }
        
        
        // быстрый способ - очистка всего контекста
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Happydate")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
            tableView.reloadData()
        }
        catch { print("Не удалось сохранить данные") }
        
        
        
        
        

        
    }
    
    
    
    
}




























