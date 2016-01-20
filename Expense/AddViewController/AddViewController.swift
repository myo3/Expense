//
//  AddViewController.swift
//  Expense
//
//  Created by Monica Ong on 1/16/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

extension AddViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(
        presented: UIViewController,
        presentingController presenting: UIViewController,
        sourceController source: UIViewController) ->
        UIViewControllerAnimatedTransitioning? {
            
            transition.originFrame = noteView.superview!.convertRect(noteView.frame, toView: nil)
            //selectedImage!.superview!.convertRect(selectedImage!.frame, toView: nil)
            
            transition.presenting = true
            
            return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
    
}
class AddViewController: UIViewController {

    //Colors
    var themeColor: UIColor = UIColor(netHex: 0x1CCCAC)
    var backgroundColor: UIColor = UIColor(netHex: 0xE7DDD4)
    var fontColor: UIColor = UIColor(netHex: 0x6F6559)
    var fontHightlightColor: UIColor = UIColor(netHex: 0xAB9D89)
    var offWhite: UIColor = UIColor(netHex: 0xFBF9F7)
    
    //Views & Constraints
    @IBOutlet weak var statusBarBackgroundView: UIView!
    @IBOutlet private weak var statusBarHeight: NSLayoutConstraint!
    @IBOutlet private weak var navigationBar: UINavigationBar!
    
    @IBOutlet private weak var cellHighlight: UIView!
    
    @IBOutlet private weak var costView: UIView!
    @IBOutlet private weak var costViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var dollarSign: UILabel!
    @IBOutlet private weak var costLabel: UILabel!
    var cost: Double = 0
    
    @IBOutlet private weak var keyboardView: UIView!
    @IBOutlet private weak var keyboardHeight: NSLayoutConstraint!

    @IBOutlet private weak var noteView: UIView!
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet private weak var dateView: UIView!
    @IBOutlet private weak var dateViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var dateViewWidth: NSLayoutConstraint!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var dayLabel: UILabel!
    
    //Animatoin
    let transition = PopAnimator()
    
    //Expense components
    var note: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set navigation bar tite font
        let attributes = [NSFontAttributeName : UIFont(name: "Comfortaa", size: 28)!]
        self.navigationBar.titleTextAttributes = attributes
        
        //Set size of cost view & numbers keyboard
        let totalHeight = view.bounds.height - statusBarHeight.constant - navigationBar.bounds.height
        let bottomViewHeight = 5*(totalHeight)/9
        costViewHeight.constant = bottomViewHeight/CGFloat(4)
        keyboardHeight.constant = bottomViewHeight - costViewHeight.constant
        costView.updateConstraintsIfNeeded()
        keyboardView.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
        costView.layoutIfNeeded()
        keyboardView.layoutIfNeeded()
            //Adjust font size of dollar sign & cost to fit iPhone 6S
        costLabel.font = UIFont(name: "Comfortaa", size: 50)
        dollarSign.font = UIFont(name: "Comfortaa", size: 50)
        
