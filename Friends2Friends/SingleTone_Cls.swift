//
//  SingleTone_Cls.swift
//  Friends2Friends
//
//  Created by mbp13i5 on 04/08/17.
//  Copyright © 2017 GoHash. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SystemConfiguration

class SingleTone_Cls: NSObject {
    
    var afManager : SessionManager!
    
    func makeGet_ServiceRequest(url: String, completion: @escaping (_ result: NSDictionary, _ sucess: Bool) -> Void){
        
        print("url: \(url)")
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15 //Set timeouts in sec
        configuration.timeoutIntervalForResource = 15
        
        afManager =  Alamofire.SessionManager(configuration:configuration)
        afManager.request(url).responseJSON { (response:DataResponse<Any>) in
            
            print(response)
            let statusCode = response.response?.statusCode
            
            if statusCode == 200 {
                
                if response.result.value != nil{
                    
                    let response = response.result.value as! NSDictionary
                    //      print(response)
                    
                    completion({ return response }(), true)
                }
                
            }else{
                let response = ["msg": "Some thing wrong"] as NSDictionary
                completion({ return response }(), true)
            }
        }
    }
    
    func post_server_method(url: String, data: String, completion: @escaping (_ result: [String: AnyObject], _ success: Bool) -> Void ) {
        
        let main_data = "\(url)?\(data)"
        print("url: \(main_data)")
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15 //Set timeouts in sec
        configuration.timeoutIntervalForResource = 15
        
        afManager =  Alamofire.SessionManager(configuration:configuration)
        afManager.request(main_data, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json; charset=UTF-8"]).responseJSON { (response:DataResponse<Any>) in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // URL response
            print(response.result.value as Any)
            let statusCode = response.response?.statusCode
            
            //       let dataString = String(data: response.data!, encoding: .utf8)
            //   print("print: \(String(describing: dataString))")
            
            if statusCode == 200 {
                
                do{
                    let json = try JSONSerialization.jsonObject(with: response.data!, options:.allowFragments) as! [String : AnyObject]
                    print("data:\(json)")
                    
                    completion({return json}(), true)
                } catch {
                    print("Something went wrong")
                }
            }else{
                
                print("Something went wrong: \(response.result.isFailure)")
                let dic = ["msg": "Some thing wrong"]
                completion({return dic}() as [String : AnyObject], false)
            }
        }
    }
    

}

/*
switch(response.result) {
case .success(_):
    if response.result.value != nil{
        //    print(response.result.value!)
        
        let response = response.result.value as! NSDictionary
        //      print(response)
        
        completion({ return response }(), true)
    }
    break
    
case .failure(_):
    print(response.result.error!)
    break
}*/
