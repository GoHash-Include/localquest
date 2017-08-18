//
//  Login_VC.swift
//  Friends2Friends
//
//  Created by mbp13i5 on 03/08/17.
//  Copyright © 2017 GoHash. All rights reserved.
//

import UIKit

class Login_VC: UIViewController, UIScrollViewDelegate {
    
    var Object_Cls = SingleTone_Cls()
    var appdelegate = AppDelegate()
    var user_data = NSDictionary()
    
    var current_latt = String()
    var current_long = String()
    
    @IBOutlet weak var scrll_vw: UIScrollView!
    
    @IBOutlet weak var email_bck_Vw: UIView!
    @IBOutlet weak var passs_bck_vw: UIView!
    
    @IBOutlet weak var email_Tf: UITextField!
    @IBOutlet weak var pass_Tf: UITextField!
    @IBOutlet weak var popUp_vw: UIView!
    
    @IBOutlet weak var sign_in_btn: UIButton!
    
    @IBOutlet weak var signUp_btn: UIButton!
    @IBOutlet weak var activity_Ind: UIActivityIndicatorView!
    
    
    var activeField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let back_img   = UIImage(named: "top_back")!
        let back_Button   = UIBarButtonItem(image: back_img,  style: .plain, target: self, action: #selector(didTap_back_Button))
        navigationItem.leftBarButtonItem = back_Button
        navigationController?.navigationBar.tintColor = .white
        
        self.navigationItem.title = "Login"
        self.activity_Ind.hidesWhenStopped = true

        self.setuUp_UI()
    }
    
