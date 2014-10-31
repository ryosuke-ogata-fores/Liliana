//
//  UIImageView+Loader.swift
//  Liliana
//
//  Created by r-ogata on 2014/10/31.
//  Copyright (c) 2014年 rogata. All rights reserved.
//

import UIKit

extension UIImageView {

    func setImageWithUrl(url:String, defIconName:String) -> Void {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            let url:NSURL = NSURL(string: url)!
            var err: NSError?
            
            var request:NSURLRequest = NSURLRequest(URL: url,
                cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
                timeoutInterval: 8.0)
            NSURLConnection.sendAsynchronousRequest(request,
                queue: NSOperationQueue(),
                completionHandler: { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if (data == nil || error != nil) {
                            println(error.code, error.description);
                            self.image = UIImage(named: "not")
                        }
                        else {
                            self.image = UIImage(data: data)
                        }
                        self.layoutIfNeeded()
                    });
            });
        });
    }
}