# SimpleFinance
A simple financing app that allows you to:
- find the percent change based on two values
- convert from the USD to the EUR, JPY, and GBP
- calculate the monthly payments on a mortgage

## Demo
<img src="https://dendev.net/Demos/SimpleFinance.gif"/>

## Notes
#### Under the hood:
These are the variables that allow the app to save user inputs to be used in the later calculations along with default values for currencies.
```swift
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
```
The following is how we calculate the percentage change between the two values using (new - old) / old.

```swift
var calculateReturn: Double {
        if before == "" || after == "" {
            return 0
        }
        let old = Double(before) ?? 0
        let new = Double(after) ?? 0
        return (new - old) / old * 100
    }
```
The code below is responsible for taking in our currency variables, and using a Picker, generate the appropriate currency conversion.
```swift
TextField("USD", text: $usd)
Picker("Conversion", selection: $convert) {
   ForEach (0 ..< conversionRate.count) {
       Text("\(currencyName[$0])")
   }
}.pickerStyle(SegmentedPickerStyle())
Text("\((Double(usd) ?? 0) * conversionRate[convert], specifier: "%.2f") \(currencyName[convert])")
```
And the final part, calculating the mortgage monthly payments using (principal * (rate / 12) * (1 + rate / 12)^(time * 12)) / ((1 + rate / 12)^(time * 12) - 1)
```swift
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
```
