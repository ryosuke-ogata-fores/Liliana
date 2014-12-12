//
//  DestinationAnnotationView.swift
//  Liliana
//
//  Created by r-ogata on 2014/12/12.
//  Copyright (c) 2014 rogata. All rights reserved.
//

import MapKit

class DestinationAnnotationView: MKAnnotationView {
    override init!(annotation: MKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.initializeMember()
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.initializeMember()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeMember()
    }

    /**
     *reuseIdentifierを返す
     */
    class func identifier() -> String {
        return "destPin"
    }
    
    private func initializeMember() {
        self.canShowCallout = true
        self.image = UIImage(named: "pin")
        self.calloutOffset = CGPointMake(21, 42)
    }
}