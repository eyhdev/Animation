//
//  AudioPlayer.swift
//  Animation
//
//  Created by eyh.mac on 5.09.2023.
//

import SwiftUI
import AVFoundation

class AudioManager: ObservableObject {
    static let shared = AudioManager()
    
    var audioPlayer: AVAudioPlayer?
    var isPlaying: Bool = false
    var timer: Timer?
    
    @Published var currentTime: TimeInterval = 0.0
    @Published var duration: TimeInterval = 0.0
    
    func playPause() {
        if isPlaying {
            audioPlayer?.pause()
            timer?.invalidate()
        }else{
            audioPlayer?.play()
            startTimer()
        }
        isPlaying.toggle()
    }
    func setAudioPlayer(audioFileName: String){
        guard let audioURL = Bundle.main.url(forResource: audioFileName, withExtension: "mp3") else {
            return
        }
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            duration = audioPlayer?.duration ?? 0.0
        }catch {
            print("Error loading audio file: \(error.localizedDescription)")
        }
    }
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            self?.currentTime = self?.audioPlayer?.currentTime ?? 0.0
        }
    }
    func seek(to time: TimeInterval){
        audioPlayer?.currentTime = time
    }
}

struct AudioPlayer: View {
    
    @Namespace private var playerAnimation
    @State private var showDetails = true
    @State private var showControls = true
    @State private var isPlaying = false
    @State private var progress: CGFloat = 0.65
    
    @State private var isDraggingSlider = false
    
    @ObservedObject var audioManager = AudioManager.shared
    
    var frame: CGFloat {
        showDetails ? 300 : 75
    }
    
    var body: some View {
        VStack{
            Spacer()
            VStack{
                HStack{
                    Image("img1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: frame, height: frame)
                        .padding(.top, showDetails ? 180 : 0)
                    
                    if !showDetails {
                        
                        VStack(alignment: .leading){
                            
                            Text("Forest Sound")
                                .font(Font.custom("BEBAS NEUE", size: 25))
                                .foregroundColor(.white)
                            
                            Text("Sleep Sound")
                                .foregroundColor(.gray)
                        }
                        .font(.title2)
                        .matchedGeometryEffect(id: "Album Title", in: playerAnimation)
                        
                        Spacer()
                        
                        Button(action: {
                            audioManager.playPause()
                            isPlaying.toggle()
                            
                        }) {
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .padding()
                                
                        }
                    }
                }
                if showDetails{
                    VStack{
                        Text("Forest Sound")
                            .font(Font.custom("BEBAS NEUE", size: 25))
                            .foregroundColor(.white)
                        
                        Text("Sleep Sound")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    
                    .matchedGeometryEffect(id: "Album Title", in: playerAnimation)
                    
                    VStack{
                        HStack{
                            Text(formattedTime(audioManager.currentTime))
                            Spacer()
                            Text(formattedTime(audioManager.duration))
                        }
                        
                        .font(.title2)
                        
                        .padding()
                        
                        Slider(value: $audioManager.currentTime, in: 0...audioManager.duration, onEditingChanged: { editing in
                            isDraggingSlider = editing
                            if !editing{
                                audioManager.seek(to: audioManager.currentTime)
                                if isPlaying {
                                    audioManager.playPause()
                                }
                            }
                        })
                        .disabled(audioManager.duration.isZero)
                        .accentColor(Color.white)
                        .padding()
                        
                        HStack{
                            Button(action: {}) {
                                Image(systemName: "gobackward.15")
                                    .font(.system(size: 35))
                                    .foregroundColor(.white)
                                    .padding()
                                    .onTapGesture {
                                        let newTime = audioManager.currentTime - 10
                                        if newTime < 0 {
                                            audioManager.seek(to: 0)
                                        }else{
                                            audioManager.seek(to: newTime)
                                        }
                                    }
                                    
                            }
                            
                            Button(action: {
                                audioManager.playPause()
                                isPlaying.toggle()
                                
                            }) {
                                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                                    .padding()
                                    
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "goforward.15")
                                    .font(.system(size: 35))
                                    .foregroundColor(.white)
                                    .padding()
                                    .onTapGesture {
                                        let newTime = audioManager.currentTime + 10
                                        if newTime > audioManager.duration {
                                            audioManager.seek(to: audioManager.duration)
                                        }else{
                                            audioManager.seek(to: newTime)
                                        }
                                    }
                                    
                            }
                        }
                    }
                    .padding()
                }
                
                
            }
        
            .onTapGesture {
                showControls.toggle()
                Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { timer in
                    withAnimation(.spring()) {
                        self.showDetails.toggle()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: showDetails ? UIScreen.screenHeight + 44 : 75)
        }
        .onAppear{
            audioManager.setAudioPlayer(audioFileName: "sound")
        }
    }
    
    func formattedTime(_ time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minute,seconds)
        
    }
}

struct AudioContentView: View{
    var body: some View{
        ZStack{
            AudioPlayer()
        }
    }
}

struct AudioPlayer_Previews: PreviewProvider {
    static var previews: some View {
        AudioContentView()
            .preferredColorScheme(.dark)
    }
}
