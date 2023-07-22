//
//  MSTimeSlider.swift
//  MSPlayer_Example
//
//  Created by Mason on 2018/4/18.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

public class MSTimeSlider: UISlider {
    
    private var thumbTextLabel: UILabel = UILabel()
    
    private var thumbFrame: CGRect {
        
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        thumbTextLabel.center.x = ((thumbFrame.maxX - thumbFrame.minX) / 2) + thumbFrame.minX
        thumbTextLabel.frame.origin.y = thumbFrame.minY - 28
        thumbTextLabel.frame.size = CGSize(width: 40, height: 16)
    }
    
    override open func trackRect(forBounds bounds: CGRect) -> CGRect {
        let trackHeigt:CGFloat = bounds.height * 2 / 25
        let position = CGPoint(x: 0 , y: (bounds.height - 1) / 2 - trackHeigt / 2)
        let customBounds = CGRect(origin: position, size: CGSize(width: bounds.size.width, height: trackHeigt))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
    
    private func setupLabel() {
        
        addSubview(thumbTextLabel)
        thumbTextLabel.textAlignment = .center
        thumbTextLabel.textColor = .white
        thumbTextLabel.layer.zPosition = layer.zPosition + 1
        thumbTextLabel.adjustsFontSizeToFitWidth = true
        thumbTextLabel.font = UIFont(name: "PingFangSC-Medium", size: 12)
    }
    
    override open func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        let rect = super.thumbRect(forBounds: bounds, trackRect: rect, value: value)
        let newx = rect.origin.x - (bounds.width * 0.02)
        let width = bounds.height / 2
        let height = bounds.height / 2
        let newRect = CGRect(x: newx, y: bounds.height / 4, width: width, height: height)
        return newRect
    }
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
    
    open func setThumbLabelValue(value: String) {
        
        thumbTextLabel.text = value
    }
    
    open func hiddenOrShowThumbTextLabel(isHidden: Bool) {
        
        thumbTextLabel.isHidden = isHidden
    }
}
