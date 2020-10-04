//
//  MovieListViewController.swift
//  Flix
//
//  Created by Weirong Wu on 10/3/2020.
//  Copyright © 2020 Weirong Wu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
        
    let posterView: PosterImageView = {
        let posterView = PosterImageView()
        posterView.translatesAutoresizingMaskIntoConstraints = false
        posterView.contentMode = .scaleAspectFit
        posterView.clipsToBounds = true
        posterView.layer.borderWidth = 2
        posterView.layer.borderColor = UIColor.systemGray6.cgColor
        return posterView
    }()
    
    let backdropView: PosterImageView = {
        let backdropView = PosterImageView()
        backdropView.translatesAutoresizingMaskIntoConstraints = false
        backdropView.contentMode = .scaleAspectFill
        backdropView.clipsToBounds = true
        return backdropView
    }()
    
    let movieTitle: UILabel = {
        let movieTitle = UILabel()
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.font = UIFont.preferredFont(forTextStyle: .title1)
        movieTitle.adjustsFontForContentSizeCategory = true
        movieTitle.adjustsFontSizeToFitWidth = true
        movieTitle.minimumScaleFactor = 0.5
        movieTitle.numberOfLines = 2
        return movieTitle
    }()
    
    let releaseDate: UILabel = {
        let movieTitle = UILabel()
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        movieTitle.adjustsFontForContentSizeCategory = true
        movieTitle.adjustsFontSizeToFitWidth = true
        movieTitle.minimumScaleFactor = 0.5
        return movieTitle
    }()
    
    let desc: UITextView = {
        let desc = UITextView()
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.font = UIFont.preferredFont(forTextStyle: .body)
        desc.adjustsFontForContentSizeCategory = true
        desc.isEditable = false
        desc.sizeToFit()
        return desc
    }()
    
    override func viewDidLoad() {
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(backdropView)
        view.addSubview(posterView)
        view.addSubview(movieTitle)
        view.addSubview(releaseDate)
        view.addSubview(desc)
                
        backdropView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backdropView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backdropView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backdropView.heightAnchor.constraint(equalTo: backdropView.widthAnchor).isActive = true
        
        posterView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        posterView.widthAnchor.constraint(equalTo: backdropView.widthAnchor, multiplier: 1/3).isActive = true
        posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 750/500).isActive = true
        posterView.centerYAnchor.constraint(equalTo: backdropView.bottomAnchor, constant: 0).isActive = true
        
        movieTitle.topAnchor.constraint(equalTo: backdropView.bottomAnchor, constant: 8).isActive = true
        movieTitle.leftAnchor.constraint(equalTo: posterView.rightAnchor, constant: 16).isActive = true
        movieTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        releaseDate.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 8).isActive = true
        releaseDate.leftAnchor.constraint(equalTo: posterView.rightAnchor, constant: 16).isActive = true
        releaseDate.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        desc.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 16).isActive = true
        desc.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        desc.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        desc.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        
    }
}
