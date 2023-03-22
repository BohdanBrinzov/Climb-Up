//
//  ColorPicker.swift
//  Climb Up
//
//  Created by Bohdan on 15.11.2020.
//

import SwiftUI

struct FlatColorPicker : View {
    @Binding var selection: Int
    let colors: [Color]
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Spacer(minLength: 0)
            ForEach(0..<colors.count) { (colorIndex: Int) in
                ColorItemsView(colors: colors, selection: $selection, colorIndex: colorIndex)
                Spacer(minLength: 0)
            }
        }
    }
    
    struct ColorItemsView: View {
        
        let colors: [Color]
        
        @Binding var selection: Int
        
        let colorIndex: Int
        
        var body: some View {
            Image(systemName: colorIndex ==  $selection.wrappedValue ? "circle.fill" : "circle")
                .foregroundColor(colors[colorIndex])
                .padding(9)
                .scaleEffect(CGSize(width: colorIndex ==  $selection.wrappedValue ? 1.5 : 1.0, height: colorIndex ==  $selection.wrappedValue ? 1.5 : 1.0))
                .onTapGesture {
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 0.6)
                    selection = colorIndex
                }
                .animation(.spring())
        }
    }
}



struct FlatColorPicker_Previews: PreviewProvider {
    
    static var previews: some View {
        FlatColorPicker(selection: .constant(0), colors: [.blue, .orange, .orange, .orange, .orange, .orange, .orange, .orange])
    }
}
