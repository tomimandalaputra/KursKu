//
//  HomeView.swift
//  KursKu
//
//  Created by Tomi Mandala Putra on 15/05/2025.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = CurrencyViewModel()
    @FocusState private var baseAmountIsFocused: Bool
    @FocusState private var convertedAmountIsFocused: Bool

    private let today = Date.now
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading) {
                    Text("Indicative Exchange Rate")
                        .foregroundStyle(.gray)
                        .font(.system(size: 20))
                    Text("\(dateFormatter.string(from: today))")
                        .foregroundStyle(.black)
                        .font(.system(size: 14, weight: .medium))
                }.padding(.top, 16)
                
                VStack(alignment: .leading) {
                    Text("From")
                        .foregroundStyle(.black)
                        .font(.system(size: 18, weight: .bold))
                    
                    TextField("", value: $viewModel.baseAmount, formatter: viewModel.numberFormatter)
                        .focused($baseAmountIsFocused)
                        .onSubmit {
                            updateConvertion()
                        }
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.black)
                        .keyboardType(.numberPad)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.clear)
                                .stroke(.black, lineWidth: 2)
                        }
                        .overlay(alignment: .trailing) {
                            HStack(spacing: 12) {
                                viewModel.baseCurrency.image()
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .clipShape(Circle())
                                
                                Menu {
                                    ForEach(CurrencyMenu.allCases) { currency in
                                        Button(action: {
                                            viewModel.baseCurrency = currency
                                            viewModel.convert()
                                        }, label: {
                                            Text(currency.fetchMenuName())
                                        })
                                    }
                                } label: {
                                    Text(viewModel.baseCurrency.rawValue)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundStyle(.black)
                                    
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundStyle(.black)
                                }
                            }.padding(.trailing)
                        }
                    
                    HStack {
                        Spacer()
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundStyle(.black)
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    Text("To")
                        .foregroundStyle(.black)
                        .font(.system(size: 18, weight: .bold))
                    
                    TextField("", value: $viewModel.convertedAmount, formatter: viewModel.numberFormatter)
                        .disabled(true)
                        .focused($convertedAmountIsFocused)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.black)
                        .keyboardType(.numberPad)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.clear)
                                .stroke(.black, lineWidth: 2)
                        }
                        .overlay(alignment: .trailing) {
                            HStack(spacing: 12) {
                                viewModel.convertedCurrency.image()
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .clipShape(Circle())
                                
                                Menu {
                                    ForEach(CurrencyMenu.allCases) { currency in
                                        Button(action: {
                                            viewModel.convertedCurrency = currency
                                            viewModel.convert()
                                        }, label: {
                                            Text(currency.fetchMenuName())
                                        })
                                    }
                                } label: {
                                    Text(viewModel.convertedCurrency.rawValue)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundStyle(.black)
                                    
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundStyle(.black)
                                }
                            }.padding(.trailing)
                        }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    Text(viewModel.errorMessage)
                        .foregroundStyle(.red)
                        .fontWeight(.semibold)
                    Spacer()
                }
            }
            .padding(.horizontal)
            .task {
                await viewModel.fetchRates()
                viewModel.convert()
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .onTapGesture {
            updateConvertion()
        }
    }
    
    private func updateConvertion() {
        viewModel.convert()
        baseAmountIsFocused = false
        convertedAmountIsFocused = false
    }
}

#Preview {
    HomeView()
}
