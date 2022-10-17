//
//  HomeViewModel.swift
//  MZCryptoApp
//
//  Created by Mahmoud Zinji on 2022-10-17.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    var cancellables = Set<AnyCancellable>()

    private let dataService = CoinDataService()

    init() {
        addSubscribers()
    }

    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
