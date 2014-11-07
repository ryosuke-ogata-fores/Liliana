//
//  TopViewController.swift
//  Liliana
//
//  Created by rogata on 2014/10/28.
//  Copyright (c) 2014 rogata. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchDownButton(sender: AnyObject) {
        var btn:UIButton = sender as UIButton
        let moveY:CGFloat = 8.0
        let dur:Double = 0.5
        var start:Double = 0
        btn.transform = CGAffineTransformTranslate(btn.transform, 0, -moveY);
        UIView.animateKeyframesWithDuration(
            0.3,
            delay: 0.0,
            options: UIViewKeyframeAnimationOptions.OverrideInheritedDuration,
            animations: { () -> Void in
                UIView.addKeyframeWithRelativeStartTime(start, relativeDuration: dur, animations: { () -> Void in
                    btn.transform = CGAffineTransformTranslate(btn.transform, 0, moveY);
                })
                start += dur
                UIView.addKeyframeWithRelativeStartTime(start, relativeDuration: dur, animations: { () -> Void in
                    btn.transform = CGAffineTransformTranslate(btn.transform, 0, -moveY);
                })
            },
            completion: { (Bool) -> Void in
                btn.transform = CGAffineTransformTranslate(btn.transform, 0, moveY);
            }
        )
    }
    @IBAction func touchUpInsideButton(sender: AnyObject) {
        var btn:UIButton = sender as UIButton
        println(btn.titleLabel?.text)
    }
}

