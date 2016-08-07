//
//  DateViewController.swift
//  Expense
//
//  Created by Monica Ong on 1/20/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {


    @IBOutlet private weak var fullView: UIView!
    var fullViewColor: UIColor?
    
    @IBOutlet private weak var backgroundView: UIImageView!
    var backgroundImage: UIImage?
    
    @IBOutlet private weak var dateBoxView: UIView!
    @IBOutlet private weak var dateBoxHeight: NSLayoutConstraint!
    var dateBoxHeightFromTopConstant: CGFloat?
    
    @IBOutlet private weak var toolbar: UIToolbar!
    @IBOutlet private weak var toolbarHeight: NSLayoutConstraint!
    
    
    @IBOutlet private weak var datePicker: UIDatePicker!
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addDateSegue"{
            date = datePicker.date
        }
    }

}
