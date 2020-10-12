//
//  LodgeRequest.swift
//  SurflineCodingTest
//
//  Created by Sam Perry on 12/10/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import Foundation
enum LodgeError:Error {
    case noDataAvailable
    case canNotProcessData
}
struct LodgeRequest {
    let resourceURL:URL
    let API_KEY = "AIzaSyCI6sXu2GiN9fAKDD5PVeFxweGQG79QMKE" //Insert API key here
    
    init(lat:String,long:String) {
        let resourceString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(long)&radius=1000&type=lodging&keyword=surf&key=\(API_KEY)"
        guard let resourceURL = URL(string: resourceString) else {fatalError("error in resourceUrl, Lodgequest")}
        
        self.resourceURL = resourceURL
    }
    func getLodges(completion: @escaping(Result<[LodgeDetails],LodgeError>)-> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL){data,_,_ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do{
                let decoder = JSONDecoder()
                let lodgeResponse  = try decoder.decode(LodgeResponse.self, from: jsonData)
                let lodgeDetails = lodgeResponse.results.lodges
                completion(.success(lodgeDetails))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
