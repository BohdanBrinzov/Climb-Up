//
//  ChalengesView.swift
//  Climb Up
//
//  Created by Bohdan on 03.12.2020.
//

import SwiftUI

struct ChallengesListView: View {
    
    @ObservedObject var presenter: ChallengesListPresenter
    
    private let width = UIScreen.main.bounds.width
    private let font = Font.custom("Gotham Pro", size: 17)
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
                VStack{
                    presenter.linkBuilderClimbsCount {
                    Image("TotalTimeChallenge")
                        .resizable()
                        .frame(width: width / 2, height: width * 0.4, alignment: .center)
                    }
                    Text("Climbs count")
                        .foregroundColor(.white)
                        .font(font)
                }.rotationEffect(Angle(degrees: -8))
                .padding(.trailing, width * 0.45)
                .padding(.top, 60)
            
     
                VStack {
                    presenter.linkBuilderActiveTime {
                    Image("ActivityTimeChallenge")
                        .resizable()
                        .frame(width: width * 0.44, height: width * 0.40, alignment: .center)
                    }
                    Text("Activity")
                        .foregroundColor(.white)
                        .font(font)
                } .padding(.leading, width * 0.48)
                .padding(.top, -width * 0.3)
                .rotationEffect(Angle(degrees: 8))
            
            
          
                VStack {
                    presenter.linkBuilderRestTime {
                    Image("RestChallenge")
                        .resizable()
                        .frame(width: width * 0.45, height: width * 0.55, alignment: .center)
                    }
                    Text("     Rest")
                        .foregroundColor(.white)
                        .font(font)
                    
                }
            .padding(.trailing, width * 0.50)
            .padding(.top, -width * 0.15)
            
            
          
                VStack {
                    presenter.linkBuilderClimbsTime {
                    Image("QualityChallenge")
                        .resizable()
                        .frame(width: width * 0.45, height: width * 0.40, alignment: .center)
                    }
                    Text("Climb time")
                        .foregroundColor(.white)
                        .font(font)
                }.padding(.leading, width * 0.55)
                .padding(.top, -width * 0.4)
                .rotationEffect(Angle(degrees: -5))
            
            
          
                VStack {
                    presenter.linkBuilderQuality {
                    Image("Quality2Challenge")
                        .resizable()
                        .frame(width: width * 0.59, height: width * 0.45, alignment: .center)
                    }
                    Text("Quality         ")
                        .foregroundColor(.white)
                        .font(font)
                        .padding(.top, -25)
                } .padding(.trailing, width * 0.2)
                .rotationEffect(Angle(degrees: 5))
            
            HStack {}.frame(width: UIScreen.main.bounds.width)
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.mainBackgroundDark)
        .colorScheme(.dark)
        .navigationBarTitle("Challenges", displayMode: .inline)
    }
}

struct ChalengesView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengesListView(presenter: ChallengesListPresenter(interactor: ChallengesListInteractor()))
    }
}
