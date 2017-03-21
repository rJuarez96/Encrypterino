//
//  EncryptionScreenController.swift
//  SegundoAvance
//
//  Created by AdrÍan Flores García on 21/03/17.
//  Copyright © 2017 Roberto. All rights reserved.
//

import UIKit

class EncryptionScreenController: UIViewController {
    //let prueba: Int =  2
    @IBOutlet weak var toEncryptLB: UITextView!
    
    @IBOutlet weak var toDecryptLB: UITextView!
    
    @IBAction func EncryptBT(_ sender: UIButton) {
        while (keyPairExists){
            AsymmetricCryptoManager.sharedInstance.deleteSecureKeyPair({ (success) -> Void in
                if success {
                    self.keyPairExists = false
                }
            })
        }
        // generate keypair
        AsymmetricCryptoManager.sharedInstance.createSecureKeyPair({ (success, error) -> Void in
            if success {
                self.keyPairExists = true
            }
        })
        
        //if toEncryptLB.text!.isEmpty {
            //SEND NOTIFICATION
        //}
        self.toDecryptLB.text = ""
        self.view.endEditing(true)
        AsymmetricCryptoManager.sharedInstance.encryptMessageWithPublicKey(toEncryptLB.text!) { (success, data, error) -> Void in
            if success {
                let b64encoded = data!.base64EncodedString(options: [])
                self.toDecryptLB.text = b64encoded
                self.toEncryptLB.text = ""
            } else {
                //SEND NOTIFICATION
            }
        }
    }
    
    
    @IBAction func DecryptBT(_ sender: UIButton) {
        guard let encryptedData = Data(base64Encoded: toDecryptLB.text!,options: []) else {
            //SEND NOTIFICATION
            return
        }
        //if toDencryptLB.text!.isEmpty {
        //SEND NOTIFICATION
        //}
        self.toEncryptLB.text = ""
        self.view.endEditing(true)
        AsymmetricCryptoManager.sharedInstance.decryptMessageWithPrivateKey(encryptedData) { (success, result, error) -> Void in
            if success {
                self.toEncryptLB.text = result!
                self.toDecryptLB.text = ""
            } else {
                //SEND NOTIFICATION
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var keyPairExists = AsymmetricCryptoManager.sharedInstance.keyPairExists();
    
}
