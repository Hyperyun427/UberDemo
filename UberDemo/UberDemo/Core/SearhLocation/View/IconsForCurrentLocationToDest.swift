//
//  IconsForCurrentLocationToDest.swift
//  UberDemo
//
//  Created by Yun Huang on 2023-09-21.
//

import SwiftUI

struct IconsForCurrentLocationToDest: View {
    let isLargeIcon: Bool
    var body: some View {
     
        HStack{
            VStack{
                Circle()
                    .fill(Color(.gray))
                    .frame(width: isLargeIcon ? 8: 6, height: isLargeIcon ? 8: 6)
                
                Rectangle()
                    .fill(Color(.gray))
                    .frame(width: 1 , height: isLargeIcon ? 32: 24)
                
                Rectangle()
                    .fill(Color(.gray))
                    .frame(width: isLargeIcon ? 8: 6 , height: isLargeIcon ? 8: 6)
            }
        }
        
        
        
        
        
        
    }
}

struct IconsForCurrentLocationToDest_Previews: PreviewProvider {
    static var previews: some View {
        IconsForCurrentLocationToDest(isLargeIcon: false)
    }
}
