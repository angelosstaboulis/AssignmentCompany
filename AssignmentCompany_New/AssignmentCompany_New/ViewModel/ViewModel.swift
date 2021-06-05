//
//  ViewModel.swift
//  AssignmentCompany_New
//
//  Created by Angelos Staboulis on 5/6/21.
//

import Foundation
class ViewModel{
    var apishared:APIManager
    var cities:[LocationModel]=[]
    init(){
        apishared = APIManager.shared
    }
    func fetchLocation(input:String,completion:@escaping ([LocationModel])->()){
        apishared.fetchLocations(input: input) { (array) in
            self.cities.append(contentsOf: array)
            completion(self.cities)
        }
        
    }
}
