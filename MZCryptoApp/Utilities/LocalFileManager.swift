//
//  LocalFileManager.swift
//  MZCryptoApp
//
//  Created by Mahmoud Zinji on 2022-10-17.
//

import Foundation
import SwiftUI

class LocalFileManager {

    static let instance = LocalFileManager()
    private init() {}

    func saveImage(image: UIImage, imageName: String, folderName: String) {

        // create folder
        createFolderIfNeeded(folderName: folderName)

        // get path for image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
            else { return }

        // save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving Image \n ImageName: \(imageName).\n Error description: \(error.localizedDescription)")
        }
    }

    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }

    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(name: folderName) else {
            return
        }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory. \n FolderName: \(folderName).\n Error description: \(error.localizedDescription)")
            }
        }
    }

    private func getURLForFolder(name: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(name)
    }

    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderUrl = getURLForFolder(name: folderName) else { return nil }
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
}
