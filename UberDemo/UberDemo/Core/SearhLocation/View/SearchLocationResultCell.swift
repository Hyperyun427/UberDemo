//
//  SearchLocationResultCell.swift
//  UberDemo
//
//  Created by Yun Huang on 2023-09-17.
//

import SwiftUI

struct SearchLocationResultCell: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40,height: 40)
            
            VStack(alignment:.leading, spacing: 4){
                Text(title)
                    .font(.body)
                
                Text(subtitle)
                    .font(.system(size:15))
                    .foregroundColor(.gray)
                
                Divider()
            }
            .padding(.horizontal,8)
            .padding(.vertical,8)
            
        }
        .padding(.horizontal)
    }
}

struct SearchLocationResultCell_Previews: PreviewProvider {
    static var previews: some View {
        //deafult value
        SearchLocationResultCell(title:"Starbucks",subtitle: "123 street")
    }
}
