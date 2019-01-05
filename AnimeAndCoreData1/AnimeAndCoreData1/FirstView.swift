//
//  FirstView.swift
//  AnimeAndCoreData1
//
//  Created by J K on 2019/1/4.
//  Copyright © 2019 Kims. All rights reserved.
//

import UIKit

class FirstView: UIView {
    
    private var imgView1: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.8382487563, green: 0.5961163729, blue: 1, alpha: 1)
        
        let img1 = UIImage(named: "as2")
        imgView1 = UIImageView(image: img1!)
        let rect = CGRect(x: 30, y: 100, width: 100, height: 100)
        imgView1.frame = rect
        imgView1.center = CGPoint(x: self.center.x, y: self.center.y + 100)
        
        imgView1.contentMode = UIView.ContentMode.scaleAspectFill //填充模式
        
        imgView1.layer.cornerRadius = 50
        imgView1.layer.masksToBounds = true
        imgView1.layer.borderWidth = 5
        imgView1.layer.borderColor = UIColor.white.cgColor
        imgView1.isUserInteractionEnabled = true
        self.addSubview(imgView1)
        
        //设置点击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FirstView.tapGestureFunction(_:)))
        tapGesture.numberOfTapsRequired = 2
        tapGesture.numberOfTouchesRequired = 1
        imgView1.addGestureRecognizer(tapGesture)
    }
    
    //点击2下即可出发动画, 动画效果是由变大到回复圆形
    @objc func tapGestureFunction(_ tap: UITapGestureRecognizer) {
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {
            self.imgView1.frame.size = CGSize(width: 150, height: 150)
            self.imgView1.layer.cornerRadius = 75
        }) { (complite) in
            UIView.animate(withDuration: 2, delay: 0, options: .curveEaseIn, animations: {
                self.imgView1.frame.size = CGSize(width: 100, height: 100)
                self.imgView1.layer.cornerRadius = 50
            }, completion: { (complite) in
                print("size变换动画停止")
            })
        }
    }
    
    //图根据鼠标点击的位置进行移动
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch!.location(in: self)
        
        if touch?.tapCount == 1 && touch?.view != self.imgView1 {        //只识别一次点击事件，并只有在图像意外的视图点击时出发位移动画
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                self.imgView1.center = CGPoint(x: location.x, y: location.y)
            }, completion: { (complite) in
                print("移动完成")
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
