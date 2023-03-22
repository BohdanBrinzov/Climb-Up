//
//  ChartBarPickerView.swift
//  Climb Up
//
//  Created by Bohdan on 02.12.2020.
//

import SwiftUI

struct ChartBarPickerView: View {
    
    @State private var pickerSelectedItem = 0
    
    @Binding var totalTime: [Double]
    @Binding var activityTime: [Double]
    @Binding var restTime: [Double]
    
    var body: some View {
        VStack {
                ChartBarView(totalData: $totalTime, activeData: $activityTime, restData: $restTime)
            }
            .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.default)
            .colorScheme(.dark)
    }
}

struct ChartBarPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ChartBarPickerView(totalTime: .constant([10,30,20,13]), activityTime: .constant([50,30,70,20]), restTime: .constant([10,30,23,68,32,43,13]))
            .colorScheme(.dark)
    }
}
