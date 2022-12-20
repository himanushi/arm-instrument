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
    
    @State private var x: Double = 0.0
    @State private var y: Double = 0.0
    @State private var z: Double = 0.0
    
    var body: some View {
        VStack(spacing: 50) {
            Text("y: \((y + 2) * 1760 )")
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
    
    func start() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { data, error in
                guard let data else { return }
                tone.setFrequency(freq: (data.acceleration.y > 0 ? data.acceleration.y : data.acceleration.y + 1) * 1760 )
                x = data.acceleration.x
                y = data.acceleration.y
                z = data.acceleration.z
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
