//
//  ContentView.swift
//  arm-instrument
//
//  Created by 匿名 on 2022/12/21.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    private let motionManager = CMMotionManager()
    private let tone = ToneOutputUnit()
    @State private var y: Double = 0.0
    @State private var hzData: Double = 0.0
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Hz: \(hz(y))")
            Text("A4 = 440 Hz")
            Button {
                tone.enableSpeaker()
                tone.setToneTime(t: 10000)
            } label: {
                Text("押して")
            }
        }
        .onAppear() {
            start()
        }
        .onDisappear() {
            tone.stop()
            stop()
        }
    }
    
    func hz(_ slope: Double) -> Double {
        hzData = (slope + 1) * 1760
        return hzData
    }
    
    func start() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { data, error in
                guard let data else { return }
                y = data.acceleration.y
                tone.setFrequency(freq: hz(y))
            }
        }
    }
    func stop() {
        if motionManager.isAccelerometerActive {
            motionManager.stopAccelerometerUpdates()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
