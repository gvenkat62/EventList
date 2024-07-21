//
//  EventTableViewCell.swift
//  EventsApp
//
//  Created by Venkat on 7/18/24.
//

import Foundation

import UIKit

class EventTableViewCell: UITableViewCell {
    
    let canFavouriteIconObservable = Observable(false)
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
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .systemPink
        button.isHidden = false
        return button
    }()
    
    var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        return view
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
        
        
        self.containerView.addSubview(productImage)
        self.containerView.addSubview(favButton)
        self.containerView.addSubview(productTitleLabel)
        self.containerView.addSubview(productDescriptionLabel)
        contentView.addSubview(containerView)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 10),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            
            productImage.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20),
            productImage.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor,constant: -15),
            productImage.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            productImage.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,constant: 15),
            productImage.widthAnchor.constraint(equalToConstant: 100),
            
            favButton.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            favButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            favButton.heightAnchor.constraint(equalToConstant: 40),
            favButton.widthAnchor.constraint(equalToConstant: 40),
            
            productTitleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor,constant: 15),
            productTitleLabel.leadingAnchor.constraint(equalTo: self.productImage.trailingAnchor,constant: 15),
            productTitleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -15),
            productTitleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: self.productTitleLabel.bottomAnchor,constant: 5),
            productDescriptionLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor,constant: -15),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: self.productImage.trailingAnchor,constant: 15),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -15),
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
    
    func bindData(){
        
        if let item = self.item{
            self.productTitleLabel.text = item.title
            if let imageUrlString = item.images?[0], let imageUrl = URL(string: imageUrlString){
                self.productImage.kf.setImage(with:imageUrl)
            }
            self.productDescriptionLabel.text = item.description
            let isFavourite =  UserDefaults.standard.bool(forKey: "\(String(describing: item.id))")
            self.updateFavouriteIcon(isFav: isFavourite)
        }
    }
    
    func updateFavouriteIcon(isFav:Bool){
        if isFav{
            self.favButton.isHidden = false
        }else{
            self.favButton.isHidden = true
        }
    }
}

