//
//  ClimbView.swift
//  Climb Up
//
//  Created by Bohdan on 05.12.2020.
//

import SwiftUI
import Combine

struct ClimbView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var presenter: ClimbPresenter
    
    @State private var updateInterfaceTimer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    // MARK: Quality picker
    private let qualities = ["100 %", "95 %", "90 %", "85 %", "80 %", "75 %", "70 %", "65 %", "60 %", "55 %", "50 %", "45 %", "40 %", "35 %", "30 %", "25 %", "20 %", "15 %", "10 %", "5 %", "0 %"]
    @State private var selectedQuality = 10
    
    // MARK: Main image animation & dimentions
    private let circlePadding: CGFloat = 15
    
    private let circleWidth = UIScreen.main.bounds.width / 1.9
    private let circleWidthEnd = UIScreen.main.bounds.width / 1.4 
    
    private let headViewFrameHeight = UIScreen.main.bounds.height * 0.33
    private let headViewFrameHeightIsEnd = UIScreen.main.bounds.height * 0.45
    private let bottomViewFrameHeight = UIScreen.main.bounds.height * 0.66
    private let bottomViewFrameHeightIsEnd = UIScreen.main.bounds.height * 0.55
    
    private let mainImageFrame = CGSize(width: UIScreen.main.bounds.width / 3.2, height: UIScreen.main.bounds.width / 2.5)
    private let mainImageFrameEnd = CGSize(width: UIScreen.main.bounds.width / 2.5, height: UIScreen.main.bounds.width / 2)
    
    
    @State private var isAnimatingCircle = false
    @State private var isAnimatingCircle2 = false
    @State private var isAnimatingCircle3 = false
    
    @State private var isAnimatingCircle1 = false
    @State private var isAnimatingCircle21 = false
    @State private var isAnimatingCircle31 = false
    
    // MARK: Alert var
    @State private var isStopTimerAlert = false
