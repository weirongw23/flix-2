//
//  MovieListViewController.swift
//  Flix
//
//  Created by Weirong Wu on 10/3/2020.
//  Copyright © 2020 Weirong Wu. All rights reserved.
//


import UIKit

class PosterImageView: UIImageView {
    
    var imageUrl:String = ""
    
    func loadImage(url: String) {
        imageUrl = url
        
        image = nil
        
        guard let imgUrl = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: imgUrl) { (data, response, erro) in
            if erro != nil {
                print("Error Occured Getting Image")
                return
            }
            
            guard let data = data else { return }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if imgUrl.absoluteString == self.imageUrl {
                        self.image = image
                    } else {
                        self.image = nil
                    }
                }
            }
            
        }.resume()
    }
    
}
