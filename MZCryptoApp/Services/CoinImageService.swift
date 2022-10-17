//
//  CoinImageService.swift
//  MZCryptoApp
//
//  Created by Mahmoud Zinji on 2022-10-17.
//

import Foundation
import Combine
import SwiftUI

class CoinImageService {

    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel

    init(coin: CoinModel) {
        self.coin = coin
        getCoinsImage()
    }

    private func getCoinsImage() {
        guard let url = URL(string: coin.image) else { return }

        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}
