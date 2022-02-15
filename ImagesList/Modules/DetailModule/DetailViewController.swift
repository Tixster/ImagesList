//
//  DetailViewController.swift
//  ImagesList
//
//  Created by Кирилл Тила on 16.02.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    enum ImageSize {
        static let height = UIScreen.main.bounds.width
        static let width = UIScreen.main.bounds.width
    }
    
    var presenter: DetailPresenterLogic!
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame.size = CGSize(width: ImageSize.width,
                                      height: ImageSize.width)
        imageView.center = view.center
        label.frame = CGRect(x: 20,
                             y: imageView.frame.maxY + 5,
                             width: ImageSize.width - 20,
                             height: 20)
    }
    
    private func setup() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        presenter.setImageItem()
        view.addSubview(imageView)
        view.addSubview(label)
    }
    
}

extension DetailViewController: DetailPresenterDelegate {
    
    func setImageContent(imageItem: StoreImage) {
        do {
            let data = try Data(contentsOf: imageItem.path)
            imageView.image = UIImage(data: data)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        label.text = "\(imageItem.date)"
    }
    
}
