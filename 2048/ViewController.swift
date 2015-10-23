//
//  ViewController.swift
//  2048
//
//  Created by 畅雨潇潇 on 15/10/21.
//  Copyright © 2015年 arcsoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var gameBackGround: UIView!
    var cubFrameArray:Array = [CGRect]()
    var needRemoveCubArray = [CYLCubView]()
    var needChangeNumberArray = [CYLCubView]()
    lazy var maskView:UIView? =
    {
        let maskView = UIView.init(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        maskView.backgroundColor = UIColor.blackColor()
        maskView.alpha = 0.9
        return maskView
    }()
    
    lazy var gamgeOverBtn:UIButton? =
    {
        let btn = UIButton.init(frame: CGRectMake(screenWidth*0.5-100, screenHeight*0.5-50, 200, 100))
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 3
        btn.setTitle("Game Over, Retry!", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.whiteColor()
        btn.addTarget(self, action: "gameViewDisplay", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        for lineNumber in 0...3
        {
            for columnNumber in 0...3
            {
                let cubX = CGFloat(columnNumber)*(cubWidth+space)+space
                let cubY = CGFloat(lineNumber)*(cubWidth+space)+space
                let cubFrame:CGRect = CGRectMake(cubX, cubY, cubWidth, cubWidth)
                cubFrameArray.append(cubFrame)
            }
        }
        self.gameViewDisplay()
    }

    
    func gameViewDisplay()->Void
    {
        for cubView in self.gameBackGround.subviews
        {
            if (cubView is CYLCubView)
            {
                cubView.removeFromSuperview()
            }
        }
        self.maskView?.removeFromSuperview()
        self.gamgeOverBtn?.removeFromSuperview()
        let random1 = Int(arc4random()%16)
        var random2:Int
        repeat{random2 = Int(arc4random()%16)}
        while random1 == random2
        let cub1 = CYLCubView.init()
        let cub2 = CYLCubView.init()
        cub1.frameNumber = random1
        cub2.frameNumber = random2
        self.gameBackGround.addSubview(cub1)
        self.gameBackGround.addSubview(cub2)
    }

    @IBAction func panGesture(sender: UIPanGestureRecognizer)
    {
        if(sender.state == UIGestureRecognizerState.Began)
        {
            let point = sender.velocityInView(sender.view)
            let array1 = [CYLCubView](),array2 = [CYLCubView](),array3 = [CYLCubView](),array4 = [CYLCubView]()
            let array = [array1,array2,array3,array4]
            if (abs(point.y)>=abs(point.x))
            {
                if (point.y>0)
                {    //出现下划手势时
                    self.gameStart(0, num2: 1, num3: 2, num4: 3, change: 4, array: array)

                }else
                {    //出现上划手势时
                    self.gameStart(12, num2: 13, num3: 14, num4: 15, change: -4, array: array)
                }
                
            }else
            {
                if (point.x>0)
                {    //出现右划手势时
                    self.gameStart(0, num2: 4, num3: 8, num4: 12, change: 1, array: array)
                }else
                {    //出现左划手势时
                    self.gameStart(3, num2: 7, num3: 11, num4: 15, change: -1, array: array)
                }
            }
        }
    }
    
    func gameStart(num1:Int,num2:Int,num3:Int,num4:Int,change:Int,array:[[CYLCubView]])
    {
        var array1 = array[0]
        var array2 = array[1]
        var array3 = array[2]
        var array4 = array[3]
        //将各个列中有数字的方块分别放入对应数组
        for cubView in self.gameBackGround.subviews
        {
            if(cubView is CYLCubView)
            {
                let cub = cubView as! CYLCubView
                switch cub.frameNumber
                {
                case num1,(num1+change),(num1+change*2),(num1+change*3): array1.append(cub)
                case num2,(num2+change),(num2+change*2),(num2+change*3): array2.append(cub)
                case num3,(num3+change),(num3+change*2),(num3+change*3): array3.append(cub)
                case num4,(num4+change),(num4+change*2),(num4+change*3): array4.append(cub)
                default: break
                }
            }
        }
        //按照滑动方式排序
        if (change>0)
        {
            array1.sortInPlace({$0.frameNumber < $1.frameNumber})
            array2.sortInPlace({$0.frameNumber < $1.frameNumber})
            array3.sortInPlace({$0.frameNumber < $1.frameNumber})
            array4.sortInPlace({$0.frameNumber < $1.frameNumber})
        }else
        {
            array1.sortInPlace({$0.frameNumber > $1.frameNumber})
            array2.sortInPlace({$0.frameNumber > $1.frameNumber})
            array3.sortInPlace({$0.frameNumber > $1.frameNumber})
            array4.sortInPlace({$0.frameNumber > $1.frameNumber})
        }
        //进行移动
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.moveCub(array1, num: num1, change: change)
            self.moveCub(array2, num: num2, change: change)
            self.moveCub(array3, num: num3, change: change)
            self.moveCub(array4, num: num4, change: change)
            }) { (True) -> Void in
                //合并方块
                if(self.needRemoveCubArray.count > 0)
                {
                    for cub in self.needRemoveCubArray
                    {
                        cub.removeFromSuperview()
                    }
                    self.needRemoveCubArray.removeAll()
                }
                if (self.needChangeNumberArray.count > 0)
                {
                    for cub in self.needChangeNumberArray
                    {
                        cub.number *= 2
                    }
                    self.needChangeNumberArray.removeAll()
                }
                //遍历所有方块，去除到当前已经存在方块的位置，在未存在方块的位置上添加新的方块
                var sparePositionArray = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
                for cubView in self.gameBackGround.subviews
                {
                    if(cubView is CYLCubView)
                    {
                        let cub = cubView as! CYLCubView
                        for var num = 0; num < sparePositionArray.count; num++
                        {
                            if (sparePositionArray[num] == cub.frameNumber)
                            {
                                sparePositionArray.removeAtIndex(num);
                            }
                        }
                    }
                }
                if (sparePositionArray.count > 0)
                {
                    let cubView = CYLCubView.init()
                    cubView.frameNumber = sparePositionArray[Int(arc4random())%sparePositionArray.count]
                    self.gameBackGround.addSubview(cubView)
                    //Game Over条件
                    if (sparePositionArray.count == 1)
                    {
                        var subViewArray = [CYLCubView]()
                        for cub in self.gameBackGround.subviews
                        {
                            if (cub is CYLCubView)
                            {
                                subViewArray.append(cub as! CYLCubView)
                            }
                        }
                        subViewArray.sortInPlace({$0.frameNumber < $1.frameNumber})
                        if((!self.isContinue(subViewArray, num1: 0, num2: 1, num3: 2, num4: 3, change: 4))&&(!self.isContinue(subViewArray, num1: 0, num2: 4, num3: 8, num4: 12, change: 1)))
                        {
                            self.view.addSubview(self.maskView!)
                            self.view.addSubview(self.gamgeOverBtn!)
                        }
                        
                    }
                }
        }
    }
    
    func moveCub(array:[CYLCubView], num:Int, change:Int) -> Void
    {
        switch array.count
        {
        case 0: break
        case 1: array[0].frameNumber = num+change*3;
        case 2: array[1].frameNumber = num+change*3; array[0].frameNumber = num+change*2;
                if(array[0].number == array[1].number)
                {array[0].frameNumber = array[1].frameNumber; needRemoveCubArray.append(array[0]); needChangeNumberArray.append(array[1])}
        case 3: array[2].frameNumber = num+change*3; array[1].frameNumber = num+change*2; array[0].frameNumber = num+change;
                if(array[0].number == array[1].number)
                {array[0].frameNumber = array[1].frameNumber; needRemoveCubArray.append(array[0]); needChangeNumberArray.append(array[1])}
                else if(array[1].number == array[2].number)
                {array[0].frameNumber = array[1].frameNumber; array[1].frameNumber = array[2].frameNumber; needRemoveCubArray.append(array[1]); needChangeNumberArray.append(array[2])}
        case 4: if(array[0].number == array[1].number)
                {array[0].frameNumber = array[1].frameNumber; needRemoveCubArray.append(array[0]); needChangeNumberArray.append(array[1])
                    if(array[2].number == array[3].number){array[1].frameNumber = array[2].frameNumber; array[0].frameNumber = array[2].frameNumber; array[2].frameNumber = array[3].frameNumber; needRemoveCubArray.append(array[2]); needChangeNumberArray.append(array[3])}}
                else if(array[1].number == array[2].number)
                {array[0].frameNumber = array[1].frameNumber; array[1].frameNumber = array[2].frameNumber; needRemoveCubArray.append(array[1]); needChangeNumberArray.append(array[2])}
                else if(array[2].number == array[3].number)
                {array[0].frameNumber = array[1].frameNumber; array[1].frameNumber = array[2].frameNumber; array[2].frameNumber = array[3].frameNumber; needRemoveCubArray.append(array[2]); needChangeNumberArray.append(array[3])}
        default:break
        }
    }
    func isContinue(array:[CYLCubView], num1:Int, num2:Int, num3:Int, num4:Int, change:Int) ->Bool
    {
        for var num = num1; num<num1+3*change; num+=change
        {
            if (array[num].number == array[num+change].number){return true}
        }
        for var num = num2; num<num2+3*change; num+=change
        {
            if (array[num].number == array[num+change].number){return true}
        }
        for var num = num3; num<num3+3*change; num+=change
        {
            if (array[num].number == array[num+change].number){return true}
        }
        for var num = num4; num<num4+3*change; num+=change
        {
            if (array[num].number == array[num+change].number){return true}
        }
        return false
    }

}

