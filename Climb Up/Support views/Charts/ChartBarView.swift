//
//  ChartBarView.swift
//  Climb Up
//
//  Created by Bohdan on 30.11.2020.
//

import SwiftUI


struct ChartBarView: View {
    
    
    @Binding var totalData: [Double]
    @Binding var activeData: [Double]
    @Binding var restData: [Double]
    
    var body: some View {
        ZStack{
            GeometryReader{ geometry in
                BarsView(totalData: $totalData, activeData: $activeData, restData: $restData,frame: CGSize(width: 290, height: 170))
            }
            .frame(width: 300, height: 170)
            .padding(.leading, 50)
        }.background(
            GeometryReader{ geometry in
                LinesGrid(data: $totalData, frame: .constant(geometry.frame(in: .local)), isDates: true)
            }.frame(width: 340, height: 170)
            .padding(.leading, 0)
        )
    }
}


struct BarsView : View {
    
    @Binding var totalData: [Double]
    @Binding var activeData: [Double]
    @Binding var restData: [Double]
    
    let frame: CGSize
    
    var maxPercent: Double {
        totalData.max() ?? 0 / 100
    }
    
    var count: Int {
        $totalData.wrappedValue.count
    }
    
    var body: some View {
        ZStack {
            HStack (spacing: 3) {
                ForEach(0..<count, id: \.self) { index in
                    BarView(total: CGFloat(totalData[index] / maxPercent * 170), activity: CGFloat(activeData[index] / maxPercent * 170), rest: CGFloat(restData[index] / maxPercent * 170))
                }
            }
        }.frame(width: frame.width, height: frame.height)
    }
    
    // MARK: - Support view
    struct BarView: View {
        
        var total: CGFloat
        var activity: CGFloat
        var rest: CGFloat
        
        var body: some View {
                ZStack (alignment: .bottom) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 170)
                    Rectangle()
                        .cornerRadius(radius: 3, corners: [.topLeft, .topRight])
                        .frame(height: total)
                        .foregroundColor(Color.mainAqua)
                    if activity > rest {
                        Rectangle()
                            .cornerRadius(radius: 3, corners: [.topLeft, .topRight])
                            .frame(height: activity)
                            .foregroundColor(Color.mainOrange)
                        Rectangle()
                            .cornerRadius(radius: 3, corners: [.topLeft, .topRight])
                            .frame(height: rest)
                            .foregroundColor(Color.mainBlue)
                    } else {
                        Rectangle()
                            .cornerRadius(radius: 3, corners: [.topLeft, .topRight])
                            .frame(height: rest)
                            .foregroundColor(Color.mainBlue)
                        Rectangle()
                            .cornerRadius(radius: 3, corners: [.topLeft, .topRight])
                            .frame(height: activity)
                            .foregroundColor(Color.mainOrange)
                    }
                }
            .animation(.default)
            .opacity(0.8)
        }
    }
}
