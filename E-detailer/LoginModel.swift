//
//  LoginModel.swift
//  E-detailer
//
//  Created by Ammad on 8/10/18.
//  Copyright © 2018 Ammad. All rights reserved.
//
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseWelcome { response in
//     if let welcome = response.result.value {
//       ...
//     }
//   }

import Foundation
import ObjectMapper

struct LoginModel : Mappable {
    var success : Bool?
    var error : String?
    var result : Result?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        success <- map["Success"]
        error <- map["Error"]
        result <- map["Result"]
    }
    
}


struct Result : Mappable {
    var team_id : String?
    var emp_id : String?
    var emp_name : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        team_id <- map["team_id"]
        emp_id <- map["emp_id"]
        emp_name <- map["emp_name"]
    }
    
}
