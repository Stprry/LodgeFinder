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
    let API_KEY = "AIzaSyCI6sXu2GiN9fAKDD5PVeFxweGQG79QMKE" // change to your api key

    init(lat:String,long:String) {
        let resourceString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(long)&radius=1000&type=lodging&keyword=surf&key=\(API_KEY)"
        
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
            }catch{
                completion(.failure(.canNotProcessData))
            }
            
        }
        dataTask.resume()
    }
}

