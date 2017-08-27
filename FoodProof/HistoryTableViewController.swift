//
//  HistoryTableViewController.swift
//  FoodProof
//
//  Created by Drew Patel on 8/26/17.
//  Copyright © 2017 Drew Patel. All rights reserved.
//

import UIKit
import Alamofire
import FontAwesomeKit_Swift
class MasterViewControllerCell: UITableViewCell{
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var addressBox: UILabel!
    @IBOutlet weak var date: UILabel!
}

class Location {
    
    var title: String!
    var thumbnail: Int!
    var address: String!
    var date: String!

    init (value: NSDictionary) {
        title = value["title"] as? String
        thumbnail = value["thumbnail"] as? Int
        address = value["address"] as? String
        date = unixToEasy(time: (value["date"] as? Int)!)
    }

    
    func unixToEasy(time: Int) -> String{
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM/dd"
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
}


class HistoryTableViewController: UITableViewController {
    
    var locations = [Location]()
    var addresses = [String]()
    var times = [String]()
    var farmNames = ["Balaji's Mango Farm","Dole Foods","Prime Logistics","Whole Foods"]
    
    override func viewDidLoad() {
        
        tableView.reloadData();

        super.viewDidLoad()
        print("test")
        var uniqueID = UserDefaults.standard.value(forKey: "uniqueID")!
        Alamofire.request("http://64dcd5c7.ngrok.io/getHistory?uniqueId=\(uniqueID)").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value{
                
                if let array = json as? [Any] {
                    if let firstObject = array.first {
                        for object in (firstObject as? [Any])!{
                            print(object)
                            self.addresses.append(object as! String)
                            self.tableView.reloadData();
                            print(self.addresses)
                        }
                    }
                    var arrayNew = array.dropFirst();
                    
                    if let firstObject1 = arrayNew.first {
                        for object in (firstObject1 as? [Any])!{
                            print(object)
                            self.times.append(object as! String)
                            self.tableView.reloadData();
                            print(self.times)
                        }
                    }
                    
                    for object in array {
                        
                        
                    }
                    
                    for case let string as String in array {
                        // access only string values in array
                    }
                }
            }
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return addresses.count
    }
    

    
    
    func unixToEasy(time: String) -> String{
        var timeString = String(time)
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeString!)!)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MM/dd"
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "masterCell", for: indexPath) as! MasterViewControllerCell

        cell.addressBox.text = self.addresses[indexPath.row]
        cell.date.text = (unixToEasy(time: self.times[indexPath.row]));
        //cell.date.text = String(self.times[indexPath.row])
        cell.title.text = farmNames[indexPath.row]
        print(farmNames[indexPath.row])
        switch indexPath.row {
        case 0  :
            cell.thumbnail.image = UIImage(awesomeType: .fa_pagelines, size: 20.0)
        case 1  :
            cell.thumbnail.image = UIImage(awesomeType: .fa_industry, size: 20.0)
        case 2  :
            cell.thumbnail.image = UIImage(awesomeType: .fa_truck, size: 20.0)
        case 3  :
            cell.thumbnail.image = UIImage(awesomeType: .fa_shopping_cart, size: 20.0)
        default :
            cell.thumbnail.image = UIImage(awesomeType: .fa_user, size: 20.0)
        }
        
    

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
