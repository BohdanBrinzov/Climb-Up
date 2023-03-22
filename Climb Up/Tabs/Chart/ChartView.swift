//
//  ChartView.swift
//  Climb Up
//
//  Created by Bohdan on 20.11.2020.
//

import SwiftUI

struct ChartView: View {
    
    @ObservedObject var presenter: ChartPresenter
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            // MARK: Calendar view
            presenter.makeCalendarView()
                .padding(.bottom, 20)
            
            // MARK: - Total values
            Section() {
                HStack {
                    Spacer(minLength: 0)
                    VStack{
                        Text("Total")
                            .foregroundColor(Color.mainAqua)
                            .padding(.top, 10)
                            .background(Color.black.cornerRadius(20).padding(.top, 10).padding(-4).padding(.horizontal, -10))
                        Spacer(minLength: 0)
                        Text(presenter.totalValues.totalTime.asDateString(style: .abbreviated))
                            .foregroundColor(Color.mainAqua)
                            .font(.subheadline)
                            .padding(.top, -10)
                        Spacer(minLength: 0)
                    }
                    .frame(width: 80, alignment: .center)
                    .background(
                        Color.mainBackground
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    )
                    Spacer(minLength: 0)
                    
                    VStack{
                        VStack {
                            Text("Active")
                                .padding(.top, 10)
                                .foregroundColor(Color.mainOrange)
                                .background(Color.black.cornerRadius(20).padding(.top, 10).padding(-4).padding(.horizontal, -5))
                            
                            Spacer(minLength: 0)
                            Text(presenter.totalValues.totalActive.asDateString(style: .abbreviated))
                                .foregroundColor(Color.mainOrange)
                                .font(.subheadline)
                                .padding(.top, -10)
                            Spacer(minLength: 0)
                        }
                        
                    }
                    .frame(width: 80, alignment: .center)
                    .background(
                        Color.mainBackground
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    )
                    Spacer(minLength: 0)
                    
                    VStack{
                        Text("Rest")
                            .padding(.top, 10)
                            .foregroundColor(Color.mainBlue)
                            .background(Color.black.cornerRadius(20).padding(.top, 10).padding(-4).padding(.horizontal, -10))
                        
                        Spacer(minLength: 0)
                        Text(presenter.totalValues.totalRest.asDateString(style: .abbreviated))
                            .foregroundColor(Color.mainBlue)
                            .font(.subheadline)
                            .padding(.top, -10)
                        Spacer(minLength: 0)
                        
                    }
                    .frame(width: 80, alignment: .center)
                    .background(
                        Color.mainBackground
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    )
                    Spacer(minLength: 0)
                    
                    VStack{
                        Text("Quality")
                            .padding(.top, 10)
                            .foregroundColor(Color.mainAquaDarkest)
                            .background(Color.black.cornerRadius(20).padding(.top, 10).padding(-4).padding(.horizontal, -2))
                        ZStack {
                            Circle()
                                .trim(from: 0.0, to: CGFloat(presenter.totalValues.averageQuality / 100))
                                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                .fill(Color.mainAqua.opacity(0.7))
                                .rotationEffect(Angle(degrees: -90))
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                .fill(Color.mainAqua.opacity(0.2))
                                .rotationEffect(Angle(degrees: -90))
                            Text("\(Int(presenter.totalValues.averageQuality))")
                                .foregroundColor(Color.mainAqua.opacity(0.7))
                        }
                        .frame(width: 50, height: 50, alignment: .trailing)
                        .padding()
                        .padding(.top, -10)
                    }
                    .background(
                        Color.mainBackground
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    )
                    Spacer(minLength: 0)
                }
            }
            .padding(.vertical)
            
            // MARK: - Charts
            if presenter.totalActiveChart.count > 1 {
            Section(header:
                        HStack{
                            Text("Time chart")
                                .foregroundColor(.gray)
                                .padding(.leading, 40)
                            Spacer()
                        }
                        .padding(.bottom, -260)
            ) {
                ChartBarPickerView(totalTime: $presenter.totalTimeChart, activityTime: $presenter.totalActiveChart, restTime: $presenter.totalRestChart)
            }
            .background(
                Color.mainBackground
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                    .cornerRadius(radius: 10, corners: [.bottomRight, .bottomLeft])
                    .cornerRadius(radius: 5, corners: [.topRight, .topLeft])
            )
            .padding(.top, 20)
                
            Section(header:
                        HStack{
                            Text("Quality chart")
                                .foregroundColor(.gray)
                                .padding(.leading, 40)
                            Spacer()
                        }.background(Color.black)
                        .padding(.bottom, -260)
            ) {
                ChartLineView(points: $presenter.qualitiesChart)
            }
            .background(
                Color.mainBackground
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                    .cornerRadius(radius: 10, corners: [.topRight, .topLeft])
            )
            .padding(.top, 20)
            
            } else {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 2, alignment: .center)
                    .foregroundColor(.white)
                Text("Need two days of activity to display charts")
                    .foregroundColor(Color.white.opacity(0.8))
                    .padding(.top, 20)
            }
        }
        .colorScheme(.dark)
        .background(Color.black)
        .navigationBarTitle("Chart", displayMode: .inline)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChartView(presenter: ChartPresenter(interactor: ChartInteractor()))
        }
    }
}
