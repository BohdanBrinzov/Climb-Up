//
//  AspirationAddView.swift
//  Climb Up
//
//  Created by Bohdan on 14.11.2020.
//

import SwiftUI

struct AspirationAddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let presenter: AspirationListPresenter
    
    @State var selectedColorIndex = 4
    @State var name = ""
    
    private let _colors = [ Color.mainBlue, Color.mainAqua, Color.mainAquaDarkest, Color.mainGreen,  Color.mainYellow, Color.mainOrangeLight, Color.mainOrange, Color.red]
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Name")) {
                    TextField(" . . . . . . . .", text: $name)
                        .keyboardType(.default)
                    
                }
                
                Section(header: Text("Color")) {
                    HStack(alignment: .center) {
                        FlatColorPicker(selection: $selectedColorIndex, colors: _colors)
                            .frame(alignment: .center)
                    }
                }
                
                Button(action: {
                    if name != "" {
                        let newAspiration = Aspiration(name: name, color: _colors[selectedColorIndex])
                        presenter.addAspiration(aspiration: newAspiration)
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        UINotificationFeedbackGenerator().notificationOccurred(.warning)
                    }
                }) {
                    Text("Add Aspiration")
                        .foregroundColor(.white)
                }
            }
            .navigationTitle("Aspiration")
        }
        .colorScheme(.dark)
    }
}

struct AspirationAddView_Previews: PreviewProvider {
    static var previews: some View {
        AspirationAddView(presenter: AspirationListPresenter(interactor: AspirationListInteractor()))
    }
}
