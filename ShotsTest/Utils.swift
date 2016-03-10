//
//  Utils.swift
//  ShotsTest
//
//  Created by Sergei Makarov on 10.03.16.
//  Copyright © 2016 Sergei Makarov. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    class func asyncLoadShotImage(shot: Shot, imageView : UIImageView){
        
        let downloadQueue = dispatch_queue_create("Utils.processsdownload", nil)
        
        dispatch_async(downloadQueue) {
            
            let data = NSData(contentsOfURL: NSURL(string: shot.imageUrl)!)
            
            var image : UIImage?
            if data != nil {
                shot.imageData = data
                image = UIImage(data: data!)!
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }
    }
    
    class func getStringFromJSON(data: NSDictionary, key: String) -> String{
        
        //let info : AnyObject? = data[key]
        
        if let info = data[key] as? String {
            return info
        }
        return ""
    }
    
    class func stripHTML(str: NSString) -> String {
        
        var stringToStrip = str
        var r = stringToStrip.rangeOfString("<[^>]+>", options:.RegularExpressionSearch)
        while r.location != NSNotFound {
            
            stringToStrip = stringToStrip.stringByReplacingCharactersInRange(r, withString: "")
            r = stringToStrip.rangeOfString("<[^>]+>", options:.RegularExpressionSearch)
        }
        
        return stringToStrip as String
    }
    
    
}