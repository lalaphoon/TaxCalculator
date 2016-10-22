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
    class func chartYellowColor() ->UIColor{
        return UIColor(red: 254/255.0, green: 205/255.0, blue: 3/255.0, alpha:1.0)
    }
    class func chartRedColor() -> UIColor{
        return UIColor(red: 252/255.0, green: 138/255.0, blue: 100/255.0, alpha: 1.0)
    }
    class func chartGreenColor() -> UIColor{
        return UIColor(red: 135/255.0, green: 208/255.0, blue: 72/255.0, alpha:1.0)
    }
    class func chartBlueColor() -> UIColor{
        return UIColor(red: 84/255.0, green: 199/255.0, blue: 252/255.0, alpha: 1.0)
    }
    //Our custom orange color is brighter than official orange color
    class func customOrangeColor() -> UIColor{
        return UIColor(red: 255/255.0, green: 150/255.0, blue: 0/255.0, alpha: 1.0)
    }
    class func customBlackColor() -> UIColor{
        return UIColor(red: 13/255.0, green: 13/255.0, blue: 19/255.0, alpha: 1.0)
    }
    class func customWhiteColor(alpha: CGFloat) -> UIColor {
        return UIColor(red: 1, green: 1.0, blue: 1.0, alpha: alpha/100.0);
    }
    class func customBackgroundColor(alpha: CGFloat) -> UIColor{
        return UIColor(red: 30/255.0, green: 27/255.0, blue: 25/255.0, alpha: alpha/100.0)
    }
    class func customRedButton() -> UIColor{
        return UIColor(red: 242/255.0, green: 151/255.0, blue: 120/255.0, alpha: 1.0)
    }
    class func customGreenButton() -> UIColor{
        return UIColor(red: 47/255.0, green: 193/255.0, blue: 160/255.0, alpha: 1.0)
    }
    class func customGreenSignal() -> UIColor{
        return UIColor(red: 125/255.0, green: 222/255.0, blue: 142/255.0, alpha: 1.0)
    }
    class func customLabelGreen() -> UIColor{
        return UIColor(red: 118/255.0, green: 194/255.0, blue: 175/255.0, alpha: 1.0)
    }
    
}
