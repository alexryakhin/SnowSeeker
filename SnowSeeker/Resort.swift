//
//  Resort.swift
//  SnowSeeker
//
//  Created by Alexander Bonney on 7/14/21.
//

import Foundation


struct Resort: Codable, Identifiable {
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    var facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let resorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = resorts[0]
    
}