    func setuUp_UI()  {
        
        self.current_latt = self.user_data["lat"] as! String
        self.current_long = self.user_data["long"] as! String
        
        self.popUp_vw.layer.cornerRadius = 4
        self.popUp_vw.clipsToBounds = true
        
        self.email_bck_Vw.layer.borderColor = UIColor.lightGray.cgColor
        self.email_bck_Vw.layer.borderWidth = 1
        self.email_bck_Vw.layer.cornerRadius = 4
        self.email_bck_Vw.clipsToBounds = true
       
        self.passs_bck_vw.layer.borderColor = UIColor.lightGray.cgColor
        self.passs_bck_vw.layer.borderWidth = 1
        self.passs_bck_vw.layer.cornerRadius = 4
        self.passs_bck_vw.clipsToBounds = true
        
        self.sign_in_btn.layer.cornerRadius = 4
        self.sign_in_btn.clipsToBounds = true
        
    }
    func didTap_back_Button(sender: AnyObject){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.deregisterFromKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications()
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification)
    {
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrll_vw.isScrollEnabled = true
        let info : NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrll_vw.contentInset = contentInsets
        self.scrll_vw.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrll_vw.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
//        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
//        self.scrll_vw.contentInset = contentInset
        
                //Once keyboard disappears, restore original positions
                let info : NSDictionary = notification.userInfo! as NSDictionary
                let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
                let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
                self.scrll_vw.contentInset = contentInsets
                self.scrll_vw.scrollIndicatorInsets = contentInsets
                self.scrll_vw.isScrollEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func forgot_action_btn(_ sender: Any) {
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "pushTo_forgot_VC", sender: "login")
        }
    }
    
    func sample_method()  {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "dashboard") as! DashBoard_VC
        let navController = UINavigationController(rootViewController: nextViewController)
        self.present(navController, animated:true, completion: nil)
    }
    
    @IBAction func sign_in_action_btn(_ sender: Any) {
        
        self.sample_method()
        
        /*if self.current_latt.characters.count > 0 && self.current_long.characters.count > 0 {
            
        }else{
            self.appdelegate.show_alert_message(message: "Please Enable Loction Service For this App", vc: self)
            return
        }
    
        if (self.email_Tf.text?.characters.count)! > 0  {
            
            if (self.pass_Tf.text?.characters.count)! > 0 {
                
                let str = UserDefaults.standard.string(forKey: "DeviceToken")!
                print("deviceToken: \(str)")
                
                // userName,gcmID,password,latitude,longitude
                
                /*let user_dic = ["userName": self.email_Tf.text!,
                                "password": self.pass_Tf.text!,
                                "latitude": self.current_latt,
                                "longitude": self.current_long,
                                "gcmID": str] as NSDictionary
                
                print("login dic: \(user_dic)")*/
                
                let str_data = String(format: "userName=%@&password=%@&latitude=%@&longitude=%@&gcmID=%@", self.email_Tf.text!, self.pass_Tf.text!, current_latt, current_long, str)
                
                self.user_login_server_method(dic: str_data)
                
            }else{
                self.show_alert_with_msg(msg: "Please enter Password")
            }
        }else{
            self.show_alert_with_msg(msg: "Please enter UserName")
        }*/
    }
    
    func user_login_server_method(dic: String)  {
        
        self.activity_Ind.startAnimating()
        let str_url = String(format: "%@%@", My_Apis.base_url, My_Apis.login_api)
        self.Object_Cls.post_server_method(url: str_url, data: dic) {(result, sucess)-> Void in
            
            self.activity_Ind.stopAnimating()
            if sucess {
                
                print(result)
                
                if result["code"] as! String == "201" {
                    self.show_alert_with_msg(msg: result["message"] as! String)
                    return
                }else{
                    if result["status"] as! String == "SUCCESS" {
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "dashboard") as! DashBoard_VC
                        let navController = UINavigationController(rootViewController: nextViewController)
                        self.present(navController, animated:true, completion: nil)
                    }
                }
            }else{
                self.appdelegate.show_alert_message(message: "something wrong", vc: self)
            }// 8247886584
        }
    }
    
    func show_alert_with_msg(msg: String)  {
        
        appdelegate.show_alert_message(message: msg, vc: self)
    }
    
    @IBAction func signUp_action_btn(_ sender: Any) {
        
        if current_latt.characters.count > 0 && current_long.characters.count > 0 {
        }else{
            self.appdelegate.show_alert_message(message: "Please Enable Loction Service For this App", vc: self)
            return
        }
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Friends2Friends", message: "Please select register type", preferredStyle: .alert)
        let Customer_Action: UIAlertAction = UIAlertAction(title: "CUSTOMER", style: .default) { action -> Void in
            //Just dismiss the action sheet
            
            self.make_call_with_selected_string(register: "CUSTOMER", lattitude: self.current_latt, longitude: self.current_long)
        }
        
        let Service_Action: UIAlertAction = UIAlertAction(title: "SERVICE PROVIDER", style: .default) { action -> Void in
            //Just dismiss the action sheet
            
            self.make_call_with_selected_string(register: "SERVICE PROVIDER", lattitude: self.current_latt, longitude: self.current_long)
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(Customer_Action)
        actionSheetController.addAction(Service_Action)
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    func make_call_with_selected_string(register: String, lattitude: String, longitude: String)  {
        
        let dic = ["lat": lattitude,
                   "long": longitude,
                   "register_type": register] as NSDictionary
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "pushTo_signup_frm_login", sender: dic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "pushTo_signup_frm_login" {
            
            let this_vc = segue.destination as? SignUp_VC
            this_vc?.user_data = (sender as! NSDictionary)
        }
        if segue.identifier == "pushTo_forgot_VC" {
            
            let this_vc = segue.destination as! Forgot_VC
            this_vc.from_where = (sender as! String)
        }
    }
}

extension Login_VC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        activeField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
      //  self.scrll_vw.isScrollEnabled = true
        return true
    }
}

extension Login_VC  {
    
    func showAlertMessage(messageStr:String) {
        let actionSheetController: UIAlertController = UIAlertController(title: "My Mech", message: messageStr, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }
}
