//
//  MovieListViewController.swift
//  Flix
//
//  Created by Weirong Wu on 10/3/2020.
//  Copyright © 2020 Weirong Wu. All rights reserved.
//


import UIKit


class SuperHeroCollectionViewController: UICollectionViewController{
    
    let apiUrl = "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    let baseBackdropUrl = "https://image.tmdb.org/t/p/original"
    
    var tableData : [[String:Any]]?
    
    private let reuseIdentifier = "posterCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Superhero"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.collectionView.backgroundColor = .systemBackground
        
        // Register cell classes
        self.collectionView!.register(posterCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let width = self.view.frame.size.width/2 - 1
        let height = 750/500 * width
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 1
        
        collectionView.contentInsetAdjustmentBehavior = .always
        
        downloadData()
        

        // Do any additional setup after loading the view.
    }
    
    func downloadData() {
        guard let url = URL(string: apiUrl) else { return }
                
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error")
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.tableData = dataDictionary["results"] as? [[String: Any]]
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }.resume()
    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return tableData?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! posterCollectionCell
        
        if let imgURl = tableData?[indexPath.row]["poster_path"] {
            cell.posterImage.loadImage(url: baseImageUrl + (imgURl as! String))
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = DetailViewController()
        
        if let movieTitle = tableData?[indexPath.row]["title"] {
            detail.movieTitle.text = movieTitle as? String
        }
        
        if let releaseDate = tableData?[indexPath.row]["release_date"] {
            detail.releaseDate.text = releaseDate as? String
        }
        
        if let desc = tableData?[indexPath.row]["overview"] {
            detail.desc.text = desc as? String
        }
        
        if let backdropUrl = tableData?[indexPath.row]["backdrop_path"] {
            detail.backdropView.loadImage(url: baseBackdropUrl + (backdropUrl as! String))
        }
        
        if let posterURl = tableData?[indexPath.row]["poster_path"] {
            detail.posterView.loadImage(url: baseImageUrl + (posterURl as! String))
        }
        
        self.navigationController?.pushViewController(detail, animated: true)
    }

}

class posterCollectionCell: UICollectionViewCell {
    
    let posterImage: PosterImageView = {
        let posterImage = PosterImageView()
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
        return posterImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(posterImage)
        
        posterImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        posterImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        posterImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        posterImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        posterImage.widthAnchor.constraint(equalTo: posterImage.heightAnchor, multiplier: 500/750
        ).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
