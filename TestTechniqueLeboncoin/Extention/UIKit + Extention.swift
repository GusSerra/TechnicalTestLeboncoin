//
//  UIKit + Extention.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 21/02/2022.
//

import UIKit

extension UIImageView {
  func loadImage(from url: URL?) {
    guard let safeURL = url else { return }

    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: safeURL) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      }
    }
  }
}
