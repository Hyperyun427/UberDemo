//
//  HomePageActionButton.swift
//  UberDemo
//
//  Created by Yun Huang on 2023-09-17.
//

import SwiftUI

struct HomePageActionButton: View {
    //use binding to create two-way conection between property
    @Binding var mapState: MapViewState
    var body: some View {
        Button{
            withAnimation(.spring()){
                actionForState(mapState)
            }
            
            
        }label:{
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        
    }
    
    func actionForState(_ state: MapViewState){
        switch state {
        case .defaultHomePage:
            print("DEBUG: Default HomePage")
        case .SearchingForDestination:
            print("DEBUG: Searching For Destination")
        case .DestinationSelected:
            print("DEBUG: Destination Selected")
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String{
        switch state {
        case .defaultHomePage:
            return "line.3.horizintal"
        case .SearchingForDestination, .DestinationSelected:
            return "arrow.left"
 
        }
    }
}

struct HomePageActionButton_Previews: PreviewProvider {
    static var previews: some View {
        HomePageActionButton(mapState: .constant(.defaultHomePage))
    }
}
