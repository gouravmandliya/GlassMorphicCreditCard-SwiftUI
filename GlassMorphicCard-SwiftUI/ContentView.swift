//
//  ContentView.swift
//  GlassMorphicCard-SwiftUI
//
//  Created by GOURAVM on 26/08/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var blurView: UIVisualEffectView = .init()
    @State var defaultBlurRadius: CGFloat = 0
    @State var defaultSaturationAmount:CGFloat = 0
    
    @State var progress:CGFloat = 0
    
    @State private var degrees: Double = 0
    @State private var isShowCVV: Bool = false
    
    var body: some View {
        ZStack{
            Color
                .black
                .ignoresSafeArea()
            VStack{
                CreditCard {
                     VStack {
                        Group {
                            if isShowCVV {
                                GlassMorphicCard {
                                    CardBackContent()
                                }
                            } else {
                                GlassMorphicCard {
                                   CardFrontContent()
                                }
                            }
                        }
                    }.rotation3DEffect(
                        .degrees(degrees),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                }
            
                Button {
                    withAnimation(.easeIn(duration: 0.4)) {
                        degrees += 180
                        isShowCVV.toggle()
                        blurView.gaussianBlurRadius = 1
                    }
                } label: {
                    Text(isShowCVV ? "Hide CVV" : "Show CVV")
                        .foregroundColor(.white)
                }
                .padding(.top,50)

            }
            
        }
        
    }
    
    @ViewBuilder
    func CardFrontContent()->some View{
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("GOLD MEMBERSHIP")
                    .kerning(1.2)
                    .modifier(CustomModifier(font: .callout))
                  
                Text("VISA")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .frame(width: 80, alignment: .trailing)
            }
            
            Spacer()
            Text("GOURAV MANDLIYA")
                .kerning(2)
                .modifier(CustomModifier(font: .title3))
            Text("1111 2222 33333")
                .kerning(5)
                .modifier(CustomModifier(font: .title3))
        }
        .padding(20)
        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading)
    }
    
    @ViewBuilder
    func CardBackContent()->some View{
        VStack(alignment: .leading, spacing: 12) {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 30)
                .padding(.top,30)
            
            
            HStack {
                
                Text("123").foregroundColor(Color.black)
                    .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 0.0, y: 1.0, z: 0.0))
                    .padding(5)
                    .frame(width: 100, height: 20)
                    .background(Color.white)
                Spacer()
                
            }
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading)
    }
    
   
    @ViewBuilder
    func GlassMorphicCard<Content:View>(
        @ViewBuilder content: ()-> Content)->some View  {
        
        ZStack {
            CustomBlurView(effect: .systemUltraThinMaterialDark) { view in
            blurView = view
                if defaultBlurRadius == 0 {
                    defaultBlurRadius = view.gaussianBlurRadius
                }
                if defaultSaturationAmount == 0 {
                    defaultSaturationAmount = view.saturationAmount
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    .linearGradient(colors: [.white.opacity(0.25),.white.opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    
                )
                .blur(radius: 5)
            
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .stroke(
                    .linearGradient(colors: [.white.opacity(0.6),.clear,.purple.opacity(0.2),.purple.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing),
                    lineWidth: 2
                )
            
        }
        .shadow(color: .black.opacity(0.15), radius: 5, x: -10, y: 10)
        .shadow(color: .black.opacity(0.15), radius: 5, x: 10, y: -10)
        .overlay(content: {
            content()
           
        })
        .padding(.horizontal,25)
        .frame(height:220)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CreditCard<Content>: View where Content: View {
    
    var content: () -> Content
    
    var body: some View {
        content()
    }
}

struct CustomModifier: ViewModifier {
    var font:Font
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(.white)
            .shadow(radius: 15)
            .frame(maxWidth:.infinity,alignment: .leading)
    }
}
