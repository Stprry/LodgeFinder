//
//  LodgesDataModel.swift
//  SurflineCodingTest
//
//  Created by Sam Perry on 12/10/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=50.4164582,-5.100202299999978&radius=1000&type=surfing&keyword=lodge&key=AIzaSyCI6sXu2GiN9fAKDD5PVeFxweGQG79QMKE

import Foundation

struct LodgeResponse:Decodable {
    var results:Lodges
}

struct Lodges:Decodable {
    var lodges:[LodgeDetails]
}
struct LodgeDetails:Decodable {
    var opening_hours:LodgeOpen
    var name:String
    var rating:Double
    
}
struct LodgeOpen:Decodable {
    var open_now:Bool
    
}

