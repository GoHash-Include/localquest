//
//  Services_VC.swift
//  Friends2Friends
//
//  Created by mbp13i5 on 18/08/17.
//  Copyright © 2017 GoHash. All rights reserved.
//

import UIKit

struct Categories {
    
    var name = String()
    var descriptin = String()
    var id = String()
    var image_url = String()
}

struct Sub_categories {
    
    var name = String()
    var description = String()
    var image_url = String()
    var id = Int()
    var parent_id = Int()
}

class Services_VC: UIViewController {
    
    @IBOutlet weak var table_vw: UITableView!
    @IBOutlet weak var sign_up_btn: UIButton!
    @IBOutlet weak var activity_Ind: UIActivityIndicatorView!
    
    var singleTone_cls = SingleTone_Cls()
    var appdelegate = AppDelegate()
    
    var arrSelectedSectionIndex = [Int]()
    var services_ctgrs_data = [Categories]()
    var services_sub_ctgrs_data = [Sub_categories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let back_img   = UIImage(named: "top_back")!
        let back_Button   = UIBarButtonItem(image: back_img,  style: .plain, target: self, action: #selector(didTap_back_Button))
        navigationItem.leftBarButtonItem = back_Button
        navigationController?.navigationBar.tintColor = .white
        
        self.navigationItem.title = "Services"
        self.activity_Ind.hidesWhenStopped = true
        
        self.table_vw.tableFooterView = UIView.init()
        self.table_vw.isHidden = true
        
        self.setup_UI()
        self.get_services_list()
    }
    
    func setup_UI()  {
        
        self.sign_up_btn.layer.cornerRadius = 4
        self.sign_up_btn.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didTap_back_Button(sender: AnyObject){
        self.navigationController?.popViewController(animated: true)
    }
    
    func get_services_list()  {
    
        self.activity_Ind.startAnimating()
        DispatchQueue.global(qos: .background).async {
    
            let url_str = String(format: "%@%@", My_Apis.base_url, My_Apis.get_services)
            self.singleTone_cls.makeGet_ServiceRequest(url: url_str) {(result, sucess)-> Void in
    
                self.activity_Ind.stopAnimating()
                if sucess {
                
                    print(result)
                    let output_data:NSArray = (result["data"] as? NSArray)!
                    
                    if output_data.count > 0 {
                        
                        for i in 0..<output_data.count {
                            
                            print("print: \(output_data[i])")
                            
                            let dic = output_data[i] as! NSDictionary
                            let get_ctgry = dic["Category"] as! NSDictionary
                            
                            var categories = Categories()
                            categories.name = get_ctgry["name"] as! String
                            categories.id = get_ctgry["id"] as! String
                            categories.image_url = get_ctgry["icon"] as! String
                            if (get_ctgry["description"] as? String) != nil {
                                categories.descriptin = get_ctgry["description"] as! String
                            }else{
                                categories.descriptin = ""
                            }
                            
                            self.services_ctgrs_data.append(categories)
                            
                     //       let get_sub_ctgry = dic["Subcategory"] as! NSArray
                        }
                        
                        if self.services_ctgrs_data.count > 0 {
                            
                            self.table_vw.isHidden = false
                            self.table_vw.reloadData()
                        }else{
                            self.table_vw.isHidden = true
                        }
                    }
                }else{
                    self.appdelegate.show_alert_message(message: "something wrong, please try again.", vc: self)
                }
                
            }
        }
    }
    
    @IBAction func signup_action_btn(_ sender: Any) {
        
        
//        {
//            Category =             {
//                "created_at" = "2017-08-18 11:13:03";
//                description = Capacitors;
//                "home_delivery" = 1;
//                icon = ;
//                id = 53;
//                name = Capacitors;
//                "parent_id" = 0;
//                status = 1;
//                "updated_at" = "2017-08-18 11:13:03";
//            };
//            Subcategory =             (
//            );
//        }
        
    }

}

extension Services_VC : UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.services_ctgrs_data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        print("sectin: \(Int(section))")
        
        let headerView = self.table_vw.dequeueReusableCell(withIdentifier: "service_header_row") as? Services_Custom_Cell
        
        let categoires_data = self.services_ctgrs_data[section]
        headerView?.title_lbl.text = categoires_data.name
        headerView?.sub_title_lbl.text = categoires_data.descriptin
        
        headerView?.icon_img.layer.cornerRadius = (headerView?.icon_img.layer.frame.size.width)!/2
        headerView?.icon_img.clipsToBounds = true
        
        if categoires_data.image_url.characters.count > 0 {
            
            URLSession.shared.dataTask(with: NSURL(string: categoires_data.image_url)! as URL, completionHandler: { (data, response, error) -> Void in
                
                if error != nil {
                    DispatchQueue.main.async(execute: { () -> Void in
                        headerView?.icon_img.image = UIImage(named: "ic_demo_profile")
                    })
                }else{
                    DispatchQueue.main.async(execute: { () -> Void in
                        let image = UIImage(data: data!)
                        headerView?.icon_img.image = image
                    })
                }
            }).resume()
        }
        
        if (headerView?.icon_img.image == nil){
            headerView?.icon_img.image = UIImage(named: "ic_demo_profile")
        }
        
        
        if arrSelectedSectionIndex.contains(Int(section)) {
            headerView?.header_btn?.isSelected = true
            
            UIView.animate(withDuration: 2.0, animations: {
                headerView?.action_on_off_img.image = UIImage(named: "ic_action_on")
            })
        }else{
            UIView.animate(withDuration: 2.0, animations: {
                headerView?.action_on_off_img.image = UIImage(named: "ic_action_off")
            })
        }
        headerView?.header_btn?.tag = section
        headerView?.header_btn?.addTarget(self, action: #selector(self.btnTapShowHideSection), for: .touchUpInside)
        
        return headerView?.contentView
    }
    
    @IBAction func btnTapShowHideSection(_ sender: UIButton) {
        
        if !sender.isSelected {
            arrSelectedSectionIndex.append(Int(sender.tag))
            sender.isSelected = true
        }else {
            sender.isSelected = false
            if arrSelectedSectionIndex.contains(Int(sender.tag)) {
                arrSelectedSectionIndex.remove(at: arrSelectedSectionIndex.index(of: Int(sender.tag))!)
            }
        }
        self.table_vw.reloadSections(IndexSet(integer: sender.tag), with: .fade)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ///reload this section
        self.table_vw.reloadData()
    }
}


extension Services_VC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 83
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.arrSelectedSectionIndex.contains(section) {
            return 2
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let CellIdentifier: String = "service_sub_row"
        let cell_menu = self.table_vw.dequeueReusableCell(withIdentifier: CellIdentifier) as? Services_Custom_Cell
    
        cell_menu?.sub_row_lbl.text = "sample"
        cell_menu?.selectionStyle = .none
        
        return cell_menu!
    }
}
