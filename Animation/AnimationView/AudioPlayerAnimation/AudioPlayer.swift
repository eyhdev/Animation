//
//  AudioPlayer.swift
//  Animation
//
//  Created by eyh.mac on 31.08.2023.
//

import SwiftUI

struct AudioPlayer: View {
    
    @Namespace private var playerAnimation
    @State private var showDetails = true
    @State private var showsControls = true

    @State var progress: CGFloat = 0.65

    var frame: CGFloat {
        showDetails ? 300 : 75
    }
    var body: some View {
        VStack {
            Spacer()
            VStack {
                HStack{
                    Image("img1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: frame, height: frame)
                        .padding(.top, showDetails ? 180 : 0)

                    if !showDetails {
                        VStack(alignment: .leading) {
                            Text("Forest Sound")
                                .font(Font.custom("BEBAS NEUE", size: 25))
                                .foregroundColor(.white)

                            Text("Sleep Sound")
                                .foregroundColor(.gray)
                        }
                        .font(.title2)
                        .matchedGeometryEffect(id: "AlbumTitle", in: playerAnimation)


                        Spacer()

                        Image(systemName: "play.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                
                if showDetails{
                    Spacer()
                        .frame(height: 44)
                    
                    HStack{
                        Spacer()
                            .frame(width: 44)
                        
                        VStack(alignment: .leading){
                            Text("Forest Sound")
                                .font(Font.custom("BEBAS NEUE", size: 35))
                                .foregroundColor(.white)
                            
                            Text("Sleep Sound")
                                .foregroundColor(.gray)
                            
                        }
                        .font(.title2)
                        .matchedGeometryEffect(id: "Album Title", in: playerAnimation)
                        
                        Spacer()
                    }
                    
                    VStack{
                        ProgressBar(initialProgress: $progress, color: .white)
                            .frame(height: 8)
                            .padding([.leading, .trailing], 44)
                        
                        HStack{
                            Image(systemName: "backward.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .padding()
                            
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                                .padding()
                            
                            Image(systemName: "forward.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .padding()
                        }
                    }.opacity(showsControls ? 1 : 0)
                        .animation(.easeIn)
                    Spacer()
                }
            }
            
            .onTapGesture {
                showsControls.toggle()
                Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { timer in
                    withAnimation(.spring()) {
                        self.showDetails.toggle()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: showDetails ? UIScreen.screenHeight + 44 : 75)
        }
    }
}


struct AudioPlayerContentView: View{
    var body: some View{
        ZStack{
            AudioPlayer()
        }
    }
}
struct AudioPlayer_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerContentView()
            .preferredColorScheme(.dark)
    }
}
