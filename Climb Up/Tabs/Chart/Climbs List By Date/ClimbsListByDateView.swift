//
//  ClimbsListByDateView.swift
//  Climb Up
//
//  Created by Bohdan on 20.11.2020.
//

import SwiftUI

struct ClimbsListByDateView: View {
    
    @ObservedObject var presenter: ClimnsListByDatePresenter
    
    init(presenter: ClimnsListByDatePresenter){
        self.presenter = presenter
        UITableView.appearance().sectionIndexColor = UIColor(Color.mainBackground)
    }
    
    var body: some View {
        Form {
            // MARK: - Total values
            Section(header: Text("Total")) {
                HStack {
                    VStack{
                        Text("Total time")
                            .foregroundColor(Color.mainAqua)
                        Spacer(minLength: 0)
                        Text(presenter.totalValues.totalTime.asDateString(style: .abbreviated))
                            .foregroundColor(Color.mainAqua)
                            .font(.subheadline)
                        Spacer(minLength: 0)
                    }
                    Spacer(minLength: 0)
                    
                    VStack{
                        Text("Active")
                            .foregroundColor(Color.mainOrange)
                        Spacer(minLength: 0)
                        Text(presenter.totalValues.totalActive.asDateString(style: .abbreviated))
                            .foregroundColor(Color.mainOrange)
                            .font(.subheadline)
                        Spacer(minLength: 0)
                    }
                    Spacer(minLength: 0)
                    
                    VStack{
                        Text("Rest")
                            .foregroundColor(Color.mainBlue)
                        Spacer(minLength: 0)
                        Text(presenter.totalValues.totalRest.asDateString(style: .abbreviated))
                            .foregroundColor(Color.mainBlue)
                            .font(.subheadline)
                        Spacer(minLength: 0)
                    }
                    Spacer(minLength: 0)
                    
                    VStack{
                        Text("Quality")
                            .foregroundColor(Color.mainAquaDarkest)
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
                    }
                }
            }
            
            // MARK: - Table climbs
            Section(header: Text("Climbs: \(presenter.climbs.count)")) {
                HStack {
                    
                    HStack{
                        Text("Total time")
                            .foregroundColor(Color.mainAqua)
                    }
                    Spacer(minLength: 0)
                    
                    HStack{
                        Text("Active")
                            .foregroundColor(Color.mainOrange)
                    }
                    Spacer(minLength: 0)
                    
                    HStack{
                        Text("Rest")
                            .foregroundColor(Color.mainBlue)
                    }
                    Spacer(minLength: 0)
                    
                    HStack{
                        Text("Interval")
                            .foregroundColor(Color.mainYellow)
                    }
                }
                List {
                    ForEach (presenter.climbs, id: \.id) { climb in
                        presenter.linkBuilder(for: climb.aspiration?.id) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(climb.timeAll?.asDateString(style: .abbreviated) ?? "")
                                        .foregroundColor(Color.mainAqua)
                                        .font(.subheadline)
                                    Spacer(minLength: 0)

                                    Text(climb.timeActive?.asDateString(style: .abbreviated) ?? "")
                                        .foregroundColor(Color.mainOrange)
                                        .font(.subheadline)
                                    Spacer(minLength: 0)

                                    Text(climb.timeRest?.asDateString(style: .abbreviated) ?? "")
                                        .foregroundColor(Color.mainBlue)
                                        .font(.subheadline)
                                    Spacer(minLength: 0)
                                    
                                    if climb.timeInterval != nil && climb.timeInterval != 0 {
                                        Text(climb.timeInterval?.asDateString(style: .abbreviated) ?? "")
                                            .foregroundColor(Color.mainYellow)
                                            .font(.subheadline)
                                    } else {
                                        Text("   ")
                                            .font(.subheadline)
                                    }
                             
                                }
                                HStack {
                                    Text("Quality")
                                        .foregroundColor(Color.mainAquaDarkest)
                                        .font(.subheadline)
                                    ProgressBarStatic(progress: Double(climb.quality ?? 0))
                                        .frame(height: 10)
                                    Text("\(climb.quality ?? 0) %")
                                        .foregroundColor(Color.mainAquaDarkest)
                                        .font(.subheadline)
                                }
                            }.padding()
                        }
                    }
                }
            }
        }
        .navigationBarTitle("\(presenter.currentDate.getFormattedDate(format: "dd/MM/yyyy"))", displayMode: .inline)
        .colorScheme(.dark)
    }
}
