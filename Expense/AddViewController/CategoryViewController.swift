//
//  CategoryViewController.swift
//  Expense
//
//  Created by Monica Ong on 1/21/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, AKPickerViewDelegate, AKPickerViewDataSource {
    
    @IBOutlet private weak var backgroundView: UIImageView!
    var backgroundImage: UIImage?
    
    @IBOutlet private weak var fullView: UIView!
    var fullViewColor: UIColor?

    @IBOutlet private weak var functionCategoryView: RoundCornersView!
    @IBOutlet private weak var functionCategoryHeightFromTop: NSLayoutConstraint!
    var functionCategoryHeightFromTopConstant: CGFloat?
    @IBOutlet private weak var functionCategoryHeightFromBottom: NSLayoutConstraint!
    var functionCategoryHeightFromBottomConstant: CGFloat?
    
    @IBOutlet private weak var toolbar: UIToolbar!
    
    @IBOutlet private weak var functionPicker: AKPickerView!
    var themeColor: UIColor?
    var functions: [String] = ["Personal", "Social", "Work", "Family"]
    @IBOutlet private weak var functionPickerHeight: NSLayoutConstraint!
    
    //Data
    var function: String?
    
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
        
        //Set up AKPickerView
        functionPicker.delegate = self
        functionPicker.dataSource = self
        
        functionPicker.font = UIFont(name: "Comfortaa", size: 20)!
        functionPicker.highlightedFont = UIFont(name: "Comfortaa", size: 20)!
        functionPicker.backgroundColor = themeColor
        functionPicker.interitemSpacing = CGFloat(10)
        functionPicker.pickerViewStyle = .Wheel
        functionPicker.maskDisabled = true
        functionPicker.reloadData()
        
        //Set function to auto-selected element
        function = functions[0]
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
    
    // MARK: - AKPickerViewDataSource
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return self.functions.count
    }
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        return self.functions[item]
    }
    
    // MARK: - AKPickerViewDelegate
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        function = self.functions[item]
    }
    
    //Label Customization
    func pickerView(pickerView: AKPickerView, configureLabel label: UILabel, forItem item: Int) {
        label.textColor = fullViewColor
        label.highlightedTextColor = UIColor.whiteColor()
        label.backgroundColor = themeColor
    }
    
    func pickerView(pickerView: AKPickerView, marginForItem item: Int) -> CGSize {
        return CGSizeMake(10, functionPickerHeight.constant)
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
