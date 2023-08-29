//
//  OrderButton.swift
//  Animation
//
//  Created by eyh.mac on 29.08.2023.
//

import SwiftUI

enum OrderStatus {
    case ready
    case started
    case finished
}

struct OrderButton: View {
    
    @State private var status: OrderStatus = .ready
    @State private var showShippingTruck = false
    
    private var progressBardWidth: CGFloat = 250
    private var animationTime: TimeInterval = 0.4
    private var progressBarAnimationTime: TimeInterval = 3
    
    @State private var isPlaced = false
    
    var body: some View {
        VStack{
            ZStack{
                VStack{
                    HStack{
                        Spacer()
                            .frame(width: (status == .ready) ? 0 : 150)
                        
                        Image(systemName: "cube.box.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .opacity(showShippingTruck ? 1 : 0)
                            .animation(Animation.linear(duration: (status == .started && showShippingTruck) ? progressBarAnimationTime : animationTime).delay(0.3))
                        
                        Spacer()
                            .frame(width: (status == .ready) ? 150 : 0)
                    }.frame(width: progressBardWidth)
                    
                    Spacer()
                        .frame(height: 130)
                }
                if status != .finished {
                    RoundedRectangle(cornerRadius: 20, style: .circular)
                        .fill(status == .finished ? .white : .gray)
                        .frame(width: (status == .finished) ? 80 : 250, height: (status == .started || showShippingTruck) ? 12 : 80)
                        .animation(.linear(duration: animationTime))
                }
                HStack{
                    RoundedRectangle(cornerRadius: 30, style: .circular)
                        .fill(.white)
                        .frame(height: (status == .finished) ? 80 : 12)
                        .animation(.linear(duration: (status == .finished) ? animationTime : progressBarAnimationTime))
                    
                    Spacer()
                        .frame(width: (status == .ready) ? progressBardWidth : 0)
                }.frame(width: (status == .finished) ? 80 : progressBardWidth)
                
                if status != .finished {
                    Text("Complete Order")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.black)
                        .opacity((status == .started || showShippingTruck) ? 0 : 1)
                        .animation(Animation.linear(duration: animationTime - 0.1))
                }
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(Color.black)
                    .opacity((status == .finished) ? 1 : 0)
                    .animation(Animation.linear(duration: animationTime).delay(0.6))
                
            }.frame(width: progressBardWidth)
            .onTapGesture {
                download()
            }
        }
    }
    func download() {
        
        showShippingTruck.toggle()
        isPlaced.toggle()

        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { timer in
            status = .started
        }
        Timer.scheduledTimer(withTimeInterval: 3.6, repeats: false) { timer in
            showShippingTruck.toggle()
        }

        Timer.scheduledTimer(withTimeInterval: 4.5, repeats: false) { timer in
            status = .finished
        }
    }
}

struct OrderButton_Previews: PreviewProvider {
    static var previews: some View {
        OrderButton()
            .preferredColorScheme(.dark)
    }
}
