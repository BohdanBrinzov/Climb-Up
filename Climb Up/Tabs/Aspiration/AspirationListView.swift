//
//  AspirationListView.swift
//  Climb Up
//
//  Created by Bohdan on 13.11.2020.
//

import SwiftUI

struct AspirationListView: View {
    
    @ObservedObject var presenter: AspirationListPresenter
    
    @State var isAddSheet = false
    
    @State private var showingAlert = false
    @State private var deleteIndexSet: IndexSet?
    
    var body: some View {
        List {
            ForEach (presenter.aspirations, id: \.id) { item in
                self.presenter.linkBuilder(for: item) {
                    AspirationItemView(nameAspiration: item.name, persents: 0, color: item.color)
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                }
            }
            .onDelete(perform: { indexSet in
                self.showingAlert = true
                self.deleteIndexSet = indexSet
            })
            .alert(isPresented: self.$showingAlert) {
                let indexSet = self.deleteIndexSet!
                return Alert(title: Text("Delete with climbs"), message: Text("There is no undo"), primaryButton: .destructive(Text("Delete")) {
                        presenter.removeAspiration(offsets: indexSet)
                    }, secondaryButton: .cancel())
            }
            .listRowBackground(Color.black)
            .listRowInsets(EdgeInsets())
            .background(Color.black)
        }
        .padding(.top, 5)
        .listStyle(PlainListStyle())
        .sheet(isPresented: $isAddSheet, content: {
            presenter.makeAddAspirationView()
        })
        .navigationBarTitle("Aspirations", displayMode: .inline)
        .navigationBarItems(trailing: Button("Add", action: {
            isAddSheet = true
        }))
        .colorScheme(.dark)
        .background(Color.black)
    }
}

