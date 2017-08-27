
//
//  CreateFormViewController.swift
//  FoodProof
//
//  Created by Drew Patel on 8/26/17.
//  Copyright © 2017 Drew Patel. All rights reserved.
//

import UIKit
import Eureka
import EZAlertController

class CreateFormViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Ethereum Info")
            <<< LabelRow(){
                $0.value = "0x95643e75dad87c18657ed730f3cc94c65313e7ca"
            }
            +++ Section("Product Info")
            <<< ActionSheetRow<String>("name") {
                $0.title = "Item"
                $0.selectorTitle = "Pick the item"
                $0.options = ["Apple","Apricot","Avocado","Banana","Bilberry","Blackberry","Blueberry","Boysenberry","Currant","Cherry","Cherimoya","Chico fruit","Cloudberry","Coconut","Cranberry","Cucumber"]
                $0.value = "Banana"    // initially selected
            }
            <<< IntRow(){
                $0.title = "Amount"
                $0.placeholder = "12"
            }
            <<< DecimalRow(){
                $0.title = "Weight(kgs)"
                $0.placeholder = "4.5"
            }
        

        

        // Do any additional setup after loading the view.
    }

    @IBAction func createItem(_ sender: Any) {
        //EZAlertController.alert("Done", message: "Your item has been recorded to the blockchain")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
