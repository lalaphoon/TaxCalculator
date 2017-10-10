//
//  EmptyBackgroundView.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-09-07.
//  Copyright © 2016 WTC Tax. All rights reserved.
// source from: http://www.benmeline.com/ios-empty-table-view-with-swift/

import Foundation
import UIKit
import PureLayout

class EmptyBackgroundView: UIView {
    
    fileprivate var topSpace: UIView!
    fileprivate var bottomSpace: UIView!
    fileprivate var imageView: UIImageView!
    fileprivate var topLabel: UILabel!
    fileprivate var bottomLabel: UILabel!
    
    fileprivate let topColor = UIColor.darkGray
    fileprivate let topFont = UIFont.boldSystemFont(ofSize: 22)
    fileprivate let bottomColor = UIColor.gray
    fileprivate let bottomFont = UIFont.systemFont(ofSize: 18)
    
    fileprivate let spacing: CGFloat = 10
    fileprivate let imageViewHeight: CGFloat = 100
    fileprivate let bottomLabelWidth: CGFloat = 300
    
    var didSetupConstraints = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    init(image: UIImage, top: String, bottom: String) {
        super.init(frame: CGRect.zero)
        setupViews()
        setupImageView(image)
        setupLabels(top, bottom: bottom)
    }
    
    func setupViews() {
        topSpace = UIView.newAutoLayout()
        bottomSpace = UIView.newAutoLayout()
        imageView = UIImageView.newAutoLayout()
        topLabel = UILabel.newAutoLayout()
        bottomLabel = UILabel.newAutoLayout()
        
        addSubview(topSpace)
        addSubview(bottomSpace)
        addSubview(imageView)
        addSubview(topLabel)
        addSubview(bottomLabel)
    }
    
    func setupImageView(_ image: UIImage) {
        imageView.image = image
        imageView.tintColor = topColor
    }
    
    func setupLabels(_ top: String, bottom: String) {
        topLabel.text = top
        topLabel.textColor = topColor
        topLabel.font = topFont
        
        bottomLabel.text = bottom
        bottomLabel.textColor = bottomColor
        bottomLabel.font = bottomFont
        bottomLabel.numberOfLines = 0
        bottomLabel.textAlignment = .center
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            topSpace.autoAlignAxis(toSuperviewAxis: .vertical)
            topSpace.autoPinEdge(toSuperviewEdge: .top)
            bottomSpace.autoAlignAxis(toSuperviewAxis: .vertical)
            bottomSpace.autoPinEdge(toSuperviewEdge: .bottom)
            topSpace.autoSetDimension(.height, toSize: spacing, relation: .greaterThanOrEqual)
            topSpace.autoMatch(.height, to: .height, of: bottomSpace)
            
            imageView.autoPinEdge(.top, to: .bottom, of: topSpace)
            imageView.autoAlignAxis(toSuperviewAxis: .vertical)
            imageView.autoSetDimension(.height, toSize: imageViewHeight, relation: .lessThanOrEqual)
            
            topLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            topLabel.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: spacing)
            
            bottomLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            bottomLabel.autoPinEdge(.top, to: .bottom, of: topLabel, withOffset: spacing)
            bottomLabel.autoPinEdge(.bottom, to: .top, of: bottomSpace)
            bottomLabel.autoSetDimension(.width, toSize: bottomLabelWidth)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}
