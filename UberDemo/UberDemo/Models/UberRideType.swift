//
//  UberRideType.swift
//  UberDemo
//
//  Created by Yun Huang on 2023-09-23.
//

import Foundation

// CaseIterable means u can access all cases instead of calling each one by one
// Identifuable means every state are unique to make sure no 2 state are same

enum UberRideType: Int, CaseIterable, Identifiable{
    
    case uberX;
    case uberBlack
    case uberXL
    case uberPlane
    
    var id : Int{ return rawValue }
    
    var name: String{
        switch self{
        case .uberX: return "Uber-X"
        case .uberBlack: return "Uber-Black"
        case .uberXL: return "Uber-XL"
        case .uberPlane: return "Uber-Cool-Plane"
        }
    }
    
    var imageName: String{
        switch self{
        case .uberX: return "uber-x"
        case .uberBlack: return "uber-black"
        case .uberXL: return "uber-x"
        case .uberPlane: return "uber-black"
        }
    }
    
    var basePrice: Double{
        switch self{
        case .uberX: return 5
        case .uberBlack: return 10
        case .uberXL: return 8
        case .uberPlane: return 2000
        }
    }
    
    func computePrice(for distanceInMeters: Double) -> Double{
        switch self{
        case .uberX: return basePrice + distanceInMeters / 1000 * 1.5
        case .uberBlack: return basePrice + distanceInMeters / 1000 * 2.0
        case .uberXL: return basePrice + distanceInMeters / 1000 * 1.75
        case .uberPlane: return basePrice + distanceInMeters / 1000 * 100
        }
    }
        
}
