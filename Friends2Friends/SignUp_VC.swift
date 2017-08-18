
//
//  SignUp_VC.swift
//  Friends2Friends
//
//  Created by mbp13i5 on 03/08/17.
//  Copyright © 2017 GoHash. All rights reserved.
//

import UIKit

class SignUp_VC: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var scrll_vw: UIScrollView!
    
    @IBOutlet weak var popUp_vw: UIView!
    
    @IBOutlet weak var adjust_top_postion_vw: NSLayoutConstraint!
    
    @IBOutlet weak var shop_nm_bck_vw: UIView!
    @IBOutlet weak var shop_nm_Tf: UITextField!
    
    
    @IBOutlet weak var first_nm_bck_vw: UIView!
    @IBOutlet weak var last_nm_bck_vw: UIView!
    @IBOutlet weak var user_nm_bck_vw: UIView!
    @IBOutlet weak var email_bck_vw: UIView!
    @IBOutlet weak var ph_bck_vw: UIView!
    @IBOutlet weak var pass_bck_vw: UIView!
    @IBOutlet weak var cnfrm_pass_bck_vw: UIView!
    
    @IBOutlet weak var frist_nm_Tf: UITextField!
    @IBOutlet weak var last_nm_Tf: UITextField!
    @IBOutlet weak var user_nm_Tf: UITextField!
    @IBOutlet weak var email_Tf: UITextField!
    @IBOutlet weak var mobile_Tf: UITextField!
    @IBOutlet weak var pass_Tf: UITextField!
    @IBOutlet weak var cnfrm_pass_Tf: UITextField!
    
    
    @IBOutlet weak var male_btn: UIButton!
    @IBOutlet weak var female_btn: UIButton!
    
    @IBOutlet weak var terms_condition_bt: UIButton!
    
    @IBOutlet weak var sign_in_btn: UIButton!
    
    @IBOutlet weak var sign_up_btn: UIButton!
    
    @IBOutlet weak var terms_conditons_btn: UIButton!
    
    @IBOutlet weak var activity_Ind: UIActivityIndicatorView!
    
    
    var Object_Cls = SingleTone_Cls()
    var appdelegate = AppDelegate()
    var user_data = NSDictionary()
    var customer_type = String()
    
    
    var current_latt = String()
    var current_long = String()
    
    var activeField: UITextField?
    var gender_str = String()
    var terms_and_cndtns_bool:Bool = false
    
    let yourAttributes : [String: Any] = [
        NSFontAttributeName : UIFont.systemFont(ofSize: 13),
        NSForegroundColorAttributeName : UIColor.black,
        NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue]
    //.styleDouble.rawValue, .styleThick.rawValue, .styleNone.rawValue
    
    @IBOutlet weak var back_vw: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let back_img   = UIImage(named: "top_back")!
        let back_Button   = UIBarButtonItem(image: back_img,  style: .plain, target: self, action: #selector(didTap_back_Button))
        navigationItem.leftBarButtonItem = back_Button
        navigationController?.navigationBar.tintColor = .white
        
        self.navigationItem.title = "Sign Up"
        self.activity_Ind.hidesWhenStopped = true
        
        setUp_UI()
    }
    
    func setUp_UI()  {
        
        self.current_latt = self.user_data["lat"] as! String
        self.current_long = self.user_data["long"] as! String
        
        self.popUp_vw.layer.cornerRadius = 4
        self.popUp_vw.clipsToBounds = true
        
        if self.user_data["register_type"] as! String == "CUSTOMER" {
            
            self.adjust_top_postion_vw.constant = 135
            self.shop_nm_bck_vw.isHidden = true
            self.customer_type = "CUSTOMER"
            
        }else if self.user_data["register_type"] as! String == "SERVICE PROVIDER" {
            
            self.adjust_top_postion_vw.constant = 190
            self.shop_nm_bck_vw.isHidden = false
            self.customer_type = "SERVICE PROVIDER"
        }
        
        self.shop_nm_bck_vw.layer.borderColor = UIColor.lightGray.cgColor
        self.shop_nm_bck_vw.layer.borderWidth = 1
        self.shop_nm_bck_vw.layer.cornerRadius = 4
        self.shop_nm_bck_vw.clipsToBounds = true
        
        self.first_nm_bck_vw.layer.borderColor = UIColor.lightGray.cgColor
        self.first_nm_bck_vw.layer.borderWidth = 1
        self.first_nm_bck_vw.layer.cornerRadius = 4
        self.first_nm_bck_vw.clipsToBounds = true
        
        self.last_nm_bck_vw.layer.borderColor = UIColor.lightGray.cgColor
        self.last_nm_bck_vw.layer.borderWidth = 1
        self.last_nm_bck_vw.layer.cornerRadius = 4
        self.last_nm_bck_vw.clipsToBounds = true
        
        self.user_nm_bck_vw.layer.borderColor = UIColor.lightGray.cgColor
        self.user_nm_bck_vw.layer.borderWidth = 1
        self.user_nm_bck_vw.layer.cornerRadius = 4
        self.user_nm_bck_vw.clipsToBounds = true
        
        self.email_bck_vw.layer.borderColor = UIColor.lightGray.cgColor
        self.email_bck_vw.layer.borderWidth = 1
        self.email_bck_vw.layer.cornerRadius = 4
        self.email_bck_vw.clipsToBounds = true
        
        self.ph_bck_vw.layer.borderColor = UIColor.lightGray.cgColor
        self.ph_bck_vw.layer.borderWidth = 1
        self.ph_bck_vw.layer.cornerRadius = 4
        self.ph_bck_vw.clipsToBounds = true
        
        self.pass_bck_vw.layer.borderColor = UIColor.lightGray.cgColor
        self.pass_bck_vw.layer.borderWidth = 1
        self.pass_bck_vw.layer.cornerRadius = 4
        self.pass_bck_vw.clipsToBounds = true
        
        self.cnfrm_pass_bck_vw.layer.borderColor = UIColor.lightGray.cgColor
        self.cnfrm_pass_bck_vw.layer.borderWidth = 1
        self.cnfrm_pass_bck_vw.layer.cornerRadius = 4
        self.cnfrm_pass_bck_vw.clipsToBounds = true
        
        let image = UIImage(named: "radio_fill_new")
        self.male_btn.setImage(image, for: .normal)
        self.gender_str = "male"
        
        self.sign_up_btn.layer.cornerRadius = 4
        self.sign_up_btn.clipsToBounds = true
        
        let attributeString = NSMutableAttributedString(string: "By logging in or registering you agree with Friends2Friends Terms & Conditions", attributes: yourAttributes)
        terms_conditons_btn.setAttributedTitle(attributeString, for: .normal)
    }
    
    func didTap_back_Button(sender: AnyObject){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    @IBAction func terms_conditions_action_btn(_ sender: Any) {
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.registerForKeyboardNotifications()
        scrll_vw.contentSize = CGSize(width: view.frame.size.width, height: 1000)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.deregisterFromKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrll_vw.isScrollEnabled = true
        scrll_vw.contentSize = CGSize(width: view.frame.size.width, height: 1000)
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
                self.scrll_vw.isScrollEnabled = true
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        let contentInsets:UIEdgeInsets = UIEdgeInsets.zero
        self.scrll_vw.contentInset = contentInsets
        self.scrll_vw.scrollIndicatorInsets = contentInsets
        self.scrll_vw.isScrollEnabled = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
        scrll_vw.contentSize = CGSize(width: view.frame.size.width, height: 1000)
    }
    
    
    @IBAction func male_action_btn(_ sender: Any) {
        
        let un_image = UIImage(named: "radio_unfill")
        self.female_btn.setImage(un_image, for: .normal)
        
        let image = UIImage(named: "radio_fill_new")
        self.male_btn.setImage(image, for: .normal)
        self.gender_str = "male"
    }
    
    @IBAction func female_action_btn(_ sender: Any) {
        
        let un_image = UIImage(named: "radio_unfill")
        self.male_btn.setImage(un_image, for: .normal)
        
        let image = UIImage(named: "radio_fill_new")
        self.female_btn.setImage(image, for: .normal)
        self.gender_str = "female"
    }
    
    @IBAction func terms_and_condition_action_btn(_ sender: Any) {
        
        if terms_and_cndtns_bool {
            
            let image = UIImage(named: "Unchecked Checkbox")
            self.terms_condition_bt.setImage(image, for: .normal)
            
            terms_and_cndtns_bool = false
        }else{
            
            let image = UIImage(named: "Checked Checkbox")
            self.terms_condition_bt.setImage(image, for: .normal)
            
            terms_and_cndtns_bool = true
        }
    }
    
    @IBAction func sign_in_action_btn(_ sender: Any) {
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "pushTo_login_frm_signup", sender: nil)
        }
    }
    
    @IBAction func sign_up_action_btn(_ sender: Any) {
        
       /* if (self.frist_nm_Tf.text?.characters.count)! > 0 || (self.last_nm_Tf.text?.characters.count)! > 0  {
            
            if (self.user_nm_Tf.text?.characters.count)! > 0 {
                
                if (self.email_Tf.text?.characters.count)! > 0 && (self.mobile_Tf.text?.characters.count)! > 9  {
                    
                    if (self.pass_Tf.text?.characters.count)! > 0 && (self.cnfrm_pass_Tf.text?.characters.count)! > 0 {
                        
                        if (self.terms_condition_bt.currentImage?.isEqual(UIImage(named: "Checked Checkbox")))! {
                            
                            if !self.isValidEmail(testStr: self.email_Tf.text!) {
                                self.show_alert_with_msg(msg: "You entered E-mail is not valid, Please check!")
                                return
                            }
                            
                            if self.pass_Tf.text != self.cnfrm_pass_Tf.text {
                                self.show_alert_with_msg(msg: "Your entered password & Confirm password does't match, please check!")
                                return
                            }
                            
                                let str = UserDefaults.standard.value(forKey: "DeviceToken") as! String
                            print("deviceToken: \(str)")
                            
                            var gender = String()
                            if self.gender_str == "male" {
                                gender = "1"
                            }else{
                                gender = "2"
                            }
        
                            // role_id, services_ids, firstName, gcmID, lastName,userName,password,email,gender,mobileNumber,confirm_password, lati,longi,shop_name &shop_name=%@
                            
                            if self.customer_type == "CUSTOMER" {
                                
                                let str_data = String(format: "role_id=%@&firstName=%@&lastName=%@&userName=%@&email=%@&mobileNumber=%@&password=%@&confirm_password=%@&gender=%@&gcmID=%@&lati=%@&longi=%@", "1", self.frist_nm_Tf.text!, self.last_nm_Tf.text!, self.user_nm_Tf.text!, self.email_Tf.text!, self.mobile_Tf.text!, self.pass_Tf.text!, self.cnfrm_pass_Tf.text!, gender, str, current_latt, current_long)
                                
                                self.user_register_server_method(dic: str_data)
                            }else{*/
                                
                                DispatchQueue.main.async {
                                    self.performSegue(withIdentifier: "show_services_vc", sender: nil)
                                }
                            /*}
                            
                        }else{
                            self.show_alert_with_msg(msg: "Please check the Terms & Conditions")
                        }
                    }else{
                        self.show_alert_with_msg(msg: "Please fill Password & Confirm Password")
                    }
                }else{
                    self.show_alert_with_msg(msg: "Please fill Email & Mobile")
                }
            }else{
                self.show_alert_with_msg(msg: "Please fill UserName")
            }
        }else{
            self.show_alert_with_msg(msg: "Please fill the frist name and last name")
        }*/
    }
    
    func user_register_server_method(dic: String)  {
        
        self.activity_Ind.startAnimating()
        let str_url = String(format: "%@%@", My_Apis.base_url, My_Apis.register_api)
        self.Object_Cls.post_server_method(url: str_url, data: dic) {(result, sucess)-> Void in
            
            self.activity_Ind.stopAnimating()
            if sucess {
                
                print(result)
                
                if result["code"] as! String == "201" {
                    self.show_alert_with_msg(msg: result["message"] as! String)
                    return
                }else{
                    if result["status"] as! String == "SUCCESS" {
                        self.performSegue(withIdentifier: "show_forgot_vc", sender: "signup")
                    }
                }
            }else{
                self.appdelegate.show_alert_message(message: "something wrong", vc: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "show_forgot_vc" {
            
            let this_vc = segue.destination as! Forgot_VC
            this_vc.from_where = (sender as! String)
        }
    }
    
    func show_alert_with_msg(msg: String)  {
    
        appdelegate.show_alert_message(message: msg, vc: self)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

}

extension SignUp_VC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
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


//func get_car_full_service_list()  {
//
//    self.actvtyInd_vw.startAnimating()
//    DispatchQueue.global(qos: .background).async {
//
//        self.Object_Cls.makeGet_ServiceRequest(url: MyVariables.car_full_service_api) {(result)-> Void in
//
//            self.actvtyInd_vw.stopAnimating()
//            let output_data:NSArray = (result["data"] as? NSArray)!
//
//            if output_data.count > 0 {
//
//                for i in 0..<output_data.count {
//
//                    print("print: \(output_data[i])")
//
//                    let dic = output_data[i] as? NSDictionary
//                    self.full_service_section_ary.append(dic!)
//                }
//            }
//        }
//    }
//}
