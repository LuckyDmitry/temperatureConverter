//
//  TemperatureCalculating.swift
//  TemperatureConverter
//
//  Created by Trifonov Dmitry on 3/16/21.
//

import Foundation

enum Temparature {
    case celcius(Double)
    case farenheit(Double)
    case kelvin(Double)
    

    func toCelcius() -> Double {
        switch self {
        case .celcius(let num):
            return num
        case .farenheit(let num):
            return toCelcius(fromFarenheit: num)
        case .kelvin(let num):
            return toCelcius(fromKelvin: num)
        }
    }
    
    func toKelvin() -> Double {
        let celcius = toCelcius()
        return toKelvin(fromCelcius: celcius)
    }
    
    func toFarenheit() -> Double {
        let celcius = toCelcius()
        return toFarenheit(fromCelcius: celcius)
    }
    
    private func toFarenheit(fromCelcius val: Double) -> Double {
        return (val * 9 / 5) + 32
    }
    
    private func toKelvin(fromCelcius val: Double) -> Double {
        return val + 273.15
    }
    
    private func toCelcius(fromFarenheit val: Double) -> Double {
        return (val - 32) * 5 / 9
    }

    private func toCelcius(fromKelvin val: Double) -> Double {
        return (val - 273.15)
    }
}

func convertTemperature(from lhs: Temparature, targetTemperature target: String) -> Double? {
    
    if (target.contains("Celsius")) {
        return lhs.toCelcius()
    } else if (target.contains("Kelvin")) {
        return lhs.toKelvin()
    } else if (target.contains("Farenheit")){
        return lhs.toFarenheit()
    } else{
        return nil
    }
}

