//
//  AspirationView.swift
//  Climb Up
//
//  Created by Bohdan on 14.11.2020.
//

import SwiftUI

struct AspirationView: View {
    
    @ObservedObject var presenter: AspirationPresenter
    
    var body: some View {
        Form {
            
            // MARK: - Header
            HStack(alignment: .center) {
                Triangle(width: 50, height: 42, radius: 6)
                    .stroke(lineWidth: 4)
                    .foregroundColor(presenter.aspiration?.color ?? Color.gray)
                    .padding(.leading, 30)
                    .padding(.top, 25)
                    .frame(width: 70, alignment: .center)
                Text(presenter.aspiration?.name ?? "Aspiration name")
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding(.trailing, 30)
                Spacer()
            }
            .frame(minHeight: 55)
            
            // MARK: - Quality chart
            if presenter.qualities.count > 1 {
                
                Section(header: HStack{Text("Quality")
                    .font(.title3)
                    .foregroundColor(Color.mainAqua)
                    
                }) {
                    ChartLineView(points: $presenter.qualities)
                }
            }
            
            // MARK: - Total values
            Section(header: Text("Total")) {
                TotalValues(totalTime: $presenter.totalValues.totalTime, totalActive: $presenter.totalValues.totalActive, totalRest: $presenter.totalValues.totalRest, averageQuality: $presenter.totalValues.averageQuality)
            }
            
            // MARK: - Table climbs
            Section(header: Text("Climbs: \(presenter.climbs.count)")) {
                HStack {
                    HStack{
                        Text("Date")
                            .foregroundColor(Color.mainGreen)
                    }
                    Spacer(minLength: 0)
                    
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
                        VStack{
                            HStack {
                                Text("\(climb.date.getFormattedDate(format: "dd-MM-yy") )")
                                    .foregroundColor(Color.mainGreen)
                                    .font(.subheadline)
                                Spacer(minLength: 0)
                                
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
        }.colorScheme(.dark)
    }
}

struct AspirationView_Previews: PreviewProvider {
    static var previews: some View {
        AspirationView(presenter: AspirationPresenter(interactor: AspirationInteractor(aspirationId: UUID())))
            .colorScheme(.dark)
    }
}
