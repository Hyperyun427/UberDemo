//
//  SearchLocationDetailView.swift
//  UberDemo
//
//  Created by Yun Huang on 2023-09-17.
//

import SwiftUI

//class pass by reference: same instance
//struct pass by value: different instance
struct SearchLocationDetailView: View {
    
    @State private var startLocationText = ""
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel : SearchLocationViewModel
    
      var body: some View {
          VStack{
              
              // Location bar View
              HStack{
                  IconsForCurrentLocationToDest(isLargeIcon: false)
                  
                  VStack{
                      //deafult, changing text
                      TextField(" Current Location" ,text: $startLocationText)
                          .frame(height: 32)
                          .background(Color(.systemGroupedBackground))
                          .padding(.trailing)
                      
                      TextField(" Where we going?" ,text: $viewModel.queryFragment)
                          .frame(height: 32)
                          .background(Color(.systemGray4))
                          .padding(.trailing)
                  }
              }
              .padding(.horizontal)
              .padding(.top, 60)
              
              Divider()
                  .padding(.vertical)
              
              //scroll View
              ScrollView{
                  VStack(alignment: .leading){
                      ForEach(viewModel.results, id: \.self){ result in
                          SearchLocationResultCell(title:result.title, subtitle: result.subtitle)
                              .onTapGesture {
                                  //transfer selected data when taped
                                  viewModel.selectLocation(result)
                                  withAnimation(.spring()){
                                    mapState = .DestinationSelected
                                  }
                                  
                              }
                      }
                  }
              }
          }
          .background(Color(.white))
          
          
          
          
          
          
          
          
          
      }
}

struct SearchLocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchLocationDetailView(mapState:.constant(.defaultHomePage))
    }
}
