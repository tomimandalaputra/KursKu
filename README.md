# 📱 Kursku

**Kursku** is a currency converter app built with **Swift**, integrated with the [OpenExchangeRates.org](https://openexchangerates.org) API to deliver real-time and accurate exchange rate data.

Designed for a smooth and intuitive user experience, Kursku helps users convert currencies quickly and effortlessly — ideal for travelers, business professionals, or anyone needing up-to-date exchange information.

---

## 🚀 Features

- 🔄 Real-time currency conversion
- 🌐 Support for multiple currencies
- 📈 Accurate exchange rate data via OpenExchangeRates API
- 📱 Built with Swift and SwiftUI

---

## 🛠️ Tech Stack

- **Language:** Swift
- **UI Framework:** SwiftUI
- **Networking:** URLSession
- **API Source:** [OpenExchangeRates.org](https://openexchangerates.org)

---

## 📦 Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/tomimandalaputra/KursKu.git
   ```

2. Enter the base url of the full universe API with the app_id query parameter
   ```
   // directory --> @/ViewModels/CurrencyViewModel.swift
   // ex: https://openexchangerates.org/api/latest.json?app_id={your_app_id}
   
   func fetchRates() async {
        guard let url = URL(string: "API_URL_HERE") else {
           ...
        }
        ....
    }
   ```
3. Run on preview or simulator or real device
