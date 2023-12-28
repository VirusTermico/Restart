//
//  HomeView.swift
//  Restart
//
//  Created by Mateus Benilson Martins Fernandes on 28/12/23.
//

import SwiftUI

struct HomeView: View {
    // MARK :- PROPERTIES
    
    @AppStorage("onboarding") var isOnboardingActive: Bool = false
    @State private  var isAnimating: Bool = false
    var body: some View {

        VStack(spacing:20){
           // MARK: -HEADER
            Spacer()

            ZStack {
                CircleGroupView(shapeColor: .gray, shapeOpacity: 0.1)

                Image("character-2").resizable().scaledToFit().offset(y:isAnimating ? 35:-35).animation(Animation.easeInOut(duration: 4).repeatForever(),value: isAnimating)

            }
            
           // MARK: -CENTER
            Text("The time that leads to mastery is dependent on intensity of our focus").font(.title3).fontWeight(.light).foregroundColor(.secondary).multilineTextAlignment(.center).padding()
            // MARK: -FOOTER
            
            Spacer()
            
            Button(action:{
                
                withAnimation{
                    playSound(sound: "success", type: "m4a")

                    isOnboardingActive = true
                }
            } )
            {
                
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill").imageScale(.large)
                Text("Restart").font(.system(.title3,design: .rounded)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }//: BUTTON
            .buttonStyle(.borderedProminent).buttonBorderShape(.capsule).controlSize(.large)
            
        }.onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                isAnimating = true
            })
        })
    }
}

#Preview {
    HomeView()
}
