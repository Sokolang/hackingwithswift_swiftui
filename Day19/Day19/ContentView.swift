//
//  ContentView.swift
//  Day19
//
//  Created by Anzhellika Sokolova on 05.01.2021.
//

import SwiftUI


struct ContentView: View {
    
    @State private var inputValue="1"
    @State private var inputUnit=1
    @State private var outputUnit=1
    
    let inputUnits=["m","km","ft","yd","mi"]
    let outputUnits=["m","km","ft","yd","mi"]

    var numberConverted: Double{
        let inputNumber = Double(inputValue) ?? 0
        let inUnit = inputUnits[inputUnit]
        var meterNumber = 0.0
        var outputNumber = 0.0
        
        switch inUnit {
            case "m":  meterNumber = inputNumber
            case "km":  meterNumber = inputNumber * 1000.0
            case "ft":  meterNumber = inputNumber * 0.3048
            case "yd":  meterNumber = inputNumber * 0.9144
            case "mi":  meterNumber = inputNumber * 1609.3
                
        default:  meterNumber = 0.0
        }
        
        let outUnit = outputUnits[outputUnit]
        
        switch outUnit {
            case "m":  outputNumber = meterNumber
            case "km":  outputNumber = meterNumber * 0.001
            case "ft":  outputNumber = meterNumber * 3.281
            case "yd":  outputNumber = meterNumber * 1.0936
            case "mi":  outputNumber = meterNumber * 0.0006214

            default: outputNumber = 0.0
        }
        
        return outputNumber
        
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Input")){
                    
                    TextField("Enter number", text: $inputValue)
                        .keyboardType(.decimalPad)
                    Picker ("InputPicker",selection: $inputUnit){
                        ForEach(0 ..< inputUnits.count){
                            Text("\(self.inputUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                }
  
                Section (header: Text("Output")){
                
                    Text("\(numberConverted, specifier: "%.2f")")

                    Picker("OutUnits", selection: $outputUnit) {
                        ForEach(0 ..< outputUnits.count) {
                            Text("\(self.outputUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Day 19 Challenge")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
