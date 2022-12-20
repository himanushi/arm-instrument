//
//  ContentView.swift
//  arm-instrument
//
//  Created by 匿名 on 2022/12/21.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    
    @State var buttonText = "Button"
    let tone = ToneOutputUnit()
    @ObservedObject var sensor = MotionSensor()
    
    init(){
        sensor.start()
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            Button(action: {
                buttonText = "Button Tapped"
                tone.enableSpeaker()
                tone.setFrequency(freq: (Double(sensor.yStr)! + 1) * 880.0)
                tone.setToneTime(t: 10)
            }){
                Text(buttonText)
                   .font(.largeTitle)
            }
            
            Text(sensor.xStr)
                        Text(sensor.yStr)
                        Text(sensor.zStr)
                        Button(action: {
                            sensor.isStarted ? sensor.stop() : sensor.start()
                        }) {
                            sensor.isStarted ? Text("STOP") : Text("START")
                        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
