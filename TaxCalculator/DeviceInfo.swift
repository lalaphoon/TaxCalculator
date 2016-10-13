//
//  DeviceInfo.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-10-13.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation
//
//  ExtensionForUIDevice.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-10-13.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import Foundation


public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 where value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}
// 获取设备名称

let DEVICENAME = UIDevice.currentDevice().name
// 获取系统版本号
let SYSTEMVERSION = UIDevice.currentDevice().systemVersion
// 获取设备的型号
let DEVICEMODEL = UIDevice.currentDevice().model
// 获取设备唯一标识符
let DEVICEUUID = UIDevice.currentDevice().identifierForVendor?.UUIDString
// 调用
let modelName = UIDevice.currentDevice().modelName

let infoDic = NSBundle.mainBundle().infoDictionary

// 获取 App 的版本号
let appVersion = infoDic?["CFBundleShortVersionString"]
// 获取 App 的 build 版本
let appBuildVersion = infoDic?["CFBundleVersion"]
// 获取 App 的名称
let appName = infoDic?["CFBundleDisplayName"]
