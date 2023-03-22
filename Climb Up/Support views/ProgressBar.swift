//
//  ProgressBar.swift
//  Climb Up
//
//  Created by Bohdan on 26.11.2020.
//

import SwiftUI

struct ProgressBarStatic: View {
    
    @State var progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20).frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color.mainAquaDarkest)
                
                RoundedRectangle(cornerRadius: 20).frame(width: min(CGFloat(self.progress / 100) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color.mainAquaDarkest)
                    .opacity(0.7)
            }
        }
    }
}

struct ProgressBarStatic_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarStatic(progress: 0.5)
            .frame(height: 20)
            .cornerRadius(5)
    }
}


struct ProgressBar: View {
    
    @Binding var progress: Double
    @Binding var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20).frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(color)
                RoundedRectangle(cornerRadius: 20).frame(width: min(CGFloat(self.progress / 102) * geometry.size.width + 8, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(color)
                    .opacity(0.7)
            }
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: .constant(0), color: .constant(Color.mainOrange))
            .frame(height: 20)
            .cornerRadius(5)
            .cornerRadius(20)
    }
}

