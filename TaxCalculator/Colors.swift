//
//  Colors.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-10.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

extension UIColor {
    class func customGreenColor() ->UIColor{
        return UIColor(red: 80/255.0, green: 227/255.0, blue: 194/255.0, alpha: 1.0)
    }
    //Our custom orange color is brighter than official orange color
    class func customOrangeColor() -> UIColor{
        return UIColor(red: 255/255.0, green: 150/255.0, blue: 0/255.0, alpha: 1.0)
    }
    class func customBlackColor() -> UIColor{
        return UIColor(red: 13/255.0, green: 13/255.0, blue: 19/255.0, alpha: 1.0)
    }
    class func customBackgroundColor(alpha: CGFloat) -> UIColor{
        return UIColor(red: 30/255.0, green: 27/255.0, blue: 25/255.0, alpha: alpha/100.0)
    }
    
}
