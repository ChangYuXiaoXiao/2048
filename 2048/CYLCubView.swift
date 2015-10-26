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
            switch self.number
            {
            case 2: label.textColor = UIColor.init(red: 102/255.0, green: 93/255.0, blue: 83/255.0, alpha: 1); label.backgroundColor = UIColor.init(red: 233/255.0, green: 221/255.0, blue: 209/255.0, alpha: 1)
            case 4: label.textColor = UIColor.init(red: 102/255.0, green: 93/255.0, blue: 83/255.0, alpha: 1); label.backgroundColor = UIColor.init(red: 231/255.0, green: 217/255.0, blue: 189/255.0, alpha: 1)
            case 8: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 237/255.0, green: 161/255.0, blue: 98/255.0, alpha: 1)
            case 16: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 240/255.0, green: 129/255.0, blue: 79/255.0, alpha: 1)
            case 32: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 240/255.0, green: 102/255.0, blue: 75/255.0, alpha: 1)
            case 64: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 245/255.0, green: 71/255.0, blue: 37/255.0, alpha: 1)
            case 128: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 233/255.0, green: 196/255.0, blue: 81/255.0, alpha: 1)
            case 256: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 233/255.0, green: 194/255.0, blue: 60/255.0, alpha: 1)
            case 512: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 232/255.0, green: 189/255.0, blue: 37/255.0, alpha: 1)
            case 1024: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 234/255.0, green: 186/255.0, blue: 19/255.0, alpha: 1)
            default: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 234/255.0, green: 186/255.0, blue: 19/255.0, alpha: 1)
            }
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
        self.label.textColor = UIColor.init(red: 102/255.0, green: 93/255.0, blue: 83/255.0, alpha: 1)
        self.label.backgroundColor = UIColor.init(red: 233/255.0, green: 221/255.0, blue: 209/255.0, alpha: 1)
        self.addSubview(self.label)
    }
    convenience init(number:Int)
    {
        self.init()
        self.number = number
        switch self.number
        {
        case 2: label.textColor = UIColor.init(red: 102/255.0, green: 93/255.0, blue: 83/255.0, alpha: 1); label.backgroundColor = UIColor.init(red: 233/255.0, green: 221/255.0, blue: 209/255.0, alpha: 1)
        case 4: label.textColor = UIColor.init(red: 102/255.0, green: 93/255.0, blue: 83/255.0, alpha: 1); label.backgroundColor = UIColor.init(red: 231/255.0, green: 217/255.0, blue: 189/255.0, alpha: 1)
        case 8: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 237/255.0, green: 161/255.0, blue: 98/255.0, alpha: 1)
        case 16: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 240/255.0, green: 129/255.0, blue: 79/255.0, alpha: 1)
        case 32: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 240/255.0, green: 102/255.0, blue: 75/255.0, alpha: 1)
        case 64: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 245/255.0, green: 71/255.0, blue: 37/255.0, alpha: 1)
        case 128: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 233/255.0, green: 196/255.0, blue: 81/255.0, alpha: 1)
        case 256: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 233/255.0, green: 194/255.0, blue: 60/255.0, alpha: 1)
        case 512: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 232/255.0, green: 189/255.0, blue: 37/255.0, alpha: 1)
        case 1024: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 234/255.0, green: 186/255.0, blue: 19/255.0, alpha: 1)
        default: label.textColor = UIColor.whiteColor(); label.backgroundColor = UIColor.init(red: 234/255.0, green: 186/255.0, blue: 19/255.0, alpha: 1)
        }
        self.label.text = "\(number)"
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
//    override func drawRect(rect: CGRect)
//    {
//        super.drawRect(rect)
//        self.layer.masksToBounds = true
//        self.layer.cornerRadius = 20
//        self.layer.borderWidth = 3
//    }
}
