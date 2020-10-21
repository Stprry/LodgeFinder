//
//  LodgeRequest.swift
//  SurflineCodingTest
//
//  Created by Sam Perry on 12/10/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import Foundation
enum LodgeError:Error {
    case noDataAvailible
    case canNotProcessData
}
struct LodgeRequest {
    let resourceURL:URL
    let API_KEY = "" // MARK:-- change to your api key

    init(lat:String,long:String) {
        let resourceString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(long)&radius=1000&type=lodging&keyword=surf&key=\(API_KEY)"
//        let resourceString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=50.4164582,-5.100202299999978&radius=1000&type=surfing&keyword=lodge&key=AIzaSyBOxY1PjMtlbaXI7yLzw3PP79NVM50UUeg"//MARK:-- ADD API KEY
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    
    func getLodges(completion: @escaping(Result<[LodgeDetail],LodgeError>)-> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL){data,_,_ in
            guard let jsonData = data else
            {
                completion(.failure(.noDataAvailible))
                return
            }
            do{
                let decoder = JSONDecoder()
                let lodgeResponse  = try decoder.decode(LodgeResponse.self, from: jsonData)
                let lodgeDetails = lodgeResponse.results
                completion(.success(lodgeDetails!))// might break it check this
                print(lodgeDetails!)
            }catch{
                completion(.failure(.canNotProcessData))
            }
            
        }
        dataTask.resume()
    }
}