        //Arrange note view & date view
        let topViewHeight = totalHeight - bottomViewHeight
//        let totalWidth = view.bounds.width - cellHighlight.bounds.width
        dateViewHeight.constant = topViewHeight*0.19
        dateView.updateConstraintsIfNeeded()
        noteView.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
        dateView.layoutIfNeeded()
        costView.layoutIfNeeded()
            //set up date view
        let todaysDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: todaysDate)
        dayLabel.text = "\(dateComponents.day)"
        calendar.dateFromComponents(dateComponents)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm aa"
        timeLabel.text = dateFormatter.stringFromDate(todaysDate)
        
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
                button.setImage(UIImage(named: "delete-Normal"), forState: .Normal)
                button.setImage(UIImage(named: "delete-Highlighted"), forState: .Highlighted)
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
    
    
    @IBAction func typedNote(unwindSegue: UIStoryboardSegue){
        let typeNoteVC = unwindSegue.sourceViewController as! TypeNoteViewController
        //Update expense component
        if typeNoteVC.note == ""{
            self.note = "Add a note..."
        }else{
            self.note = typeNoteVC.note
        }
        //Update AddVC's view
        noteLabel.text = self.note
    }
    
    @IBAction func cancelTypeNote(unwindSegue: UIStoryboardSegue){
    }
    
    @IBAction func selectDate(sender: UITapGestureRecognizer) {
        print("Date view tapped")
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
    
//    var decimalMode: Bool = false
//    var numOfDecTyped: Int = 0
    
    func typeCost(sender: UIButton){
        //works but is not pretty
        if sender.tag == 11 { //delete last character
            if costLabel.text?.characters.count > 1{ //delete one character
                costLabel.text = String(costLabel.text!.characters.dropLast())
            } else if costLabel.text != "0"{ //delete last digit
                costLabel.text = "0"
            }
        } else{
            var charTyped = ""
            if sender.tag == 10{ //type decimal point
                charTyped = "."
                if let costTyped = costLabel.text{
                    if !costTyped.containsString("."){
                        //no more than 1 decimal point
                        let prev = costLabel.text ?? ""
                        costLabel.text = prev + charTyped
                    }
                }
            }else{ //type number
                if costLabel.text == "0"{ //no 0 in front of cost
                    costLabel.text = ""
                }
                if let costTyped = costLabel.text{
                    if costTyped.characters.count < 14{ //no longer than 14 digits
                        var charTyped = "\(sender.tag)"
                        if costTyped.containsString("."){
                            let arr = costTyped.characters.split{$0 == "."}.map(String.init)
                            if arr.count > 1{
                                if arr[1].characters.count >= 2{ //no more than 2 decimal places
                                    charTyped = ""
                                }
                            }
                        }
                        costLabel.text = costTyped + charTyped
                    }
                }
            }
        }
        
        //        //simplfying attempt...seeming like a fail
        //        switch sender.tag{
        //        case 10: //decimal point
        //            if let costTyped = costLabel.text{
        //                if !costTyped.containsString("."){ //cannot type no more than one "."
        //                    decimalMode = true
        //                    costLabel.text = costLabel.text! + "."
        //                }
        //            }
        //        case 11: //backspace
        //            if decimalMode{
        //                if costLabel.text!.characters.last == "."{ //delete "."
        //                    costLabel.text = String(costLabel.text!.characters.dropLast())
        //                    decimalMode = false
        //                    numOfDecTyped = 0
        //                } else if numOfDecTyped > 0{
        //                    switch numOfDecTyped{
        //                    case 0:
        //                    case 1:
        //                    case 2:
        //                    default:
        //                    }
        //                }
        //            }else{
        //                cost = cost%10
        //            }
        //            costLabel.text = "\(cost)"
        //        default: //number
        //            let num = Double(sender.tag)
        //            if decimalMode{
        //                switch numOfDecTyped {
        //                case 0:
        //                    cost = cost + num/10
        //                    numOfDecTyped++
        //                case 1:
        //                    cost = cost + num/100
        //                    numOfDecTyped++
        //                default:
        //                    print("numOfDecTyped is >=2")
        //                }
        //            }else{
        //                cost = cost*10 + num
        //            }
        //            costLabel.text = "\(cost)"
        //        }
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "typeNoteSegue"{
            let typeNoteVC = segue.destinationViewController as! TypeNoteViewController
            
            //animation
            typeNoteVC.transitioningDelegate = self
            
            //generate snapshot of window
            let window: UIWindow! = UIApplication.sharedApplication().keyWindow
            let windowImage = capture(window)
            typeNoteVC.backgroundImage = windowImage
            typeNoteVC.noteboxHeightFromTopConstant = statusBarHeight.constant + navigationBar.bounds.height + 20
            
            //pass on color
            typeNoteVC.fullNoteViewColor = fontColor
        }
    }
    
    func capture(window: UIWindow) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(window.frame.width, window.frame.height), window.opaque, UIScreen.mainScreen().scale)
        window.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }

}
