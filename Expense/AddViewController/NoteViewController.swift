//
//  TypeNoteViewController.swift
//  Expense
//
//  Created by Monica Ong on 1/19/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var fullView: UIView!
    var fullViewColor: UIColor?
    
    @IBOutlet private weak var backgroundView: UIImageView!
    var backgroundImage: UIImage?

    @IBOutlet private weak var noteBoxView: RoundCornersView!
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
        
        //Pull up keyboard
        noteTextField.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        //Show background image
        backgroundView.hidden = false
        
        //Dim background (to match animation)
        let transluescentColor = fullViewColor?.colorWithAlphaComponent(0.8)
        fullView.backgroundColor = transluescentColor
    }
    
    override func viewWillDisappear(animated: Bool) {
        backgroundView.hidden = true
        fullView.backgroundColor = UIColor.clearColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func doneTexfieldPressed(sender: UITextField) {
        performSegueWithIdentifier("addNoteSegue", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //dismiss keyboard
        noteTextField.resignFirstResponder()
        
        if segue.identifier == "addNoteSegue"{
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
