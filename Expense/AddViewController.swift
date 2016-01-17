//
//  AddViewController.swift
//  Expense
//
//  Created by Monica Ong on 1/16/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    //Colors
    var themeColor: UIColor = UIColor(netHex: 0x1CCCAC)
    var backgroundColor: UIColor = UIColor(netHex: 0xE7DDD4)
    var fontColor: UIColor = UIColor(netHex: 0x6F6559)
    var fontHightlightColor: UIColor = UIColor(netHex: 0xAB9D89)
    var offWhite: UIColor = UIColor(netHex: 0xFBF9F7)
    
    //Views & Constraints
    @IBOutlet weak var statusBarHeight: NSLayoutConstraint!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var costView: UIView!
    @IBOutlet weak var costViewHeight: NSLayoutConstraint!
    @IBOutlet weak var dollarSign: UILabel!
    @IBOutlet weak var cost: UILabel!
    
    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var keyboardHeight: NSLayoutConstraint!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set size of cost view & numbers keyboard
        let halfViewHeight = 5*(view.bounds.height - statusBarHeight.constant - navigationBar.bounds.height)/9
        costViewHeight.constant = halfViewHeight/CGFloat(4)
        keyboardHeight.constant = halfViewHeight - costViewHeight.constant
        costView.updateConstraintsIfNeeded()
        keyboardView.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
        costView.layoutIfNeeded()
        keyboardView.layoutIfNeeded()
        
        //Adjust font size of dollar sign & cost to fit iPhone 6S
        cost.font = UIFont(name: "Comfortaa", size: 50)
        dollarSign.font = UIFont(name: "Comfortaa", size: 50)
        
        //Set navigation bar tite font, size, & color
        let attributes = [NSFontAttributeName : UIFont(name: "Comfortaa", size: 28)!]
        self.navigationBar.titleTextAttributes = attributes
        
        //set up keyboard
        let columnSpace = CGFloat(1)
        let buttonHeight = (keyboardView.bounds.height-(4*columnSpace))/4
        let rowSpace = CGFloat(1)
        let buttonWidth = (keyboardView.bounds.width-(2*rowSpace))/3
        var keyboardButtons = [UIButton]()
        for i in 0...11{
            let button = UIButton(frame: CGRectMake(0, 0, buttonWidth, buttonHeight))
            switch i{
            case 10:
                button.setTitle(".", forState: .Normal)
            case 11:
                button.setImage(UIImage(named: "Delete"), forState: .Normal)
                button.tintColor = fontHightlightColor
            default:
                button.setTitle("\(i)", forState: .Normal)
            }
            button.titleLabel?.font = UIFont(name: "Comfortaa", size: 40)
            button.titleLabel?.textAlignment = .Center
            button.setTitleColor(fontHightlightColor, forState: .Normal)
            button.backgroundColor = offWhite
            button.setTitleColor(offWhite, forState: .Highlighted)
            button.setBackgroundImage(imageWithColor(fontHightlightColor), forState: .Highlighted)
            button.addTarget(self, action: "typeCost:", forControlEvents: .TouchUpInside)
            button.tag = i
            keyboardButtons.append(button)
        }
            //place buttons
        for i in 0...keyboardButtons.count-1{
            switch i{ //place buttons in rows
            case 1...3: //top row
                keyboardButtons[i].center.y = columnSpace + 0.5*buttonHeight
            case 4...6: //top middle row
                keyboardButtons[i].center.y = 2*columnSpace + 1.5*buttonHeight
            case 7...9: //bottom middle row
                keyboardButtons[i].center.y = 3*columnSpace + 2.5*buttonHeight
            case 0, 10...11: //bottom row
                keyboardButtons[i].center.y = 4*columnSpace + 3.5*buttonHeight
            default:
                print("Placing buttons in rows not working")
            }
            switch i{ //place buttons in columns
            case 1, 4, 7, 10: //first column
                keyboardButtons[i].center.x = buttonWidth/2
            case 2, 5, 8, 0: //middle column
                keyboardButtons[i].center.x = 1.5*buttonWidth + rowSpace
            case 3, 6, 9, 11: //last column
                keyboardButtons[i].center.x = 2.5*buttonWidth + 2*rowSpace
            default:
                print("Placing buttons in columns not working")
            }
        }
            //add buttons to keyboardView
        for button in keyboardButtons{
            keyboardView.addSubview(button)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageWithColor(color: UIColor) -> UIImage{
        let rect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func typeCost(sender: UIButton){
        if sender.tag == 11 { //delete last character
            if cost.text?.characters.count > 1{
                cost.text = String(cost.text!.characters.dropLast())
            } else if cost.text != "0"{
                cost.text = "0"
            }
        } else{
            if cost.text == "0"{
                cost.text = ""
            }
            var charToAdd = ""
            switch sender.tag{
            case 10: //.
                charToAdd = "."
            default:
                charToAdd = "\(sender.tag)"
            }
            let prev = cost.text ?? ""
            cost.text = prev + charToAdd
        }
    }
    
    private func fontToFitHeight(label: UILabel) -> UIFont {
        
        var minFontSize: CGFloat = 30 //DISPLAY_FONT_MINIMUM // CGFloat 18
        var maxFontSize: CGFloat = 100 //DISPLAY_FONT_BIG     // CGFloat 67
        var fontSizeAverage: CGFloat = 0
        var textAndLabelHeightDiff: CGFloat = 0
        
        while (minFontSize <= maxFontSize) {
            fontSizeAverage = minFontSize + (maxFontSize - minFontSize) / 2
            
            if let labelText: NSString = label.text {
                let labelHeight = label.frame.size.height
                
                let testStringHeight = labelText.sizeWithAttributes(
                    [NSFontAttributeName: label.font.fontWithSize(fontSizeAverage)]
                    ).height
                
                textAndLabelHeightDiff = labelHeight - testStringHeight
                
                if (fontSizeAverage == minFontSize || fontSizeAverage == maxFontSize) {
                    if (textAndLabelHeightDiff < 0) {
                        return label.font.fontWithSize(fontSizeAverage - 1)
                    }
                    return label.font.fontWithSize(fontSizeAverage)
                }
                
                if (textAndLabelHeightDiff < 0) {
                    maxFontSize = fontSizeAverage - 1
                    
                } else if (textAndLabelHeightDiff > 0) {
                    minFontSize = fontSizeAverage + 1
                    
                } else {
                    return label.font.fontWithSize(fontSizeAverage)
                }
            }
        }
        return label.font.fontWithSize(fontSizeAverage)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
