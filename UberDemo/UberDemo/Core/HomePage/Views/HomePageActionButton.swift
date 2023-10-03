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
    @EnvironmentObject var viewModel: SearchLocationViewModel
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
            print("default home page")
        case .SearchingForDestination:
            mapState = .defaultHomePage
        case .DestinationSelected:
            viewModel.selectedCoordinate = nil
            mapState = .defaultHomePage
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String{
        switch state {
        case .defaultHomePage:
            return "line.3.horizontal"
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
