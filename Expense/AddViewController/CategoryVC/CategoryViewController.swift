//
//  CategoryViewController.swift
//  Expense
//
//  Created by Monica Ong on 1/21/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, AKPickerViewDelegate, AKPickerViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {
    
    //Theme colors
    private let themeColors = ThemeColors()
    private let expensesOrganizer = ExpensesOrganizer()
    
    //Views & layout elements
    @IBOutlet private weak var backgroundView: UIImageView!
    var backgroundImage: UIImage?
    
    @IBOutlet private weak var fullView: UIView!
    var fullViewColor: UIColor?

    @IBOutlet private weak var toolbar: UIToolbar!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    @IBOutlet private weak var functionCategoryView: RoundCornersView!
    @IBOutlet private weak var functionCategoryHeightFromTop: NSLayoutConstraint!
    var functionCategoryHeightFromTopConstant: CGFloat?
    @IBOutlet private weak var functionCategoryHeightFromBottom: NSLayoutConstraint!
    var functionCategoryHeightFromBottomConstant: CGFloat?
    
    @IBOutlet private weak var functionPicker: AKPickerView!
    @IBOutlet private weak var functionPickerHeight: NSLayoutConstraint!
    
    @IBOutlet private weak var categoryView: UICollectionView!
    @IBOutlet private weak var categoryViewHeight: NSLayoutConstraint!
    private var categories: [[Category]] = [[Category]]()
    
    @IBOutlet weak var subCategoryTableView: UITableView!
    
    //Auto-selected items
    var currentFunction: Function?
    var currentCategory: Category?
    
    //Data
    var function: Function?
    var category: Category?
    var subcategory: Subcategory?
    
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
        functionPicker.backgroundColor = themeColors.getThemeTintColor()
        functionPicker.interitemSpacing = CGFloat(10)
        functionPicker.pickerViewStyle = .Wheel
        functionPicker.maskDisabled = true
        functionPicker.reloadData()
        
        //Set up categories array
        let rows = 2
        let columns = 4
        for r in 0...rows-1{
            var rowList = [Category]()
            for c in 0...columns-1{
                if r == 0{
                    rowList.append(expensesOrganizer.getCategory(c)) //first row
                } else{
                    rowList.append(expensesOrganizer.getCategory(4+c)) //second row
                }
            }
            categories.append(rowList)
        }
        
        //Set up category view
        categoryView.backgroundColor = themeColors.getViewBackgroundColor()
        categoryView.delegate = self
        categoryView.dataSource = self
        
        //Set function & category & subcategory to auto-selected element
        function = currentFunction
        category = currentCategory
        subcategory = Subcategory.None
        
        //Set up subCategory table view
        subCategoryTableView.dataSource = self
        subCategoryTableView.delegate = self
        
        //Extend separator line
        subCategoryTableView.separatorColor = themeColors.getBackgroundColor()
        subCategoryTableView.separatorInset = UIEdgeInsetsZero
        subCategoryTableView.layoutMargins = UIEdgeInsetsZero
        subCategoryTableView.backgroundColor = themeColors.getViewBackgroundColor()
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
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expensesOrganizer.getNumOfSubcategoriesFor(category!)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let subcategoryCell = tableView.dequeueReusableCellWithIdentifier("subCategoryCell", forIndexPath: indexPath) as! SubcategoryTableViewCell
        let subcategory = expensesOrganizer.getSubcategoryFor(category!, index: indexPath.row)
        subcategoryCell.subCategoryLabel.text = "\(indexPath.row) \(expensesOrganizer.getText(subcategory.rawValue))"
        subcategoryCell.selectedBackgroundView = UIView(frame: CGRect.zero)
        subcategoryCell.selectedBackgroundView?.backgroundColor = themeColors.getColorOfCategory(category!)
        
        return subcategoryCell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //Extend separator line
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    var indexPathSelectedCell: NSIndexPath?
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let subcategoryCell = tableView.cellForRowAtIndexPath(indexPath) as! SubcategoryTableViewCell
        subcategoryCell.subCategoryLabel.textColor = UIColor.redColor()//themeColors.getViewBackgroundColor()
        subcategoryCell.subCategoryLabel.text = "\(indexPath.row) didSELECTRowAtIndexPath called"
        subcategory = expensesOrganizer.getSubcategoryFor(category!, index: indexPath.row)
        indexPathSelectedCell = indexPath
        print(indexPathSelectedCell?.row)
        let selectedRows = subCategoryTableView.indexPathsForSelectedRows
        for i in selectedRows! {
            if !i.isEqual(indexPath){
                subCategoryTableView.deselectRowAtIndexPath(i, animated: false)
            }
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let subcategoryCell = tableView.cellForRowAtIndexPath(indexPath) as! SubcategoryTableViewCell
        subcategoryCell.subCategoryLabel.textColor = themeColors.getFontColor(Shade.Light)
        subcategoryCell.subCategoryLabel.text = "\(indexPath.row) didDESELECTRowAtIndexPath called"
        
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return categories.count
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categories[0].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // Configure the cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("categoryCell", forIndexPath: indexPath) as! CategoryCollectionViewCell
        let category = categories[indexPath.section][indexPath.row]
        self.roundView(cell)
        let categoryText = expensesOrganizer.getText(category.rawValue)
        cell.categoryImageView.image = UIImage(named: categoryText)
        cell.categoryLabel.text = categoryText
        if cell.selected {
            cell.backgroundColor = themeColors.getColorOfCategory(category)
            cell.categoryImageView.tintColor = themeColors.getViewBackgroundColor()
        }else{
            cell.backgroundColor = themeColors.getViewBackgroundColor()
            cell.categoryImageView.tintColor = themeColors.getColorOfCategory(category)
        }
        cell.categoryLabel.textColor = cell.categoryImageView.tintColor
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let category = categories[indexPath.section][indexPath.row]
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CategoryCollectionViewCell
        cell.backgroundColor = themeColors.getColorOfCategory(category)
        cell.categoryImageView.tintColor = themeColors.getViewBackgroundColor()
        cell.categoryLabel.textColor = cell.categoryImageView.tintColor
        //reload tableview
            //Deselect selected cell
        if let indP = indexPathSelectedCell{
            self.tableView(subCategoryTableView, didDeselectRowAtIndexPath: indP)
        }
        
        self.category = category
        
        //Reset data
        indexPathSelectedCell = nil
        self.subcategory = Subcategory.None
        subCategoryTableView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let category = categories[indexPath.section][indexPath.row]
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CategoryCollectionViewCell
        cell.backgroundColor = themeColors.getViewBackgroundColor()
        cell.categoryImageView.tintColor = themeColors.getColorOfCategory(category)
        cell.categoryLabel.textColor = cell.categoryImageView.tintColor
    }
    
    func roundView(view: UIView){
        //Set corner size
        let cornerSize = CGFloat(7)//CGFloat(11.7105263157895)
        
        //Create path
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSizeMake(cornerSize, cornerSize))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.CGPath
        view.layer.mask = maskLayer
        
    }
    
    // MARK: UICollectionViewFlowLayoutDelegate
    
    let collectViewCellSpace = CGFloat(5)
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            let interItemSpace = self.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAtIndex: indexPath.section)
            let insetSectSpace = collectViewCellSpace
            return CGSize(width: (collectionView.frame.width-CGFloat(5*interItemSpace))/4, height: (collectionView.frame.height-CGFloat(3*(insetSectSpace)))/2)
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: collectViewCellSpace, left: collectViewCellSpace, bottom: 0, right: collectViewCellSpace)
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
            return collectViewCellSpace
    }
    
//    func collectionView(collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
//            return CGFloat(4)
//    }
    
    // MARK: - AKPickerViewDataSource
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return self.expensesOrganizer.getNumOfFunctions()
    }
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        let function = self.expensesOrganizer.getFunction(item)
        return self.expensesOrganizer.getText(function.rawValue)
    }
    
    // MARK: - AKPickerViewDelegate
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        function = self.expensesOrganizer.getFunction(item)
    }
    
    //Label Customization
    func pickerView(pickerView: AKPickerView, configureLabel label: UILabel, forItem item: Int) {
        label.textColor = fullViewColor
        label.highlightedTextColor = UIColor.whiteColor()
        label.backgroundColor = functionPicker.backgroundColor
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
