//
//  CurrencyViewModel.swift
//  KursKu
//
//  Created by Tomi Mandala Putra on 15/05/2025.
//

import Foundation

@MainActor
class CurrencyViewModel: ObservableObject {
    @Published var baseAmount: Double = 1.0
    @Published var convertedAmount: Double = 0.0
    @Published var baseCurrency: CurrencyMenu = .Usa
    @Published var convertedCurrency: CurrencyMenu = .Indonesia
    @Published var rates: Rates?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""

    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.currencySymbol = ""
        return numberFormatter
    }

    var baseAmountText: String {
        guard let result = numberFormatter.string(from: NSNumber(value: baseAmount)) else {
            return "0"
        }

        return "\(result) \(baseCurrency.rawValue)"
    }

    var convertedAmountText: String {
        guard let result = numberFormatter.string(from: NSNumber(value: convertedAmount)) else {
            return "0"
        }

        return "\(result) \(convertedCurrency.rawValue)"
    }

    func fetchRates() async {
        guard let url = URL(string: "API_URL_HERE") else {
            errorMessage = "Could not fetch API URL"
            print("API URL is not valid!")
            return
        }

        let urlRequest = URLRequest(url: url)
        isLoading = true
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let result = try JSONDecoder().decode(Rates.self, from: data)
            rates = result
        } catch {
            errorMessage = "Could not fetch API URL"
            print(error.localizedDescription)
        }
        isLoading = false
    }

    func convert() {
        if let rates = rates,
           let baseExchangeRate = rates.rates[baseCurrency.rawValue],
           let convertedExchangeRate = rates.rates[convertedCurrency.rawValue]
        {
            convertedAmount = (convertedExchangeRate / baseExchangeRate) * baseAmount
        }
    }
}
