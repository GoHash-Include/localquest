//
//  DashBoard_VC.swift
//  Friends2Friends
//
//  Created by Shashank Aribandi on 16/08/17.
//  Copyright © 2017 GoHash. All rights reserved.
//

import UIKit

class DashBoard_VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = ""
        self.style()
    }
    
    func style() {
        
        let color: UIColor = UIColor(red: 56 / 255, green: 61 / 255, blue: 91 / 255, alpha: 1)
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.barTintColor = color
        self.navigationController!.navigationBar.barStyle = .blackTranslucent
        
        let first_img   = UIImage(named: "ic_action_follow")!
        let secnd_img = UIImage(named: "ic_action_feedback")!
        let thrid_img   = UIImage(named: "ic_action_notification")!
        let four_img = UIImage(named: "ic_action_order")!
        
        let button:UIButton = UIButton(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        button.backgroundColor = .clear
        button.setImage(first_img, for: .normal)
        button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        
        let button2:UIButton = UIButton(frame: CGRect(x: 50, y: 10, width: 30, height: 30))
        button2.backgroundColor = .clear
        button2.setImage(secnd_img, for: .normal)
        button2.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        
        let button3:UIButton = UIButton(frame: CGRect(x: 90, y: 10, width: 30, height: 30))
        button3.backgroundColor = .clear
        button3.setImage(thrid_img, for: .normal)
        button3.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        
        let button4:UIButton = UIButton(frame: CGRect(x: 130, y: 10, width: 30, height: 30))
        button4.backgroundColor = .clear
        button4.setImage(four_img, for: .normal)
        button4.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        
        let frist_Button = UIBarButtonItem(customView: button)
        let secnd_Button = UIBarButtonItem(customView: button2)
        let third_Button = UIBarButtonItem(customView: button3)
        let four_Button  = UIBarButtonItem(customView: button4)
        
        navigationItem.rightBarButtonItems = [frist_Button,secnd_Button, third_Button, four_Button]
        
        let view_width:Int = Int(self.view.layer.frame.size.width)
        let width = view_width/3
        
    }
    
    func buttonClicked() {
        print("Button Clicked")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func show_login(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
