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
    private let fileManager = LocalFileManager.instance
    private let foldername = "coin_images"
    private let imageName: String

    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }

    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: foldername) {
            self.image = savedImage
            print("Retrieved Image from File Manager")
        } else {
            downloadCoinsImage()
            print("Downloading Image Now")
        }
    }

    private func downloadCoinsImage() {
        guard let url = URL(string: coin.image) else { return }

        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.foldername)
            })
    }
}
