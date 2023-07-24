//
//  MSTimeSlider.swift
//  MSPlayer_Example
//
//  Created by Mason on 2018/4/18.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

public class MSTimeSlider: UISlider {
    
    private let playerPreviewImageContainerView: UIView = UIView()
    private let playerPreviewImageView: UIImageView = UIImageView()
    private let thumbTextLabel: UILabel = UILabel()
    
    private var thumbFrame: CGRect {
        
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLabel()
        setupContainerView()
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        thumbTextLabel.center.x = ((thumbFrame.maxX - thumbFrame.minX) / 2) + thumbFrame.minX
        thumbTextLabel.frame.origin.y = thumbFrame.minY - 28
        
        playerPreviewImageContainerView.center.x = ((thumbFrame.maxX - thumbFrame.minX) / 2) + thumbFrame.minX
        playerPreviewImageContainerView.frame.origin.y = thumbFrame.minY - 134
        
        playerPreviewImageView.center.x = ((thumbFrame.maxX - thumbFrame.minX) / 2) + thumbFrame.minX
        playerPreviewImageView.frame.origin.y = thumbFrame.minY - 132
        
        // 此為 timeSlider 目前左邊的間距
        let leadingGap: CGFloat = 20 + (30 * UIScreen.main.bounds.width / 375) * 24 / 32
        
        if playerPreviewImageContainerView.frame.origin.x < -leadingGap {
            
            playerPreviewImageContainerView.frame.origin.x = -leadingGap
        }
        
        if playerPreviewImageView.frame.origin.x < -leadingGap + 2 {
            
            playerPreviewImageContainerView.frame.origin.x = -leadingGap + 2
        }
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
        thumbTextLabel.isHidden = true
        thumbTextLabel.frame.size = CGSize(width: 40, height: 16)
    }
    
    private func setupContainerView() {
        
        addSubview(playerPreviewImageContainerView)
        playerPreviewImageContainerView.backgroundColor = .white
        playerPreviewImageContainerView.layer.cornerRadius = 3.3 * UIScreen.main.bounds.width / 360
        playerPreviewImageContainerView.clipsToBounds = true
        playerPreviewImageContainerView.isHidden = true
        playerPreviewImageContainerView.frame.size = CGSize(width: 164 * UIScreen.main.bounds.width / 360,
                                                            height: 94 * UIScreen.main.bounds.width / 360)
    }
    
    private func setupImageView() {
        
        addSubview(playerPreviewImageView)
        playerPreviewImageView.layer.cornerRadius = 3.3 * UIScreen.main.bounds.width / 360
        playerPreviewImageView.isHidden = true
        playerPreviewImageView.frame.size = CGSize(width: 160 * UIScreen.main.bounds.width / 360,
                                                   height: 90 * UIScreen.main.bounds.width / 360)
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
    
    open func setPreviewImage(image: UIImage) {
        
        playerPreviewImageView.image = image
    }
    
    open func hiddenOrShowPreviewImage(isHidden: Bool) {
        
        playerPreviewImageContainerView.isHidden = isHidden
        playerPreviewImageView.isHidden = isHidden
    }
}
