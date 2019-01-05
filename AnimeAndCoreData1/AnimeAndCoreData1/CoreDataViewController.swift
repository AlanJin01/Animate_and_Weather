//
//  CoreDataViewController.swift
//  AnimeAndCoreData1
//
//  Created by J K on 2019/1/5.
//  Copyright © 2019 Kims. All rights reserved.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func finding() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Weather", in: context)
        
        let request = NSFetchRequest<Weather>(entityName: "Weather")
        request.fetchOffset = 0
        request.fetchLimit = 20
        request.predicate = nil
        request.entity = entity
        
        do {
            let results: [AnyObject] = try! context.fetch(request)
            for i in results as! [Weather] {
                print("城市名: \(i.city!)")
                print("气温: \(i.temp!)")
                print("天气: \(i.weather!)")
            }
        }catch {
            print("读取数据失败")
        }
    }
    
    func saving(_ city: String, _ temp: String, _ weather: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newObj = NSEntityDescription.insertNewObject(forEntityName: "Weather", into: context) as! Weather
        
        newObj.city = city
        newObj.temp = temp
        newObj.weather = weather
        
        do {
            try context.save()
            print("保存成功")
        }catch {
            print("保存数据失败")
        }
    }
}
