//
//  AspirationItem.swift
//  ActivQue
//
//  Created by Bohdan on 31.10.2020.
//  Copyright © 2020 Bohdan Brinzov. All rights reserved.
//

import SwiftUI

struct AspirationItemView: View {
    
    // MARK: - Constructor vars
    let nameAspiration: String
    let persents: Int
    let color: Color
    let totalTime = TimeInterval.init(30)
    
    // MARK: - Private consts
    private let _widthSize = UIScreen.main.bounds.width
    private let _heigthSize: CGFloat = 75
    private let _padding: CGFloat = 30
    private let _colorText: Color = .white
    private let _colorMain = Color.gray.opacity(0.15)
    
    // MARK: - View
    var body: some View {
        HStack(alignment: .center) {
           Triangle(width: 50, height: 42, radius: 6)
                .stroke(lineWidth: 4)
                .foregroundColor(color)
            .padding(.leading, _padding + 5)
            .padding(.top, 10)
            .frame(width: 70, alignment: .center)
            Text(nameAspiration)
                .foregroundColor(_colorText)
                .font(.title3)
                .padding(.trailing, _padding)
            Spacer()
        }.background(
            RoundedRectangle(cornerRadius: 20)
                .frame(width: _widthSize - _padding, height: _heigthSize, alignment: .center)
                .foregroundColor(_colorMain)
        )
        .padding(.vertical, _padding)
        .frame(width: _widthSize - _padding, height: _heigthSize, alignment: .center)
    }
}


struct AspirationItem_Previews: PreviewProvider {
    static var previews: some View {
        AspirationItemView(nameAspiration: "Unnowned", persents: 85, color: Color.orange)
    }
}
