//
//  DateViewController.swift
//  Expense
//
//  Created by Monica Ong on 1/20/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet weak var fullNoteView: UIView!
    var fullNoteViewColor: UIColor?
    
    @IBOutlet private weak var backgroundView: UIImageView!
    var backgroundImage: UIImage?
    
    @IBOutlet weak var dateBoxView: UIView!
    @IBOutlet weak var dateBoxHeight: NSLayoutConstraint!
    var dateBoxHeightFromTopConstant: CGFloat?
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var toolbarHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var date: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get rid of top border of toolbar
        toolbar.clipsToBounds = true
        
        //Set backgroudn image to Add VC's view
        backgroundView.hidden = true
        backgroundView.image = backgroundImage
        
        //Place notebox
        dateBoxHeight.constant = view.bounds.height/2
        dateBoxView.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
        dateBoxView.layoutIfNeeded()
        
        //Place toolbar
        toolbarHeight.constant = view.bounds.height/12
        toolbar.updateConstraintsIfNeeded()
        dateBoxView.layoutIfNeeded()
        toolbar.layoutIfNeeded()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //Show background image
        backgroundView.hidden = false
        
        //Dim background (to match animation)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addDateSegue"{
            date = datePicker.date
        }
    }

}
