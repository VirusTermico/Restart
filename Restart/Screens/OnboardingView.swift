//
//  HomeView.swift
//  Restart
//
//  Created by Mateus Benilson Martins Fernandes on 28/12/23.
//

import SwiftUI

struct OnboardingView: View {
    // MARK :- PROPERTIES
    
    @AppStorage("onboarding") var isOnboardingActive: Bool = true
    @State private var buttonWith: Double = UIScreen.main.bounds.width-80
    @State private var buttonOffset: CGFloat = 0
    
    @State private  var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicateOpacity: Double = 1.0
    @State private var titleText: String = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {

        ZStack {
            Color("ColorBlue").ignoresSafeArea(.all).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing:20){
                
                // MARK: - HEADER
                Spacer()
                VStack(spacing:0){
                    Text(titleText).font(.system(size: 60)).foregroundColor(.white).fontWeight(.heavy).transition(.opacity).id(titleText)
                    
                    Text("""
                        It´s not how much we give but
                        how much we love
                        """).font(.title3).fontWeight(.light).multilineTextAlignment(.center).foregroundColor(.white).padding(.horizontal,10)
                            }.opacity(isAnimating ? 1: 0)
                            .offset(y: isAnimating ? 0 : -40)
                            .animation(.easeOut(duration: 1),value: isAnimating)
                // HEADER
                // MARK: - CENTER
                
                ZStack{
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x:imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width/5)).animation(.easeInOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1:0).animation(.easeInOut(duration: 0.5), value:
                    isAnimating)
                    .offset(x: imageOffset.width * 1.5 ,y:0)
                    .rotationEffect(.degrees(Double(imageOffset.width/20)))
                        .gesture(
                        DragGesture().onChanged { gesture in
                            if abs(imageOffset.width) <= 150 {
                                
                                imageOffset = gesture.translation
                               
                                
                                withAnimation(.linear(duration: 0.25)){
                                    indicateOpacity = 0
                                    titleText = "Give."
                                }
                            }
                        }
                            .onEnded { _ in
                                imageOffset.width = .zero
                                indicateOpacity = 1
                                titleText = "Share."
                            }
                        ).animation(Animation.easeOut(duration: 1),value: imageOffset)
                    
                }//:CENTER
                .overlay(Image(
                    systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44,weight: .ultraLight)).foregroundColor(.white).offset(y:20).opacity(isAnimating ? 1:0).animation(.easeOut(duration: 1).delay(2), value: isAnimating).opacity(indicateOpacity),alignment: .bottom
                )
                Spacer()
                // MARK: -FOOTER
              
                ZStack{
                    // 1. BACKGROUND(STATIC)
                    Capsule().fill(Color.white.opacity(0.2))
                    Capsule().fill(Color.white.opacity(0.2)).padding(8)
                    // 2. CALL TO ACTION
                    
                    Text("Get Started").font(.system(.title3,design: .rounded)).fontWeight(.bold).foregroundColor(.white).offset(x:20)
                    // 3. CAPSULE (DYNAMIC WIDTH)
                    HStack {
                        Capsule().fill(Color("ColorRed")).frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    
                    // 4. CIRCLE (DRAGGABLE)
                    HStack {
                        ZStack(){
                            Circle().fill(Color("ColorRed"))
                            Circle().fill(Color.black.opacity(0.15)).padding(8)
                            Image(systemName: "chevron.right.2").font(.system(size: 24)).fontWeight(.bold)
                        }.foregroundColor(.white).frame(
                            width: 80,height: 80,alignment: .center)
                        .offset(x: buttonOffset).gesture(
                            DragGesture().onChanged {
                                gesture in
                                if gesture.translation.width > 0 && buttonOffset <=  buttonWith-80 {
                                
                                    buttonOffset = gesture.translation.width
                                }
                            }.onEnded { _ in
                               
                                withAnimation(Animation.easeOut(duration: 0.4)){
                                    if buttonOffset > buttonWith/2 {
                                        playSound(sound: "chimeup", type: "mp3")
                                        hapticFeedback.notificationOccurred(.success)
                                        buttonOffset = buttonWith - 80
                                        isOnboardingActive = false

                                    }else {
                                        hapticFeedback.notificationOccurred(.warning)

                                        buttonOffset = 0
                                    }
                                }
                            }
                        )
                     
                        
                        
                    
                        
                        Spacer()
                    }// :HSTACK
                    
                }//: ZSTACK
                .frame(width: buttonWith,height: 80,alignment: .center).onAppear(perform: {
                    isAnimating = true
                })
                .padding()
                .opacity(isAnimating ? 1:0).offset(y: isAnimating ? 0: 40).animation(.easeOut(duration: 1),value: isAnimating)
            }// VSTACK
        }// ZSTACK
        .onAppear(perform: {
            isAnimating = true
        }).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    OnboardingView()
}

