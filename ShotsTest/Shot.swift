//
//  Shot.swift
//  ShotsTest
//
//  Created by Sergei Makarov on 10.03.16.
//  Copyright © 2016 Sergei Makarov. All rights reserved.
//

import Foundation

class Shot {
    
    var id : Int!
    var title : String!
    var description : String!
    var imageUrl : String!
    var imageHdpiUrl : String!
    
    var imageData : NSData?
    var bigImageData : NSData?
    
    init(){
        self.id = 1
        self.title = "Default title"
        self.description = "Default description"
        self.imageUrl = ""
        self.imageHdpiUrl = ""
    }
    
    init(data : NSDictionary){
        
        self.id = data["id"] as! Int
        
        self.title = Utils.getStringFromJSON(data, key: "title")
        
        let desc = Utils.getStringFromJSON(data, key: "description")
        self.description = Utils.stripHTML(desc)
        
        let images = data["images"] as! NSDictionary
        self.imageUrl = Utils.getStringFromJSON(images, key: "normal")
        self.imageHdpiUrl = Utils.getStringFromJSON(images, key: "hidpi")
    }
}