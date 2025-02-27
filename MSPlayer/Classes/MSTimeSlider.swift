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
    
    private var isNoPreview: Bool = true
    
    private var thumbFrame: CGRect {
        
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }
    
    private var widthRatio: CGFloat {
        
        if UIApplication.shared.statusBarOrientation.isPortrait {
            
            return UIScreen.main.bounds.width / 360
            
        } else {
            
            return UIScreen.main.bounds.height / 360
        }
    }
    
    private var leadingGap: CGFloat {
        
        let portraitLeadingGap: CGFloat = 20 + (30 * widthRatio) * 24 / 32
        
        let landscapeLeadingGap: CGFloat = 40 + 20 + 20 + (30 * widthRatio) * 24 / 32
        
        return UIApplication.shared.statusBarOrientation.isPortrait ? portraitLeadingGap : landscapeLeadingGap
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
        thumbTextLabel.frame.origin.y = thumbFrame.minY - 16
        
        playerPreviewImageContainerView.center.x = ((thumbFrame.maxX - thumbFrame.minX) / 2) + thumbFrame.minX
        playerPreviewImageContainerView.frame.origin.y = thumbFrame.minY - 28 - (94 * widthRatio)
        playerPreviewImageContainerView.frame.size = CGSize(width: 164 * widthRatio, height: 94 * widthRatio)
        
        playerPreviewImageView.center.x = ((thumbFrame.maxX - thumbFrame.minX) / 2) + thumbFrame.minX
        playerPreviewImageView.frame.origin.y = thumbFrame.minY - 28 - (92 * widthRatio)
        playerPreviewImageView.frame.size = CGSize(width: 160 * widthRatio, height: 90 * widthRatio)
        
        // 此為 timeSlider 目前左邊的間距
        if playerPreviewImageContainerView.frame.origin.x < -leadingGap {
            
            playerPreviewImageContainerView.frame.origin.x = -leadingGap
        }
        
        if playerPreviewImageView.frame.origin.x < -leadingGap + 2 {
            
            playerPreviewImageView.frame.origin.x = -leadingGap + 2
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
        playerPreviewImageContainerView.layer.cornerRadius = 3.3 * widthRatio
        playerPreviewImageContainerView.clipsToBounds = true
        playerPreviewImageContainerView.isHidden = true
    }
    
    private func setupImageView() {
        
        addSubview(playerPreviewImageView)
        playerPreviewImageView.layer.cornerRadius = 3.3 * widthRatio
        playerPreviewImageView.isHidden = true
        playerPreviewImageView.backgroundColor = .black
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
        
        thumbTextLabel.isHidden = isNoPreview ? true : isHidden
    }
    
    open func setPreviewImage(image: UIImage) {
        
        playerPreviewImageView.image = image
    }
    
    open func hiddenOrShowPreviewImage(isHidden: Bool) {
        
        playerPreviewImageContainerView.isHidden = isNoPreview ? true : isHidden
        playerPreviewImageView.isHidden = isNoPreview ? true : isHidden
    }
    
    open func setupIsNoPreviewImages(_ isNoPreview: Bool) {
        
        self.isNoPreview = isNoPreview
    }
}
