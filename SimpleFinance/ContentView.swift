//
//  ContentView.swift
//  SimpleFinance
//
//  Created by Alex on 5/3/21.
//

import SwiftUI

struct ContentView: View {
    //Return Calculator
    @State var before = ""
    @State var after = ""
    
    //Dollar Conversion
    @State var usd = ""
    @State var convert = 0
    let conversionRate = [0.83, 109.13, 0.72]
    let currencyName = ["EUR", "JPY", "GBP"]
    
    //Mortgage Payment
    @State var principal = ""
    @State var rate = ""
    @State var time = ""
    
    var MortgagePmt: Double {
        if principal == "" || time == "" || rate == "" {
            return 0
        }
        let p = Double(principal) ?? 0
        let t = Double(time) ?? 0
        let r = Double(rate) ?? 0
        return ((p * r / 100 / 12) * pow(1 + r / 100 / 12, t * 12))
            / (pow(1 + r / 100 / 12, t * 12) - 1)
    }
    //Return Calculator
    var calculateReturn: Double {
        if before == "" || after == "" {
            return 0
        }
        return ((Double(after) ?? 0) - (Double(before) ?? 0))
            / (Double(before) ?? 0) * 100.00
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Return Calculator")) {
                    TextField("Before", text: $before)
                    TextField("After", text: $after)
                    Text("\(calculateReturn, specifier: "%.2f")% return")
                        .font(.title)
                }
                
                Section(header: Text("Dollar Conversions")) {
                    TextField("USD", text: $usd)
                    Picker("Conversion", selection: $convert) {
                        ForEach (0 ..< conversionRate.count) {
                            Text("\(currencyName[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text("\((Double(usd) ?? 0) * conversionRate[convert], specifier: "%.2f") \(currencyName[convert])")
                        .font(.title)
                }
                
                Section(header: Text("Mortgage Payment Calculator")) {
                    TextField("Principal", text: $principal)
                    TextField("Interest Rate", text: $rate)
                    TextField("Time in years", text: $time)
                    Text("\(MortgagePmt, specifier: "$%.2f/mo")")
                        .font(.title)
                }
            }
            .keyboardType(.decimalPad)
            .navigationBarTitle(Text("SimpleFinance"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
