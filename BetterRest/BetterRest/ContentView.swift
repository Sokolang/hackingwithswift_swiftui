//
//  ContentView.swift
//  BetterRest
//
//  Created by Anzhellika Sokolova on 10.01.2021.
//


import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    //@State private var betterTime = "no data"
    
    let model = SleepCalculator()
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var betterTime: String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        var resultTime=""
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            resultTime = formatter.string(from: sleepTime)
             } catch {
                resultTime = "Error"
             }
            return resultTime
         }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")){
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                Section(header: Text("Desired amount of sleep")){
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                Section (header: Text("Daily coffee intake")){
                    Picker("Number of cups", selection: $coffeeAmount) {
                        ForEach(1 ..< 20) {
                            Text("\($0)")
                        }
                    }
                }
                Section (header: Text("Your ideal bedtime")){
                    Text("\(betterTime)")
                        .foregroundColor(.blue)
                        .font(.largeTitle)
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
