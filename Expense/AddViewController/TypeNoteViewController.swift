//
//  TypeNoteViewController.swift
//  Expense
//
//  Created by Monica Ong on 1/19/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

class TypeNoteViewController: UIViewController {

    @IBOutlet weak var fullNoteView: UIView!
    var fullNoteViewColor: UIColor?
    
    @IBOutlet private weak var backgroundView: UIImageView!
    var backgroundImage: UIImage?

    @IBOutlet private weak var noteBoxView: UIView!
    @IBOutlet private weak var noteboxHeightFromTop: NSLayoutConstraint!
    @IBOutlet private weak var noteboxHeight: NSLayoutConstraint!
    var noteboxHeightFromTopConstant: CGFloat?
    
    @IBOutlet private weak var toolbar: UIToolbar!
    @IBOutlet private weak var toolbarHeight: NSLayoutConstraint!
    
    @IBOutlet weak private var noteTextField: UITextField!
    var note: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get rid of top border of toolbar
        toolbar.clipsToBounds = true
        
        //Set backgroudn image to Add VC's view
        backgroundView.hidden = true
        backgroundView.image = backgroundImage
        
        //Place notebox
        noteboxHeight.constant = view.bounds.height/3
        noteboxHeightFromTop.constant = noteboxHeightFromTopConstant ?? noteboxHeightFromTop.constant
        noteBoxView.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
        noteBoxView.layoutIfNeeded()
        
//        //Round notebox corners
//        let maskLayer = CAShapeLayer(layer: noteBoxView.layer)
//        let roundedPath = UIBezierPath(roundedRect: maskLayer.bounds, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSizeMake(16, 16))
//        maskLayer.fillColor = UIColor.whiteColor().CGColor
//        maskLayer.backgroundColor = UIColor.clearColor().CGColor
//        maskLayer.path = CGPath(roundedPath)
//        
//        //Don't add masks to layers already in the hierarchy!
//        UIView *superview = [self.view superview];
//        [self.view removeFromSuperview];
//        self.view.layer.mask = maskLayer;
//        [superview addSubview:self.view];
        
        //Place toolbar
        toolbarHeight.constant = noteboxHeight.constant/4
        toolbar.updateConstraintsIfNeeded()
        noteBoxView.layoutIfNeeded()
        toolbar.layoutIfNeeded()
        
        //Pull up keyboard
        noteTextField.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        //Show background image
        backgroundView.hidden = false
        
        //Dim background
        let transluescentColor = fullNoteViewColor?.colorWithAlphaComponent(0.8)
        fullNoteView.backgroundColor = transluescentColor
    }
    
    override func viewWillDisappear(animated: Bool) {
        backgroundView.hidden = true
        fullNoteView.backgroundColor = UIColor.clearColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func doneTexfieldPressed(sender: UITextField) {
        performSegueWithIdentifier("doneTypeNoteSegue", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //dismiss keyboard
        noteTextField.resignFirstResponder()
        
        if segue.identifier == "doneTypeNoteSegue"{
            note = noteTextField.text
        }
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
