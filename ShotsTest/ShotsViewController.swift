//
//  ShotsViewController.swift
//  ShotsTest
//
//  Created by Sergei Makarov on 10.03.16.
//  Copyright © 2016 Sergei Makarov. All rights reserved.
//

import UIKit

let shotsData = [ Shot(),
    Shot(),
    Shot() ]

class ShotsViewController: UITableViewController {

    var shots: [Shot] = []
    
    var api : DribbbleAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.api = DribbbleAPI()
        
        updateShots()
    }
    
    func didLoadShots(loadedShots: [Shot]){
        
        self.shots.removeAll()  // remove all prevous shots
        
        for shot in loadedShots {
            self.shots.append(shot)
        }
        self.tableView.reloadData()
    }
    
    func updateShots(){
        
        let url = "https://api.dribbble.com/v1/shots"
        api.loadShots(url, completion: didLoadShots)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shots.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ShotCell", forIndexPath: indexPath)
            as! ShotCell
        
        let shot = shots[indexPath.row] as Shot
        cell.titleLabel.text = shot.title
        cell.descriptionLabel.text = shot.description
        //cell.ratingImageView.image = imageForRating(player.rating)
        
        //cell.previewImageView.image = UIImage(named: "whitebox.jpg")
        if shot.imageData != nil {
            cell.previewImageView.image = UIImage(data: shot.imageData!)!
        }
        else {
            Utils.asyncLoadShotImage(shot, imageView: cell.previewImageView)
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
