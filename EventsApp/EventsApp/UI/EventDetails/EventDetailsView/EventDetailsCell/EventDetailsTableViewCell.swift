//
//  EventDetailsTableViewCell.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Foundation

import UIKit

class EventDetailsCell: UITableViewCell {
    
    
    var item: Products?

    var productImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 5.0
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var favButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemPink
        
        return button
    }()
    
    var productTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var productDescriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(productImage)
        contentView.addSubview(favButton)
        contentView.addSubview(productTitleLabel)
        contentView.addSubview(productDescriptionLabel)
        self.selectionStyle = .none
        favButton.addTarget(self, action: #selector(actionFavourite), for: .touchUpInside)

        NSLayoutConstraint.activate([

            productTitleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10),
            productTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 10),
            //productTitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            productTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            favButton.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10),
            favButton.leadingAnchor.constraint(equalTo: self.productTitleLabel.trailingAnchor,constant: 10),
            favButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            favButton.heightAnchor.constraint(equalToConstant: 40),
            favButton.widthAnchor.constraint(equalToConstant: 40),


            productImage.topAnchor.constraint(equalTo: self.productTitleLabel.bottomAnchor, constant: 10),
            productImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 200),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: self.productImage.bottomAnchor,constant: 10),
            productDescriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -10),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 10),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func actionFavourite(){
        if let item = self.item
        {
            let isFav =  UserDefaults.standard.bool(forKey: "\(String(describing: item.id))")
            UserDefaults.standard.set(isFav ? false : true, forKey: "\(String(describing: item.id))")
            self.favButton.setImage(isFav ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill"), for: .normal)
        }

    }
    
    func bindData(){
        
        if let item = self.item
        {
            self.productTitleLabel.text = item.title
            if let imageUrlString = item.images?[0], let imageUrl = URL(string: imageUrlString){
                self.productImage.kf.setImage(with:imageUrl)
            }
            
            self.productDescriptionLabel.text = item.description
            let isFav =  UserDefaults.standard.bool(forKey: "\(String(describing: item.id))")
            self.favButton.setImage(isFav ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        }
    }
    
}
