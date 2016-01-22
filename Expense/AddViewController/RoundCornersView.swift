//
//  NoteboxView.swift
//  Expense
//
//  Created by Monica Ong on 1/20/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

class RoundCornersView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutRoundedCornersMask()
    }
    
    private func layoutRoundedCornersMask(){
        let mask = self.shapeMaskLayer()
        let bounds = self.bounds
        if mask.frame != bounds{
            mask.frame = bounds
            
            //Set corner size
            let cornerSize = mask.bounds.height/19
            //Create path
            let roundedPath = UIBezierPath(roundedRect: mask.bounds, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSizeMake(cornerSize, cornerSize))
            
            //Set mask path
            mask.path = roundedPath.CGPath
        }
    }
    
    private func shapeMaskLayer() -> CAShapeLayer {
        if let layer = self.layer.mask as? CAShapeLayer {
            return layer
        }
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.whiteColor().CGColor
        layer.backgroundColor = UIColor.clearColor().CGColor
        self.layer.mask = layer
        return layer
    }
}
