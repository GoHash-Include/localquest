//
//  ViewController.swift
//  Friends2Friends
//
//  Created by mbp13i5 on 03/08/17.
//  Copyright © 2017 GoHash. All rights reserved.
//

import UIKit
import CoreLocation


// 56, 61, 91 login background colour

   //  5103 7201 2012 9992 03/22 cvv 785

struct ScreenSize { // Answer to OP's question
    
    static let IPHONE_5        = UIScreen.main.bounds.size.height == 568
    static let IPHONE_4        = UIScreen.main.bounds.size.height == 480
}

class ViewController: UIViewController {
    
    var Object_Cls = SingleTone_Cls()
    var appdelegate = AppDelegate()
    var destinationCoordinate = CLLocationCoordinate2D()
    var locationManager = CLLocationManager()
    var geoCoder = CLGeocoder()
    
    var current_latt = String()
    var current_long = String()
    
    
    @IBOutlet weak var signup_btn: UIButton!
    
    @IBOutlet weak var login_btn: UIButton!
    
    @IBOutlet weak var logo_img: UIImageView!
    @IBOutlet weak var title_lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUp_UI()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
    }
    
    func setUp_UI()  {
        
        self.signup_btn.layer.cornerRadius = 4
        self.signup_btn.clipsToBounds = true
        
        self.login_btn.layer.cornerRadius = 4
        self.login_btn.clipsToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        
        if ScreenSize.IPHONE_5 || ScreenSize.IPHONE_4 {
            self.logo_img.frame =  CGRect(x: (self.view.frame.size.width/2-45), y: 60, width: 90, height: 90)
            self.title_lbl.frame =  CGRect(x: (self.view.frame.size.width/2-130), y: 160, width: 260, height: 30)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signup_action_btn(_ sender: Any) {
        
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
            self.performSegue(withIdentifier: "pushTo_signUP", sender: dic)
        }
    }
    
    @IBAction func login_action_btn(_ sender: Any) {
        
       /* if current_latt.characters.count > 0 && current_long.characters.count > 0 {
            
        }else{
            self.appdelegate.show_alert_message(message: "Please Enable Loction Service For this App", vc: self)
            return
        }*/
        
        let dic = ["lat": current_latt,
                   "long": current_long ] as NSDictionary
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "pushTo_Login_VC", sender: dic)
        }
    }
    
    func get_car_full_service_list()  {
        
        let str_url = String(format: "%@%@", My_Apis.base_url, My_Apis.get_services)
        self.Object_Cls.makeGet_ServiceRequest(url: str_url) {(result, sucess)-> Void in
            
            if sucess {
                
             //   print(result)
                print(result["status"] as! String)
                print(result["data"] as! NSArray)
                
            }else{
                self.appdelegate.show_alert_message(message: "something wrong", vc: self)
            } // firstName,userName,lastName,email,mobileNumber,password,confirm_password,gender,gcmID, latitude, longitude
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "pushTo_signUP" {
            
            let this_vc = segue.destination as? SignUp_VC
            this_vc?.user_data = (sender as! NSDictionary)
        }
        if segue.identifier == "pushTo_Login_VC" {
            
            let this_vc = segue.destination as? Login_VC
            this_vc?.user_data = (sender as! NSDictionary)
        }
    }
    
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
            break
        case .authorizedAlways:
            manager.startUpdatingLocation()
            break
        case .restricted:
            self.appdelegate.show_alert_message(message: "Please Enable Loction Service For this App", vc: self)
            break
        case .denied:
            self.appdelegate.show_alert_message(message: "Please Enable Loction Service For this App", vc: self)
            break
        }
    }
    
    //Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        geoCoder.reverseGeocodeLocation(location!, completionHandler: { (placemarks, error) -> Void in
            
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                
                // Place details
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                
                // Address dictionary
                print(placeMark.addressDictionary ?? [String: AnyObject](), terminator: "")
                
                var address_str = String()
                if placeMark.addressDictionary!["Name"] != nil {
                    address_str.append(String(format: "%@", placeMark.addressDictionary!["Name"] as! String))
                }else{
                    
                    if placeMark.addressDictionary!["Thoroughfare"] != nil {
                        address_str.append(String(format: ", %@", placeMark.addressDictionary!["Thoroughfare"] as! String))
                    }
                }
                
                if placeMark.addressDictionary!["SubLocality"] != nil {
                    address_str.append(String(format: ", %@", placeMark.addressDictionary!["SubLocality"] as! String))
                }
                
                if placeMark.addressDictionary!["City"] != nil {
                    address_str.append(String(format: ", %@", placeMark.addressDictionary!["City"] as! String))
                }
                
                if placeMark.addressDictionary!["ZIP"] != nil {
                    address_str.append(String(format: ", %@", placeMark.addressDictionary!["ZIP"] as! String))
                }
                
                if placeMark.addressDictionary!["Country"] != nil {
                    address_str.append(String(format: ", %@", placeMark.addressDictionary!["Country"] as! String))
                }
                
                print("User current Location: \(address_str)")
                
                self.current_latt = String(format: "%lu", (location?.coordinate.latitude)!)
                self.current_long = String(format: "%lu", (location?.coordinate.longitude)!)
                
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
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
