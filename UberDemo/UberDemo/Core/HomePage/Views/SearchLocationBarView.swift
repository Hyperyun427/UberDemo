//
//  SearchLocationBarView.swift
//  UberDemo
//
//  Created by Yun Huang on 2023-09-17.
//

import SwiftUI

//search bar in homepage
struct SearchLocationBarView: View {
    var body: some View {
        HStack{
            
            Rectangle()
                .fill(.black)
                .frame(width: 8,height: 8)
                .padding(.horizontal)
            
            Text("Where you going?")
                .foregroundColor(Color(.darkGray))
            
            Spacer()
            
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(){
            Rectangle()
                .fill(Color(.white))
                .shadow(radius: 6)
        }
        
        
        
    }
}

struct SearchLocationBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchLocationBarView()
    }
}
