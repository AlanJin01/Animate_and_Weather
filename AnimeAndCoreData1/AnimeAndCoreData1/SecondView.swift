//
//  SecondView.swift
//  AnimeAndCoreData1
//
//  Created by J K on 2019/1/4.
//  Copyright © 2019 Kims. All rights reserved.
//

import UIKit

class SecondView: UIView {
    
    private var cityLabel: UILabel!
    private var tempLabel: UILabel!
    private var weatherLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 1, green: 0.6054417075, blue: 0.5035040596, alpha: 1)
        
        //城市名标签
        cityLabel = UILabel(frame: CGRect(x: 30, y: 100, width: 180, height: 40))
        cityLabel.center = CGPoint(x: self.center.x, y: 40)
        cityLabel.text = "City: N/A"
        cityLabel.textAlignment = NSTextAlignment.center
        self.addSubview(cityLabel)
        
        //温度标签
        tempLabel = UILabel(frame: CGRect(x: 30, y: 100, width: 180, height: 40))
        tempLabel.center = CGPoint(x: self.center.x, y: 70)
        tempLabel.text = "Temp: N/A ℃"
        tempLabel.textAlignment = NSTextAlignment.center
        self.addSubview(tempLabel)
        
        //天气状况标签
        weatherLabel = UILabel(frame: CGRect(x: 30, y: 100, width: 240, height: 40))
        weatherLabel.center = CGPoint(x: self.center.x, y: 100)
        weatherLabel.text = "Weather: N/A"
        weatherLabel.textAlignment = NSTextAlignment.center
        self.addSubview(weatherLabel)
        
        //输入城市名按钮
        let btn = UIButton(frame: CGRect(x: 30, y: 100, width: 100, height: 40))
        btn.center = CGPoint(x: self.center.x, y: self.frame.size.height - 100)
        btn.setTitle("add", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 1, green: 0.6054417075, blue: 0.5035040596, alpha: 1), for: .normal)
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(SecondView.addCityNameButton), for: .touchUpInside)
        self.addSubview(btn)
        
        //保存按钮
        let saveBtn = UIButton(frame: CGRect(x: 30, y: 100, width: 100, height: 40))
        saveBtn.center = CGPoint(x: self.center.x, y: self.frame.size.height - 180)
        saveBtn.setTitle("save", for: .normal)
        saveBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        saveBtn.setTitleColor(#colorLiteral(red: 0.7057422381, green: 0.5217563135, blue: 1, alpha: 1), for: .normal)
        saveBtn.layer.cornerRadius = 15
        saveBtn.addTarget(self, action: #selector(SecondView.saveButton), for: .touchUpInside)
        self.addSubview(saveBtn)
        
        //读取保存数据按钮
        let loadBtn = UIButton(frame: CGRect(x: 30, y: 100, width: 100, height: 40))
        loadBtn.center = CGPoint(x: self.center.x, y: self.frame.size.height - 260)
        loadBtn.setTitle("load", for: .normal)
        loadBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        loadBtn.setTitleColor(#colorLiteral(red: 0.4338542999, green: 0.4024065637, blue: 1, alpha: 1), for: .normal)
        loadBtn.layer.cornerRadius = 15
        loadBtn.addTarget(self, action: #selector(SecondView.loadButton), for: .touchUpInside)
        self.addSubview(loadBtn)
    }
    
    //点击读取按钮时调用
    @objc func loadButton() {
        let coreDataView = CoreDataViewController()
        coreDataView.finding()
    }
    
    //点击保存按钮时调用
    @objc func saveButton() {
        let coreDataView = CoreDataViewController()
        if self.cityLabel.text != "City: N/A" {
            coreDataView.saving(self.cityLabel.text!, self.tempLabel.text!, self.weatherLabel.text!)
        }else {
            print("无数据可保存!")
        }
    }
    
    //点击add按钮时调用该方法
    @objc func addCityNameButton() {
        let alertControl = UIAlertController(title: "城市", message: nil, preferredStyle: .alert)
        alertControl.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alertControl.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            if let t = alertControl.textFields?.first {
                if let city = t.text {
                    self.jsonURL(city)
                }
            }
        }))
        alertControl.addTextField { (textField) in
            textField.placeholder = "请输入城市名"
        }
        UIApplication.shared.keyWindow?.rootViewController?.present(alertControl, animated: true, completion: nil)
    }
    
    //获取json数据
    fileprivate func jsonURL(_ name: String) {
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=d6127322479ba3819ef01fe42f26d526"
        let url = URL(string: path)
        let session = URLSession.shared
        let request = URLRequest(url: url!)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    //json中的城市
                    let cityName = jsonData["name"] as? String ?? "N/A"
                    //json中的温度
                    let main = jsonData["main"] as AnyObject
                    let temp = main["temp"] as? Double ?? 0.0
                    //json中的天气状况
                    let weather: String
                    if let w = jsonData["weather"] as? [AnyObject] {
                        weather = w[0]["description"] as! String 
                    }else {
                        weather = "N/A"
                    }
                    DispatchQueue.main.async {
                        self.theLabels(cityName, temp, weather)
                    }
                }catch {
                    print("出错了")
                }
            }else {
                print(error)
            }
        }
        dataTask.resume()
    }
    
    //更新标签
    fileprivate func theLabels(_ city: String, _ temp: Double, _ weather: String) {
        self.cityLabel.text = "City: \(city)"
        if city == "N/A" {
            self.tempLabel.text = "Temp: N/A ℃"
        }else {
            self.tempLabel.text = "Temp: \(Double(Int((temp - 273.15)*10)/10)) ℃"
        }
        self.weatherLabel.text = "Weather: \(weather)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
