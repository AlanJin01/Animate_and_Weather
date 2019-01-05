//
//  ViewController.swift
//  AnimeAndCoreData1
//
//  Created by J K on 2019/1/4.
//  Copyright © 2019 Kims. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    private var scrollView: UIScrollView!
  
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var screen = UIScreen.main.bounds
        
        //设置滚动视图
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screen.width, height: screen.height))
        scrollView.contentSize = CGSize(width: screen.width, height: screen.height * 2)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        let firstView = FirstView(frame: screen)
        screen.origin.y = 0
        firstView.frame = screen
        
        let secondView = SecondView(frame: screen)
        screen.origin.y = screen.height
        secondView.frame = screen
        
        scrollView.addSubview(firstView)
        scrollView.addSubview(secondView)
        self.view.addSubview(scrollView)
    }
}

