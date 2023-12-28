//
//  CircleGroupView.swift
//  Restart
//
//  Created by Mateus Benilson Martins Fernandes on 28/12/23.
//

import SwiftUI

struct CircleGroupView: View {
    
    // MARK : -PROPERTIES
    
    @State var shapeColor: Color
    @State var shapeOpacity: Double
    @State private  var isAnimating: Bool = false
    var body: some View {
        
        ZStack{
            
            Circle().stroke(shapeColor.opacity(shapeOpacity),lineWidth: 40).frame(width: 260,height: 260,alignment: .center)
            Circle().stroke(shapeColor.opacity(shapeOpacity),lineWidth: 80).frame(width: 260,height: 260,alignment: .center)
        }//: ZSTACK
        .blur(radius: isAnimating ? 0:10)
        .opacity(isAnimating ? 1:0)
        .scaleEffect(isAnimating ? 1: 0.5)
        .animation(.easeOut(duration: 1),value: isAnimating)
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

#Preview {
    ZStack {
        Color("ColorBlue").ignoresSafeArea(.all).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
    }
}
