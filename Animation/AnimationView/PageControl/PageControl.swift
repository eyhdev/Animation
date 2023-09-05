//
//  PageControl.swift
//  Animation
//
//  Created by eyh.mac on 5.09.2023.
//

import SwiftUI

struct PageControl: View {
    
    @Binding var selectedPage: Int

    var pages: Int
    var circleDiameter: CGFloat
    var circleMargin: CGFloat

    private var circleRadius: CGFloat { circleDiameter / 2}
    private var pageIndex: CGFloat { CGFloat(selectedPage - 1) }

    private var currentPosition: CGFloat {
        let stackWidth = circleDiameter * CGFloat(pages) + circleMargin * CGFloat(pages - 1)
        let halfStackWidth = stackWidth / 2
        let iniPosition = -halfStackWidth + circleRadius
        let distanceToNextPoint = circleDiameter + circleMargin
        return iniPosition + (pageIndex * distanceToNextPoint)
    }
    
    var body: some View {
        ZStack{
            HStack(spacing: circleMargin){
                ForEach(0 ..< pages) { _ in
                    Circle()
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                        .frame(width: circleDiameter, height: circleDiameter)
                }
            }
            Circle()
                .foregroundColor(.white)
                .frame(width: circleDiameter, height: circleDiameter)
                .offset(x: currentPosition)
                .animation(.linear(duration: 0.3))
        }
    }
}

struct PageControlPreview: View{
    
    var page: Int = 5
    @State var selectedPage: Int = 1
    
    var body: some View{
        VStack(spacing: 20){
            HStack{
                Button(action: {
                    selectedPage = selectedPage - 1
                }, label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                    
                })
                
                Button(action: {
                    selectedPage = selectedPage + 1
                }, label: {
                    Image(systemName: "chevron.right.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                    
                })
            }
            PageControl(selectedPage: $selectedPage, pages: page, circleDiameter: 15.0, circleMargin: 10.0)
        }
    }
}

struct PageControl_Previews: PreviewProvider {
    static var previews: some View {
        PageControlPreview()
            .preferredColorScheme(.dark)
    }
}
