//
//  MovieListViewController.swift
//  Flix
//
//  Created by Weirong Wu on 10/3/2020.
//  Copyright © 2020 Weirong Wu. All rights reserved.
//

import UIKit

class MovieListViewController: UITableViewController {
    
    var tableData : [[String:Any]]?
    
    let apiUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    let baseBackdropUrl = "https://image.tmdb.org/t/p/original"
    
    override func viewDidLoad() {
        
        self.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = 120
        
        downloadData()
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
                    self.tableView.reloadData()
                }
            }
        }.resume()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell",for: indexPath) as! MovieCell
        
        if let title = tableData?[indexPath.row]["title"] {
            cell.title.text = title as? String
        }
        
        if let desc = tableData?[indexPath.row]["overview"] {
            cell.desc.text = desc as? String
        }
        
        if let imgURl = tableData?[indexPath.row]["poster_path"] {
            cell.posterImage.loadImage(url: baseImageUrl + (imgURl as! String))
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

class MovieCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    let posterImage : PosterImageView = {
        let image = PosterImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    let title : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let desc : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 3
        return label
    }()
    
    func setupUI() {
        contentView.addSubview(posterImage)
        contentView.addSubview(title)
        contentView.addSubview(desc)
                
        posterImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        posterImage.widthAnchor.constraint(equalTo: posterImage.heightAnchor, multiplier: 500/750).isActive = true
        
        title.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 20).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        title.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        
        desc.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16).isActive = true
        desc.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 20).isActive = true
        desc.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        desc.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
