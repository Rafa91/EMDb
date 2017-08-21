//
//  MovieViewController.swift
//  EMDb
//
//  Created by Rafael Navarro on 28/3/17.
//  Copyright © 2017 Rafael Navarro. All rights reserved.
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController {

    @IBOutlet weak var btnFavorite : UIButton!
    @IBOutlet weak var movieImage : UIImageView!
    @IBOutlet weak var movieSummary : UITextView!
    @IBOutlet weak var movieTitle : UILabel!
    @IBOutlet weak var movieCategory : UILabel!
    @IBOutlet weak var movieDirector : UILabel!
    
    let dataProvider = LocalCoreDataService()
    var movie : Movie?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let movie = movie{
            if let image = movie.image{
                movieImage.kf.setImage(with: ImageResource(downloadURL: URL(string: image)!))
            }
            movieTitle.text = movie.title
            self.title = movie.title
            movieSummary.text = movie.summary
            movieDirector.text = movie.director
            movieCategory.text = movie.category
            
            configureFavoriteButton()
        }
    }
    
    func configureFavoriteButton(){
        if let movie = self.movie{
            if dataProvider.isMovieFavorite(movie: movie){
                btnFavorite.setBackgroundImage(#imageLiteral(resourceName: "btn-on"), for: .normal)
                btnFavorite.setTitle("quiero verla", for: .normal)
            }else{
                btnFavorite.setBackgroundImage(#imageLiteral(resourceName: "btn-off"), for: .normal)
                btnFavorite.setTitle("no me interesa", for: .normal)
            }
        }
    }
    
    @IBAction func favoritePressed(_ sender: UIButton) {
        
        if let movie = self.movie{
            dataProvider.markUnmarkFavorite(movie: movie)
            configureFavoriteButton()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        movieSummary.scrollRangeToVisible(NSMakeRange(0, 0))
    }
}
