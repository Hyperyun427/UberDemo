//
//  RideRequestView.swift
//  UberDemo
//
//  Created by Yun Huang on 2023-09-21.
//

import SwiftUI

struct RideRequestView: View {
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48 , height: 6)
            
          // trip info section
            HStack{
                IconsForCurrentLocationToDest(isLargeIcon: true)
                
                VStack(alignment: .leading, spacing: 24){
                    HStack{
                        Text("Current location")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text("1:30 PM")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }.padding(.bottom, 10)
                        
                    HStack{
                        Text("Starbucks Coffee")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            
                        Spacer()
                            
                        Text("1:30 PM")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                }
            }.padding()
            
            Divider()
            
          // ride type selection section
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal){
                HStack(spacing: 12){
                    ForEach(1 ... 3, id: \.self){ _ in
                        VStack(alignment: .leading){
                            Image("uber-x")
                                .resizable()
                                .scaledToFit()
                            VStack(spacing: 4){
                                
                                Text("UberX")
                                    .font(.system(size: 14, weight: .semibold))
                                
                                Text("12.78")
                                    .font(.system(size: 14, weight: .semibold))
                                
                            }
                            .padding(8)
                        }
                    }
                    .frame(width: 112, height:  140)
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            Divider()
            
          // select payment section
            HStack{
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                
                Text("****-1234")
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            
            
          // confirm ride button
            
            Button{
                
            }label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32,height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            
            
            
            
        }
        .background(.white)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
