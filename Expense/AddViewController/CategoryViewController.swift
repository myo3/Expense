//
//  CategoryViewController.swift
//  Expense
//
//  Created by Monica Ong on 1/21/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, AKPickerViewDelegate, AKPickerViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet private weak var backgroundView: UIImageView!
    var backgroundImage: UIImage?
    
    @IBOutlet private weak var fullView: UIView!
    var fullViewColor: UIColor?

    @IBOutlet private weak var toolbar: UIToolbar!

    @IBOutlet private weak var functionCategoryView: RoundCornersView!
    @IBOutlet private weak var functionCategoryHeightFromTop: NSLayoutConstraint!
    var functionCategoryHeightFromTopConstant: CGFloat?
    @IBOutlet private weak var functionCategoryHeightFromBottom: NSLayoutConstraint!
    var functionCategoryHeightFromBottomConstant: CGFloat?
    
    @IBOutlet private weak var functionPicker: AKPickerView!
    var themeColor: UIColor?
    var functions: [String] = ["Personal", "Social", "Work", "Family"]
    @IBOutlet private weak var functionPickerHeight: NSLayoutConstraint!
    var function: String? //Data
    
    
    var categories: [String] = ["General", "Personal", "House", "Food", "Transport", "Clothes", "Fun", "Misc"]
    @IBOutlet weak var categoryView: UICollectionView!
    @IBOutlet weak var categoryViewHeight: NSLayoutConstraint!
    
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
        
        //Set up categoryView
        categoryViewHeight.constant = 108.25*2//(functionCategoryView.frame.height - categoryView.frame.minY)*0.4
        categoryView.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
        categoryView.layoutIfNeeded()
        
        //Set up collectionview
        categoryView.backgroundColor = toolbar.barTintColor
        categoryView.delegate = self
        categoryView.dataSource = self

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
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CategoryCollectionViewCell
        cell.categoryLabel.text = categories[indexPath.row]
        cell.categoryImageView.image = UIImage(named: categories[indexPath.row])
        cell.backgroundColor = UIColor.redColor()
        cell
        // Configure the cell
        
        return cell
    }
    
    // MARK: UICollectionViewFlowLayoutDelegate
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            let width = categoryView.frame.width/4 //90
            print(width)
            let labelHeight = CGFloat(20)
            let height = width + labelHeight
            //categoryView.frame.height/2 //100
            print(height)
            return CGSize(width: width, height: height)
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
            return CGFloat(0)
    }
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
            return CGFloat(0)
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
