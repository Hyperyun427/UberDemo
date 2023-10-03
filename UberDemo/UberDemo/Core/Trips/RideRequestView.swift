//
//  RideRequestView.swift
//  UberDemo
//
//  Created by Yun Huang on 2023-09-21.
//

import SwiftUI

struct RideRequestView: View {
    
    @State private var selectedRideType: UberRideType = .uberX
    @EnvironmentObject var locationViewModel: SearchLocationViewModel
    
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48 , height: 6)
                .padding(.top, 8)
            
          // trip info section
            HStack{
                IconsForCurrentLocationToDest(isLargeIcon: true)
                
                VStack(alignment: .leading, spacing: 24){
                    HStack{
                        Text("Current location")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text(locationViewModel.pickupTime ?? "N/A")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }.padding(.bottom, 10)
                        
                    HStack{
                        
                        if let location = locationViewModel.selectedCoordinate{
                            Text(location.title)
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                        }
                   
                            
                        Spacer()
                            
                        Text(locationViewModel.dropoffTime ?? "N/A")
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
                    ForEach(UberRideType.allCases){ rideType in
                        
                        VStack(alignment: .leading){
                            Image(rideType.imageName)
                                .resizable()
                                .scaledToFit()
                            
                            VStack(alignment: .leading, spacing: 4){
                        
                                Text(rideType.name)
                                    .font(.system(size: 14, weight: .semibold))
                                
                                Text(locationViewModel.computeRidePrice(forType: rideType).toCurrent())
                                    .font(.system(size: 14, weight: .semibold))
                                
                            }
                            .padding()
                        }
                        .frame(width: 112, height:  140)
                        //if selected certain rideType, font change color from black to white, background change from white to blud and scale a bit
                        .foregroundColor(rideType == selectedRideType ? .white: .black)
                        .background(Color(rideType == selectedRideType ? .systemBlue: .systemGroupedBackground))
                        .scaleEffect(rideType == selectedRideType ? 1.2 : 1.0)
                        .cornerRadius(10)
                        .onTapGesture{
                            withAnimation(.spring()){
                                selectedRideType = rideType
                            }
                        }
                    }
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
        .padding(.bottom, 24)
        .background(.white)
        .cornerRadius(12)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
