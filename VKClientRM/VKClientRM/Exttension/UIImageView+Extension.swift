//
//  UIImageView+Extension.swift
//  VKClientRM
//
//  Created by Dima Kovrigin on 30.11.2022.



import UIKit

/// Установка изображения в UIImageView по ссылке из сети
extension UIImageView {
    // MARK - Public Methods
    func setupImage(urlPath: String?, networkService: VKNetworkService) {
        networkService.loadData(urlPath: urlPath) { [weak self] data in
            guard
                let self = self,
                let data = data
            else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
