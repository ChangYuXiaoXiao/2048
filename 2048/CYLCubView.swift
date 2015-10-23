//
//  CYLcubView.swift
//  2048
//
//  Created by 畅雨潇潇 on 15/10/21.
//  Copyright © 2015年 arcsoft. All rights reserved.
//

import UIKit
let screenWidth = UIScreen.mainScreen().bounds.width
let screenHeight = UIScreen.mainScreen().bounds.height
let space:CGFloat = 20
let cubWidth = ((screenWidth - 5*space)/4)

class CYLCubView: UIView
{
    var number:Int
    {
        didSet
        {
            label.text = "\(self.number)"
        }
    }
    var frameArray = [CGRect]()
    var frameNumber:Int
    {
        didSet
        {
            self.frame = frameArray[self.frameNumber]
        }
    }
    private var label:UILabel = UILabel(frame: CGRectMake(0, 0, cubWidth, cubWidth))
    
    init()
    {
        self.number = 2
        self.frameNumber = 16
        for lineNumber in 0...3
        {
            for columnNumber in 0...3
            {
                let cubX = CGFloat(columnNumber)*(cubWidth+space)+space
                let cubY = CGFloat(lineNumber)*(cubWidth+space)+space
                let cubFrame:CGRect = CGRectMake(cubX, cubY, cubWidth, cubWidth)
                self.frameArray.append(cubFrame)
            }
        }
        super.init(frame:CGRectMake(0, 0, cubWidth, cubWidth))
        self.label.text = "2"
        self.label.font = UIFont.init(name:label.font.fontName, size: 70)
        self.label.textAlignment = NSTextAlignment.Center
        self.label.backgroundColor = UIColor.whiteColor()
        self.addSubview(self.label)
    }
    convenience init(number:Int)
    {
        self.init()
        self.number = number
        self.label.text = "\(number)"
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    override func drawRect(rect: CGRect)
    {
        super.drawRect(rect)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 3
    }
}
