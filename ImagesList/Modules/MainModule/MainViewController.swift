//
//  MainViewController.swift
//  ImagesList
//
//  Created by Кирилл Тила on 15.02.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainPresenterLogic!
    
    private var isImageLoaded = false
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .white
        table.separatorInset = .zero
        table.register(ImageCell.self, forCellReuseIdentifier: ImageCell.reuseID)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.getImagesList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setup() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        view.addSubview(tableView)
    }
    
}

extension MainViewController: MainPresenterDelegate {
    
    func imagesDidFetch() {
        isImageLoaded = true
        tableView.reloadData()
    }
    
    func imagesDidFetchError(error: Error) {
        
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !presenter.encodeStoredImages.isEmpty && !isImageLoaded {
            return presenter.encodeStoredImages.count
        }
        return presenter.imagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.reuseID,
                                                       for: indexPath) as? ImageCell
        else {
            return ImageCell()
        }
        if !presenter.encodeStoredImages.isEmpty && !isImageLoaded {
            cell.set(fromStore: presenter.encodeStoredImages[indexPath.row])
        } else {
            let imageURL = presenter.imagesList[indexPath.row].url
            cell.set(imageURL: imageURL, index: indexPath.row)
        }
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageFileManager = DIConteiner.shared.resolve(type: ImageModelFileManagerLogic.self)!
        let image = imageFileManager.encodeImageItems[indexPath.row]
        presenter.showDetail(imageItem: image)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ImageCell.Size.height
    }
    
}