//    @State private var isRemoveAlert = false
    
    var body: some View {
        VStack {
            ZStack{
                if presenter.isEndClimb {
                Image("ClimbMan")
                    .resizable()
                    .frame(width: mainImageFrameEnd.width , height: mainImageFrameEnd.height, alignment: .center)
                    .zIndex(4.0)
                    
                    Rectangle()
                        .frame(width: circleWidthEnd, height: circleWidthEnd, alignment: .center)
                        .foregroundColor(Color.black.opacity(0.3))
                        .cornerRadius(self.isAnimatingCircle1 ? 100: 120)
                        .rotationEffect(Angle(degrees: self.isAnimatingCircle1 ? 0 : 360))
                        .scaleEffect(self.isAnimatingCircle1 ? 0.95: 1)
                        .animation(Animation.linear(duration: 22.2).repeatForever(autoreverses: true))
                        .onAppear() {
                            DispatchQueue.main.async {
                                isAnimatingCircle1 = true
                            }
                        }
                        .zIndex(3.0)
                    
                    Rectangle()
                        .frame(width: circleWidthEnd + circlePadding, height: circleWidthEnd + circlePadding, alignment: .center)
                        .foregroundColor(Color.black.opacity(0.3))
                        .cornerRadius(self.isAnimatingCircle21 ? 100: 120)
                        .rotationEffect(Angle(degrees: self.isAnimatingCircle21 ? 320 : 0))
                        .scaleEffect(self.isAnimatingCircle21 ? 0.95: 1)
                        .animation(Animation.linear(duration: 20).repeatForever(autoreverses: true))
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                isAnimatingCircle2 = true
                            }
                        }
                        .zIndex(2.0)
                    
                    Rectangle()
                        .frame(width: circleWidthEnd + circlePadding, height: circleWidthEnd + circlePadding, alignment: .center)
                        .foregroundColor(Color.black.opacity(0.3))
                        .cornerRadius(self.isAnimatingCircle31 ? 100: 120)
                        .rotationEffect(Angle(degrees: self.isAnimatingCircle31 ? 0 : 300))
                        .scaleEffect(self.isAnimatingCircle31 ? 0.95: 1)
                        .animation(Animation.linear(duration: 20).repeatForever(autoreverses: true))
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                isAnimatingCircle3 = true
                            }
                        }
                        .zIndex(1.0)
                    
                } else {
                    Image("ClimbMan")
                        .resizable()
                        .frame(width: mainImageFrame.width , height: mainImageFrame.height, alignment: .center)
                        .zIndex(4.0)
                    
                    Rectangle()
                        .frame(width: circleWidth, height: circleWidth, alignment: .center)
                        .foregroundColor(Color.black.opacity(0.3))
                        .cornerRadius(self.isAnimatingCircle ? 100: 120)
                        .rotationEffect(Angle(degrees: self.isAnimatingCircle ? 0 : 360))
                        .scaleEffect(self.isAnimatingCircle ? 0.95: 1)
                        .animation(Animation.linear(duration: 22.2).repeatForever(autoreverses: true))
                        .onAppear() {
                            DispatchQueue.main.async {
                                isAnimatingCircle = true
                            }
                        }
                        .zIndex(3.0)
                    
                    Rectangle()
                        .frame(width: circleWidth + circlePadding, height: circleWidth + circlePadding, alignment: .center)
                        .foregroundColor(Color.black.opacity(0.3))
                        .cornerRadius(self.isAnimatingCircle2 ? 100: 120)
                        .rotationEffect(Angle(degrees: self.isAnimatingCircle2 ? 320 : 0))
                        .scaleEffect(self.isAnimatingCircle2 ? 0.95: 1)
                        .animation(Animation.linear(duration: 20).repeatForever(autoreverses: true))
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                isAnimatingCircle2 = true
                            }
                        }
                        .zIndex(2.0)
                    
                    Rectangle()
                        .frame(width: circleWidth + circlePadding, height: circleWidth + circlePadding, alignment: .center)
                        .foregroundColor(Color.black.opacity(0.3))
                        .cornerRadius(self.isAnimatingCircle3 ? 100: 120)
                        .rotationEffect(Angle(degrees: self.isAnimatingCircle3 ? 0 : 300))
                        .scaleEffect(self.isAnimatingCircle3 ? 0.95: 1)
                        .animation(Animation.linear(duration: 20).repeatForever(autoreverses: true))
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                isAnimatingCircle3 = true
                            }
                        }
                        .zIndex(1.0)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: presenter.isEndClimb ? headViewFrameHeightIsEnd : headViewFrameHeight, alignment: .center)
            VStack {
                if !$presenter.isEndClimb.wrappedValue {
                    VStack {
                        HStack {
                            Text("Interval: \(presenter.currentTimeTimer.asDateStringWithSeconds(style: .positional))")
                                .font(.footnote)
                                .foregroundColor(presenter.currentColor)
                                .padding(.horizontal)
                            Spacer()
                            if presenter.currentDraggingState == .left {
                                Text("\(presenter.lapsRemaining) :Laps remaining")
                                    .font(.footnote)
                                    .foregroundColor(Color.mainYellow)
                                    .padding(.horizontal)
                            }
                        }
                        ProgressBar(progress: $presenter.currentProgress, color: $presenter.currentColor)
                            .frame(height: 20, alignment: .center)
                            .padding(.horizontal)
                    }
                    .padding(.top)
                }
                HStack(alignment: .center, spacing: 20) {
                    if presenter.totalTime != 0 {
                        VStack(alignment: .center, spacing: 10) {
                            Text("Total")
                                .font(.footnote)
                                .foregroundColor(Color.mainAquaDarkest)
                            Text("\(presenter.totalTime.asDateStringWithSeconds(style: .positional))")
                                .font(.footnote)
                                .foregroundColor(Color.mainAquaDarkest)
                            
                        }
                        .frame(width: UIScreen.main.bounds.width / 5, alignment: .center)
                        .background(Color.black.cornerRadius(20).padding(-4).padding(.horizontal, -10))
                        .padding(.horizontal)
                    }
                    if presenter.activeTime != 0 {
                        VStack(alignment: .center, spacing: 10) {
                            Text("Active")
                                .font(.footnote)
                                .foregroundColor(Color.mainOrange)
                            Text("\(presenter.activeTime.asDateStringWithSeconds(style: .positional))")
                                .font(.footnote)
                                .foregroundColor(Color.mainOrange)
                        }
                        .frame(width: UIScreen.main.bounds.width / 5, alignment: .center)
                        .background(Color.black.cornerRadius(20).padding(-4).padding(.horizontal, -10))
                        .padding(.horizontal)
                    }
                    if presenter.restTime != 0 {
                        VStack(alignment: .center, spacing: 10) {
                            Text("Rest")
                                .font(.footnote)
                                .foregroundColor(Color.mainBlue)
                            Text("\(presenter.restTime.asDateStringWithSeconds(style: .positional))")
                                .font(.footnote)
                                .foregroundColor(Color.mainBlue)
                        }
                        .frame(width: UIScreen.main.bounds.width / 5, alignment: .center)
                        .background(Color.black.cornerRadius(20).padding(-4).padding(.horizontal, -10))
                        .padding(.horizontal)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 100, alignment: .center)
                .padding()
                if !presenter.isEndClimb {
                    Spacer(minLength: 0)
                }
                if presenter.isEndClimb {
                    Text("Climb quality")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width / 1.12, alignment: .center)
                        .background(Color.gray.cornerRadius(8).padding(-4).padding(.horizontal, -10).opacity(0.1))
                        .padding(.bottom, 30)
                    Spacer(minLength: 0)
                    Picker(selection: $selectedQuality, label: Text("Quality")) {
                        ForEach(0 ..< qualities.count) {
                            Text(self.qualities[$0])
                                .font(.title3)
                        }
                    }.frame(height: 120, alignment: .center)
                    .labelsHidden()
                    Spacer(minLength: 0)
                }
                else {
                    ZStack {
                        List {
                            ForEach(presenter.finishedLaps, id: \.id) { item in
                                HStack {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(item.color)
                                    Text("+ \((item.interval).asDateStringWithSeconds(style: .abbreviated))")
                                        .foregroundColor(.gray)
                                }
                                
                            }
                        }
                    }.cornerRadius(20)
                    .background(Color.black.cornerRadius(5).padding())
                    .frame(width: UIScreen.main.bounds.width * 0.95)
                }
                HStack(alignment: .center, spacing: 10) {
                    Spacer(minLength: 0)
                    if !presenter.isEndClimb {
                        Button(action: {
                            if presenter.totalTime > 5 {
                                self.isStopTimerAlert = true
                                UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 1)
                            } else {
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                                presenter.removeObservers()
                                presentationMode.wrappedValue.dismiss()
                            }
                        }, label: {
                            Text("Stop")
                                .foregroundColor(.red)
                                .padding(.horizontal)
                                .padding(.horizontal)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.red, style: StrokeStyle(lineWidth: 1.5))
                                )
                        })
              
                            Spacer(minLength: 0)
                            Button(action: {
                                presenter.nextInterval()
                            }, label: {
                                if presenter.currentDraggingState == .left {
                                    Text("Toggle state")
                                        .foregroundColor(Color.mainYellow)
                                        .padding(.horizontal)
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.mainYellow, style: StrokeStyle(lineWidth: 1.5))
                                        )
                                } else if presenter.currentDraggingState == .center {
                                    Text("Next interval")
                                        .foregroundColor(Color.mainYellow)
                                        .padding(.horizontal)
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.mainYellow, style: StrokeStyle(lineWidth: 1.5))
                                        )
                                } else if presenter.currentDraggingState == .right  {
                                    Text("Toggle state")
                                        .foregroundColor(Color.mainYellow)
                                        .padding(.horizontal)
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.mainYellow, style: StrokeStyle(lineWidth: 1.5))
                                        )
                                }
                            })
                        
                    } else {
                        Button(action: {
//                            self.isRemoveAlert = true
                            presenter.removeObservers()
                            presentationMode.wrappedValue.dismiss()
                            UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 1)
                        }, label: {
                            Text("Remove")
                                .foregroundColor(.red)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.red, style: StrokeStyle(lineWidth: 1.5))
                                )
                        })
                        Spacer(minLength: 0)
                        Button(action: {
                            presenter.saveClimb(pickerValue: selectedQuality)
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Save climb")
                                .foregroundColor(Color.mainAquaDarkest)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.mainAquaDarkest, style: StrokeStyle(lineWidth: 1.5))
                                )
                        })
                    }
                    Spacer(minLength: 0)
                }
                .padding(.top)
                .padding(.bottom)
                .padding(.bottom)
                .padding(.bottom)
            }
            .frame(width: UIScreen.main.bounds.width, height: presenter.isEndClimb ? bottomViewFrameHeightIsEnd : bottomViewFrameHeight, alignment: .center)
            .background(
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.03))
                    .cornerRadius(radius: 25, corners: [.topLeft, .topRight])
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mainBackgroundDark)
        .edgesIgnoringSafeArea(.all)
        .colorScheme(.dark)
        .onReceive(self.updateInterfaceTimer) { (_) in
            let result =  presenter.updateInterface()
            if result {
                updateInterfaceTimer.upstream.connect().cancel()
            }
        }
        .alert(isPresented: self.$isStopTimerAlert) {
            return Alert(title: Text("To complete?"), message: Text("There is no undo"), primaryButton: .destructive(Text("Stop")) {
                presenter.stopTimer()
            }, secondaryButton: .cancel())
        }
//        .alert(isPresented: self.$isRemoveAlert) {
//            return Alert(title: Text("Remove climb?"), message: Text("There is no undo"), primaryButton: .destructive(Text("Stop")) {
//                presenter.removeObservers()
//                presentationMode.wrappedValue.dismiss()
//            }, secondaryButton: .cancel())
//        }
        .onAppear {
            _ = presenter.updateInterface()
        }
        .animation(.default)
    }
}

struct FullScreenModalView_Previews: PreviewProvider {
    static var previews: some View {
        ClimbView(presenter: ClimbPresenter(lapsStepper: 5, intervalStepper: 10, activeStapper: 20, restStepper: 5, onlyTimeStepper: 5, draggingState: .left))
    }
}
