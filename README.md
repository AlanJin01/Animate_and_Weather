# Animate_And_ Weather

![image](https://github.com/Kimsswift/-/blob/master/AnimeAndCoreData1/a1.gif)
![image](https://github.com/Kimsswift/-/blob/master/AnimeAndCoreData1/a2.gif)

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

小圆图可根据鼠标点击的位置进行移动，双击该图可由变大到恢复原型。另外在另一个页面可通过输入的城市名查询天气，还可以保存天气信息到CoreData里。
