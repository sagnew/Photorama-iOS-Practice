//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Sam Agnew on 1/21/16.
//  Copyright © 2016 Sam Agnew. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchRecentPhotos() {
            (photosResult) -> Void in
            
            switch photosResult {
            case let .Success(photos):
                print("Successfully found \(photos.count) photos")
                
                if let firstPhoto = photos.first {
                    self.store.fetchImageForPhoto(firstPhoto) {
                        (ImageResult) -> Void in
                        
                        switch ImageResult {
                        case let .Success(image):
                            NSOperationQueue.mainQueue().addOperationWithBlock {
                                self.imageView.image = image
                            }
                        case let .Failure(error):
                            print("Error downloading image: \(error)")
                        }
                    }
                }
            case let .Failure(error):
                print("Error fetching recent photos: \(error)")
            }
        }
    }
    
}
