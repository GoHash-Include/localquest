//
//  Forgot_VC.swift
//  Friends2Friends
//
//  Created by mbp13i5 on 03/08/17.
//  Copyright © 2017 GoHash. All rights reserved.
//

import UIKit

class Forgot_VC: UIViewController {
    
    var Object_Cls = SingleTone_Cls()
    var appdelegate = AppDelegate()
    var from_where = String()
    
    
    @IBOutlet weak var scrll_vw: UIScrollView!
    
    @IBOutlet weak var popup_vw: UIView!
    
    @IBOutlet weak var mobile_Tf: UITextField!
    
    @IBOutlet weak var ok_btn: UIButton!
    
    @IBOutlet weak var mobile_bck_vw: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let back_img   = UIImage(named: "top_back")!
        let back_Button   = UIBarButtonItem(image: back_img,  style: .plain, target: self, action: #selector(didTap_back_Button))
        navigationItem.leftBarButtonItem = back_Button
        navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = "Forgot"

        setUp_UI()
    }
    
    func setUp_UI()  {
        
        self.popup_vw.layer.cornerRadius = 4
        self.popup_vw.clipsToBounds = true
        
        if self.from_where == "login" {
            
            mobile_Tf.placeholder = "Mobile Number"
        }else{
            mobile_Tf.placeholder = "Enter OTP"
        }
        
        self.mobile_bck_vw.layer.borderColor = UIColor.lightGray.cgColor
        self.mobile_bck_vw.layer.borderWidth = 1
        self.mobile_bck_vw.layer.cornerRadius = 4
        self.mobile_bck_vw.clipsToBounds = true
        
        self.ok_btn.layer.cornerRadius = 4
        self.ok_btn.clipsToBounds = true
    }
    
    func didTap_back_Button(sender: AnyObject){
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        doneWithKeyPad()
    }
    
    func doneWithKeyPad() {
        view.endEditing(true)
        // [_txtMobiuleNumber resignFirstResponder];
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            self.scrll_vw.contentOffset = CGPoint(x: 0, y: 0)
        })
    }
    
    @IBAction func ok_action_btn(_ sender: Any) {
        
    } //  dashboard
}

extension Forgot_VC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            
            if ScreenSize.IPHONE_5 {
                self.scrll_vw.contentOffset = CGPoint(x: 0, y: 145)
            }else{
                self.scrll_vw.contentOffset = CGPoint(x: 0, y: 100)
            }
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            self.scrll_vw.contentOffset = CGPoint(x: 0, y: 0)
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        //  self.scrll_vw.isScrollEnabled = true
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            self.scrll_vw.contentOffset = CGPoint(x: 0, y: 0)
        })
        return true
    }
}


// username = ravi
// pass = ravi
