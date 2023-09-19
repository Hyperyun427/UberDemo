//
//  ContentView.swift
//  UberDemo
//
//  Created by Yun Huang on 2023-09-13.
//

import SwiftUI

struct HomeView: View {
    // State: save data even though struct get destroy
    // binding: share properties
    @State private var mapState = MapViewState.defaultHomePage
    //@EnvironmentObject var locationViewModel: SearchLocationViewModel

    var body: some View {
        
        ZStack(alignment: .top){
   
          UberMapViewRepresentable()
                .ignoresSafeArea()
            if showLocationDetailView{
                SearchLocationDetailView(mapState: $mapState )
                
                HomePageActionButton(mapState: $mapState)
                    .padding(.leading)
            }
            else{
                SearchLocationBarView()
                      .padding(.init(top: 70, leading: 0, bottom: 0, trailing: 0))
                      .onTapGesture {
                          withAnimation(.spring()){
                              //showLocationDetailView = true
                              showLocationDetailView.toggle()
                          }
                          
                      }
                  
                HomePageActionButton(showLocationDetailView: $showLocationDetailView)
                      .padding(.leading)
                  
            }
        
            
            
            
            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
