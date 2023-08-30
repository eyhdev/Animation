//
//  Spinner.swift
//  Animation
//
//  Created by eyh.mac on 30.08.2023.
//

import SwiftUI

struct Spinner: View {
    
    let rotationTime: Double = 0.75
    let animationTime: Double = 1.9
    let fullRotation: Angle = .degrees(360)
    static let initialDegree: Angle = .degrees(270)
    
    @State var spinnerStart: CGFloat = 0.0
    @State var spinnerEndS1: CGFloat = 0.03
    @State var spinnerEnd2S3: CGFloat = 0.03
    
    @State var rotationDegreeS1 = initialDegree
    @State var rotationDegreeS2 = initialDegree
    @State var rotationDegreeS3 = initialDegree
    
    var body: some View {
        ZStack{
            SpinnerCircle(start: spinnerStart, end: spinnerEnd2S3, rotation: rotationDegreeS3, color: darkViolet)
            
            SpinnerCircle(start: spinnerStart, end: spinnerEnd2S3, rotation: rotationDegreeS2, color: darkViolet)
            
            SpinnerCircle(start: spinnerStart, end: spinnerEndS1, rotation: rotationDegreeS1, color: darkViolet)
        }
        .frame(width: 200, height: 200)
        .onAppear() {
            self.animationSpinner()
            
            Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) { (minTimer) in
                self.animationSpinner()
                
            }
        }
    }
    func animationSpinner(with duration: Double, completion: @escaping(() -> Void)){
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
            withAnimation(Animation.easeInOut(duration: self.rotationTime)){
                completion()
            }
            
        }
    }
    func animationSpinner() {
        animationSpinner(with: rotationTime) { self.spinnerEndS1 = 1.0 }
        
        animationSpinner(with: (rotationTime * 2) - 0.025) {
            self.rotationDegreeS1 += fullRotation
            self.spinnerEnd2S3 = 0.8
        }
        animationSpinner(with: (rotationTime * 2)) {
            self.spinnerEndS1 = 0.03
            self.spinnerEnd2S3 = 0.03
        }
        
        animationSpinner(with: (rotationTime * 2) + 0.0525) { self.rotationDegreeS2 += fullRotation }
        animationSpinner(with: (rotationTime * 2) + 0.225) { self.rotationDegreeS3 += fullRotation }
        
    }
}

struct SpinnerCircle: View{
    
    var start: CGFloat
    var end: CGFloat
    var rotation: Angle
    var color: Color
    
    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
            .fill(.white)
            .rotationEffect(rotation)
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
            .preferredColorScheme(.dark)
    }
}
