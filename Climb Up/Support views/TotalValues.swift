//
//  TotalValues.swift
//  Climb Up
//
//  Created by Bohdan on 23.11.2020.
//

import SwiftUI

struct TotalValues: View {
    
    @Binding var totalTime: Double
    @Binding var totalActive: Double
    @Binding var totalRest: Double
    @Binding var averageQuality: Double
    
    
    
    var body: some View {
        HStack {
            VStack{
                Text("Total time")
                    .foregroundColor(Color.mainAqua)
                Spacer(minLength: 0)
                Text(totalTime.asDateString(style: .abbreviated))
                    .foregroundColor(Color.mainAqua)
                    .font(.subheadline)
                Spacer(minLength: 0)
            }
            Spacer(minLength: 0)
            
            VStack{
                Text("Active")
                    .foregroundColor(Color.mainOrange)
                Spacer(minLength: 0)
                Text(totalActive.asDateString(style: .abbreviated))
                    .foregroundColor(Color.mainOrange)
                    .font(.subheadline)
                Spacer(minLength: 0)
            }
            Spacer(minLength: 0)
            
            VStack{
                Text("Rest")
                    .foregroundColor(Color.mainBlue)
                Spacer(minLength: 0)
                Text(totalRest.asDateString(style: .abbreviated))
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
                        .trim(from: 0.0, to: CGFloat(averageQuality / 100))
                        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                        .fill(Color.mainAqua.opacity(0.7))
                        .rotationEffect(Angle(degrees: -90))
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                        .fill(Color.mainAqua.opacity(0.2))
                        .rotationEffect(Angle(degrees: -90))
                    Text("\(Int(averageQuality))")
                        .foregroundColor(Color.mainAqua.opacity(0.7))
                }
                .frame(width: 50, height: 50, alignment: .trailing)
            }
        }
    }
}

struct TotalValues_Previews: PreviewProvider {
    static var previews: some View {
        TotalValues(totalTime: .constant(9000), totalActive: .constant(6000), totalRest: .constant(3000), averageQuality: .constant(95))
    }
}
