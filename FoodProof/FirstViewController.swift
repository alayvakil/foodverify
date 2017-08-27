//
//  FirstViewController.swift
//  FoodProof
//
//  Created by Drew Patel on 8/26/17.
//  Copyright © 2017 Drew Patel. All rights reserved.
//

import UIKit
import FontAwesomeKit_Swift
import BarcodeScanner

class FirstViewController: UIViewController, BarcodeScannerErrorDelegate, BarcodeScannerCodeDelegate, BarcodeScannerDismissalDelegate {
    
    var unique = ""
    
    func barcodeScanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {
        print(code)
        unique = code
        controller.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "toPages", sender: nil)
    }
    
    func barcodeScanner(_ controller: BarcodeScannerController, didReceiveError error: Error) {
        print(error)
    }
    
    func barcodeScannerDidDismiss(_ controller: BarcodeScannerController) {
        controller.dismiss(animated: true, completion: nil)
    }


    @IBOutlet weak var uniqueIDBox: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //uniqueIDBox.setRightViewFAIcon(icon: .FASearch, rightViewMode: .always, textColor: .red, backgroundColor: .clear, size: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func scan(_ sender: Any) {
        let controller = BarcodeScannerController()
        controller.codeDelegate = self
        controller.errorDelegate = self
        controller.dismissalDelegate = self
        
        present(controller, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toPages") {
            if(unique == ""){
                UserDefaults.standard.setValue(uniqueIDBox.text, forKey: "uniqueID")
            }else{
                UserDefaults.standard.setValue(unique, forKey: "uniqueID")
            }
        }
    }
}

