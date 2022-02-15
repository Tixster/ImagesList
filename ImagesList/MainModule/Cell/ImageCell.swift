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
    private var imageViewCell: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .black
        label.text = "BLABLABLA"
        label.numberOfLines = 1
        return label
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
        self.imageViewCell.frame = CGRect(origin: .zero,
                                          size: CGSize(width: Size.width,
                                                       height: Size.height - 20))
        self.label.frame = CGRect(x: .zero,
                                  y: imageViewCell.frame.maxY,
                                  width: Size.width,
                                  height: Size.height - imageViewCell.frame.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageViewCell.image = nil
        self.label.text = nil
    }
    
    private func setup() {
        contentView.addSubview(imageViewCell)
        contentView.addSubview(label)
    }
    
    func set(image: UIImage?, text: String) {
        self.imageViewCell.image = image
        self.label.text = text
    }
    
}
