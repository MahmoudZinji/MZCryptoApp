//
//  HomeViewModel.swift
//  MZCryptoApp
//
//  Created by Mahmoud Zinji on 2022-10-17.
//

import Foundation

class HomeViewModel: ObservableObject {

    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
}
