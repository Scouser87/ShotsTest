//
//  DribbbleAPI.swift
//  ShotsTest
//
//  Created by Sergei Makarov on 10.03.16.
//  Copyright © 2016 Sergei Makarov. All rights reserved.
//

import Foundation

class DribbbleAPI {
    
    let accessToken = "dc5a71673c52e02fb510a7bf514789a90c1d9c169c13edbd92e5e19ba74a5f56"
    
    func loadShots(shotsUrl: String, completion: (([Shot]) -> Void)!) {
        
        let urlString = shotsUrl + "?access_token=" + accessToken + "&page=1&per_page=50"
        
        let session = NSURLSession.sharedSession()
        let shotsUrl = NSURL(string: urlString)
        
        let task = session.dataTaskWithURL(shotsUrl!){
            (data, response, error) -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                
                // save to file:
                let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
                let writePath = documents.stringByAppendingString("/file.json")
                print("local file path: " + writePath)
                data?.writeToFile(writePath, atomically: true)
                // end save to file
                
                var shots = [Shot]()
                do {
                    let shotsData = try NSJSONSerialization.JSONObjectWithData(data! , options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    
                    for shot in shotsData{
                        let shot = Shot(data: shot as! NSDictionary)
                        shots.append(shot)
                    }
                    
                }catch{
                    
                }
                
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(shots)
                    }
                }
                
            }
        }
        
        task.resume()
    }
    
    func loadLocalShots(completion: (([Shot]) -> Void)!) {
        
        var shots = [Shot]()
        
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let readPath = documents.stringByAppendingString("/file.json")
        
        if(NSFileManager.defaultManager().fileExistsAtPath(readPath))
        {
            do {
                // read from file
                let data : NSData? = NSData(contentsOfFile: readPath)!
                // end read from file
                
                let shotsData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSArray
                
                for shot in shotsData{
                    let shot = Shot(data: shot as! NSDictionary)
                    shots.append(shot)
                }
            }
            catch
            {
                
            }
        }
        
        completion(shots)
    }
}