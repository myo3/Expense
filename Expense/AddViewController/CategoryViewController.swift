//
//  CategoryViewController.swift
//  Expense
//
//  Created by Monica Ong on 1/21/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var backgroundView: UIImageView!
    var backgroundImage: UIImage?
    
    @IBOutlet weak var fullView: UIView!
    var fullViewColor: UIColor?
    
    
    @IBOutlet weak var functionCategoryView: RoundCornersView!
    @IBOutlet weak var functionCategoryHeightFromTop: NSLayoutConstraint!
    var functionCategoryHeightFromTopConstant: CGFloat?
    @IBOutlet weak var functionCategoryHeightFromBottom: NSLayoutConstraint!
    var functionCategoryHeightFromBottomConstant: CGFloat?
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var functionPicker: UIPickerView!
    var function: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get rid of top border of toolbar
        toolbar.clipsToBounds = true
        
        //Set backgroudn image to Add VC's view
        backgroundView.hidden = true
        backgroundView.image = backgroundImage
        
        //Place notebox
        functionCategoryHeightFromTop.constant = functionCategoryHeightFromTopConstant ?? functionCategoryHeightFromTop.constant
        functionCategoryHeightFromBottom.constant = functionCategoryHeightFromBottomConstant ?? functionCategoryHeightFromBottom.constant
        functionCategoryView.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
        functionCategoryView.layoutIfNeeded()
        
        //Connect data
        self.functionPicker.delegate = self
        self.functionPicker.dataSource = self
        
        //Input data into array
        function = ["Personal", "Social", "Work", "Family"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return function.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return function[row]
    }
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
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
