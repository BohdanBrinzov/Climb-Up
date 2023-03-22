//
//  PlayView.swift
//  Climb Up
//
//  Created by Bohdan on 05.12.2020.
//

import SwiftUI

struct PlayView: View {
    
    @State var isAnimating = false
    @Binding var draggingState: DraggingInterfaceState
    
    // MARK: - Timer values
    @Binding var activeStapper: Int
    @Binding var restStepper: Int
    @Binding var lapsStepper: Int
    @Binding var intervalStepper: Int
    @Binding var onlyTimeStepper: Int
    
    @State private var currentAspiration: Aspiration!
    
    private let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        HStack (alignment: .center, spacing: 5) {
            SelectHabbitView
            StartClimbView
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 10)
        .scaleEffect(draggingState == .active ? 0.98 : 1)
        .animation(.mainAppAnimation())
    }
    
    @State private var isChooseHabbit = false
    private var SelectHabbitView: some View {
        Button(action: {
            isChooseHabbit = true
        }, label: {
        ZStack {
        RoundedRectangle(cornerRadius: 20.0)
        .frame(width: screenWidth * 0.8, height: 50, alignment: .leading)
        .foregroundColor(Color.gray.opacity(0.1))
        .overlay(
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: "circle.fill")
                    .foregroundColor(currentAspiration?.color ?? .gray)
                Text(currentAspiration?.name ?? "Choose aspiration")
                .foregroundColor(Color.white.opacity(0.8))
                .scaleEffect(self.isAnimating ? 0.95: 1)
            }
        )
            RoundedRectangle(cornerRadius: 20.0)
            .frame(width: screenWidth * 0.8, height: 50, alignment: .leading)
                .foregroundColor(Color.mainBlue.opacity(0.05))
        }
        })
        .sheet(isPresented: $isChooseHabbit) {
                AspirationListChooseView(presenter: AspirationListPresenter(interactor: AspirationListInteractor()), aspirationTapped: $currentAspiration)
                .edgesIgnoringSafeArea(.bottom)
                .colorScheme(.dark)
            }
        .colorScheme(.dark)
    }
    
    @State private var isStartClimb = false
    private var StartClimbView: some View {
        Button(action: {
            isStartClimb = true
        }, label: {
            Image(systemName: "play.circle.fill")
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(Color.mainAquaDarkest.opacity(0.8))
        })
        .fullScreenCover(isPresented: $isStartClimb) {
            ClimbView(presenter: ClimbPresenter(lapsStepper: lapsStepper, intervalStepper: intervalStepper, activeStapper: activeStapper, restStepper: restStepper, onlyTimeStepper: onlyTimeStepper, draggingState: draggingState, currentAcpiration: currentAspiration))
                .colorScheme(.dark)
        }
    }
}

// MARK: - Fix!!!!!!!!!
struct AspirationListChooseView: View {
    
    @ObservedObject var presenter: AspirationListPresenter
    
    
    @State var isAddSheet = false
    
    @Binding var aspirationTapped: Aspiration?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach (presenter.aspirations, id: \.id) { item in
                    AspirationItemChooseView(nameAspiration: item.name, persents: 0, color: item.color)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                            .onTapGesture {
                                aspirationTapped = item
                                presentationMode.wrappedValue.dismiss()
                            }
                }
            }
            .padding(.top, 5)
            .sheet(isPresented: $isAddSheet, content: {
                presenter.makeAddAspirationView()
            })
            .navigationBarTitle("Choose Aspiration", displayMode: .inline)
            .navigationBarItems(trailing: Button("Add", action: {
                isAddSheet = true
            }))
        }
        .colorScheme(.dark)
        .background(Color.black)
        .accentColor(.white)
           
    }
}


struct AspirationItemChooseView: View {
    
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
    private let _colorMain = Color.black.opacity(0.3)
    
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
