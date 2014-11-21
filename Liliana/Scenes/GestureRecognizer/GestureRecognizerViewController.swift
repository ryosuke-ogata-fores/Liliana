//
//  GestureRecognizerViewController.swift
//  Liliana
//
//  Created by rogata on 11/6/14.
//  Copyright (c) 2014 rogata. All rights reserved.
//

import UIKit

class GestureRecognizerViewController : UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var barView: UIView!

    override func viewDidLoad() {
        self.circleView.hidden = true
        self.barView.hidden = true
    }
    override func viewWillAppear(animated: Bool) {
    }
    override func viewDidAppear(animated: Bool) {
        self.circleView.layer.cornerRadius = CGRectGetHeight(self.circleView.frame) / 2
        self.circleView.layer.masksToBounds = true
        self.circleView.hidden = false
        self.barView.hidden = false
    }
    override func viewWillDisappear(animated: Bool) {
    }
    override func viewDidDisappear(animated: Bool) {
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func handlePinch(recognizer : UIPinchGestureRecognizer) {
        var view:UIView = recognizer.view!
        println("scale=\(recognizer.scale), velocity=\(recognizer.velocity)")
        if (view == self.circleView) {
            recognizer.view!.transform = CGAffineTransformScale(recognizer.view!.transform, recognizer.scale, recognizer.scale)
            recognizer.scale = 1
        }
        else if (view == self.barView) {
            recognizer.view!.transform = CGAffineTransformScale(recognizer.view!.transform, 1, recognizer.scale)
            recognizer.scale = 1
        }
    }
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        var view:UIView = recognizer.view!
        if (view == self.circleView
            || view == self.barView) {
                let translation = recognizer.translationInView(self.bgView)
                println("translation=\(translation.x),\(translation.y) on self.bgView")
                view.center = CGPoint(
                    x:view.center.x + translation.x,
                    y:view.center.y + translation.y)
                recognizer.setTranslation(CGPointZero, inView: self.bgView)
        }
    }
    @IBAction func handleRotation(recognizer: UIRotationGestureRecognizer) {
        var view:UIView = recognizer.view!
        if (view == self.barView) {
            println("rotation=\(recognizer.rotation)")
            view.transform = CGAffineTransformRotate(view.transform, recognizer.rotation)
            recognizer.rotation = 0
        }
    }
}
