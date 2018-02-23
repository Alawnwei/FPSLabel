//
//  FPSLabel.swift
//  FPSLabel
//
//  Created by 雷广 on 2018/2/23.
//  Copyright © 2018年 雷广. All rights reserved.
//
// [LGFPSWindow](https://github.com/leiguang/FPSLabel)
/**
 Show Screen FPS...
 
 The maximum fps in OSX/iOS Simulator is 60.00.
 The maximum fps on iPhone is 59.97.
 The maxmium fps on iPad is 60.0.
 */

import UIKit

class FPSLabel: UILabel {
    
    /// Proxy objct for prevending a reference cycle between the CADisplayLink and LGFPSLabel.
    class TargetProxy {
        private weak var target: FPSLabel?
        
        init(target: FPSLabel) {
            self.target = target
        }
        
        @objc func onTick(link: CADisplayLink) {
            target?.tick(link: link)
        }
    }
    
    var displayLink: CADisplayLink!
    var count: UInt = 0
    var lastTime: TimeInterval? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 5
        clipsToBounds = true
        font = UIFont.systemFont(ofSize: 14)
        textAlignment = .center
        backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        /// A display link that keeps calling the `tick` method on every screen refresh.
        displayLink = CADisplayLink(target: TargetProxy(target: self), selector: #selector(TargetProxy.onTick))
        displayLink.add(to: .main, forMode: .commonModes)
        
        // Add pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        isUserInteractionEnabled = true
        addGestureRecognizer(panGesture)
    }
    
    @objc func tick(link: CADisplayLink) {
        if lastTime == nil {
            lastTime = link.timestamp
            return
        }
        
        count += 1
        let delta = link.timestamp - lastTime!
        if delta < 1 { return }
        lastTime = link.timestamp
        let fps = Double(count) / delta
        count = 0
        
        let progress = fps / 60.0
        let color = UIColor(hue: CGFloat(0.27 * (progress - 0.2)), saturation: 1, brightness: 0.9, alpha: 1)
        
        let myText = NSMutableAttributedString(string: "\(Int(round(fps)))", attributes: [NSAttributedStringKey.foregroundColor: color])
        myText.append(NSMutableAttributedString(string: " FPS", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white]))
        attributedText = myText
    }
    
    deinit {
        displayLink.invalidate()
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        guard let superview = superview else { return }
        let point = gesture.translation(in: superview)
        var newOrigin = self.frame.origin
        newOrigin = CGPoint(x: newOrigin.x + point.x, y: newOrigin.y + point.y)
        
        // Prevent from moving outside
        let safeTop: CGFloat = 20
        let safeLeft: CGFloat = 20
        let safeBottom: CGFloat = 20
        let safeRight: CGFloat = 20
        
        let x = newOrigin.x
        let y = newOrigin.y
        
        if x < safeLeft {
            newOrigin.x = safeLeft
        }
        if x + self.frame.size.width > superview.bounds.width - safeRight {
            newOrigin.x = superview.bounds.width - safeRight - self.frame.size.width
        }
        if y < safeTop {
            newOrigin.y = safeTop
        }
        if y + self.frame.size.height > superview.bounds.height - safeBottom {
            newOrigin.y = superview.bounds.height - safeBottom - self.frame.size.height
        }
        
        self.frame.origin = newOrigin
        gesture.setTranslation(CGPoint(x: 0, y: 0) , in: superview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
