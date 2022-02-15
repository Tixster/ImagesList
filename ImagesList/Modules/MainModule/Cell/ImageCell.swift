//
//  ImageCell.swift
//  ImagesList
//
//  Created by Кирилл Тила on 15.02.2022.
//

import UIKit

class ImageCell: UITableViewCell {
    
    enum Size {
        static let height = UIScreen.main.bounds.width
        static let width = UIScreen.main.bounds.width
    }
    
    static let reuseID = String(describing: self)
    private var webImageView: WebImageView = {
        let view = WebImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.webImageView.frame = CGRect(origin: .zero,
                                         size: CGSize(width: Size.width,
                                                      height: Size.height))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.webImageView.image = nil
    }
    
    private func setup() {
        contentView.addSubview(webImageView)
    }
    
    func set(imageURL: String?, index: Int) {
        self.webImageView.set(imageURL: imageURL, index: index)
    }
    
    func set(fromStore item: StoreImage) {
        do {
            let data = try Data(contentsOf: item.path)
            webImageView.image = UIImage(data: data)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
