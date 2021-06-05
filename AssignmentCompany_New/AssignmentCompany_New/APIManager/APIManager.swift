//
//  APIManager.swift
//  AssignmentCompany_New
//
//  Created by Angelos Staboulis on 5/6/21.
//

import Foundation
import Alamofire
import SwiftyJSON
class APIManager{
    static let shared = APIManager()
    private init(){}
    var cities:[LocationModel]=[]
    func fetchLocations(input:String,completion:@escaping ([LocationModel])->()){
        let urlMain = URL(string: "https://xegr-geography.herokuapp.com/places/autocomplete?input="+input)
        let request = URLRequest(url: urlMain!)
        AF.request(request)
            .responseJSON { (data) in
                let json = JSON(data.value!)
                for item in 0..<json.count {
                    let locationModel = LocationModel(secondaryText: json[item]["secondaryText"].stringValue, mainText: json[item]["mainText"].stringValue, placeId: json[item]["placeId"].stringValue)
                        self.cities.append(locationModel)
                   
                }
               
                completion(self.cities)
            }
       
    }
}
