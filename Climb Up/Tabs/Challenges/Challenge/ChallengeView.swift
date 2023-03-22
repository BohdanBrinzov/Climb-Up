//
//  ChalengeView.swift
//  Climb Up
//
//  Created by Bohdan on 03.12.2020.
//

import SwiftUI

struct ChallengeView: View {
    
    var title: String
    var mainColor: Color
    
    @ObservedObject var presenter: ChallengePresenter
    
    private let width = UIScreen.main.bounds.width / 2.3
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            
            ForEach(presenter.challengesList, id: \.id) { challenge in
                
                    HStack {
                        
                        if challenge.id % 2 != 0 {
                            Spacer()
                        }
                        
                        VStack {
                            ZStack {
                                Circle()
                                    .frame(width: width + 8, height: width + 8, alignment: .center)
                                    .foregroundColor(Color.black)
                                
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                                    .fill(mainColor.opacity(0.2))
                                    .rotationEffect(Angle(degrees: -90))
                                    .frame(width: width, height: width, alignment: .center)
                                if challenge.isActive {
                                    Circle()
                                        .trim(from: 0.0, to: challenge.percent)
                                        .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                                        .fill(mainColor.opacity(0.7))
                                        .rotationEffect(Angle(degrees: -90))
                                        .frame(width: width, height: width, alignment: .center)
                                } else if !challenge.isActive && challenge.finalValue <=  challenge.currentValue {
                                    Circle()
                                        .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                                        .fill(mainColor.opacity(0.2))
                                        .rotationEffect(Angle(degrees: -90))
                                        .frame(width: width, height: width, alignment: .center)
                                }
                                Image(challenge.currentValue < challenge.finalValue ? "\(challenge.imageName)Black" : "\(challenge.imageName)")
                                    .resizable()
                                    .frame(width: challenge.imageSize.width, height: challenge.imageSize.height, alignment: .center)
                                
                            }
                            Spacer()
                            VStack {
                                if challenge.currentValue < challenge.finalValue {
                                    Text(challenge.titleName)
                                        .font(.footnote)
                                    
                                    Text(challenge.isActive ? " \(challenge.currentValue) / \(challenge.finalValue) " : "\(challenge.finalValue)")
                                        .font(.footnote)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(mainColor, lineWidth: 1)
                                                .padding(-5)
                                        )
                                        .padding(.top, 3)
                                } else {
                                    Text("Completed")
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                        .background(mainColor.cornerRadius(20).padding(-5))
                                        .padding(.top, 10)
                                }
                            }
                            Spacer()
                        }
                        
                        if challenge.id % 2 == 0 {
                            Spacer()
                        }
                    }
                    .padding(.horizontal, width * 0.18)
                    .padding(.top, -width * 0.5)
                    .background(
                        Circle()
                            .trim(from: 0.0, to: challenge.id != 4 ? 0.5 : 0)
                            .stroke(style: StrokeStyle(lineWidth: 4, dash: [7]))
                            .foregroundColor(mainColor.opacity(0.2))
                            .rotationEffect(Angle(degrees: challenge.id % 2 == 0 ? -90 : 90))
                    )
            }
            .padding(.top)
            .padding(.top, width * 0.6)
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.mainBackgroundDark)
        .colorScheme(.dark)
        .navigationBarTitle(title, displayMode: .inline)
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView(title: "Title", mainColor: Color.mainAqua, presenter: ChallengePresenter(currentChallenge: .Quality, values: [80,70,100,70,90,70,100,70,90,70,100,70,90,70,100,70,90]))
    }
}
