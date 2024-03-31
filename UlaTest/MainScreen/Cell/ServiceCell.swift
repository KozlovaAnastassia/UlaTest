//
//  ServiceCell.swift
//  UlaTest
//
//  Created by Анастасия on 31.03.2024.
//

import UIKit

private enum Metrics {
    static let cornerRadius = 12.0
    static let verticalSpacing = 5.0
    static let horizontalSpacing = 20.0
    static let imageSize = 50.0
    static let leadingOffset = 16.0
    static let trailingOffset = -16.0
}

final class ServiceCell: UITableViewCell {

    //MARK: -> Properties
    static var reuseIdentifier: String {"\(Self.self)"}
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.titleFont
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.descriptionFont
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.textColor = .white
        return label
    }()

    let serviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Metrics.cornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = Metrics.verticalSpacing
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(descriptionLabel)
        return stack
    }()

    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = Metrics.horizontalSpacing
        stack.addArrangedSubview(serviceImageView)
        stack.addArrangedSubview(verticalStack)
        return stack
    }()

    //MARK: -> init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }

    //MARK: -> Functions

    override func prepareForReuse() {
        titleLabel.text = ""
        descriptionLabel.text = ""
        serviceImageView.image = nil
    }
    
    private func setupViews() {
        contentView.addSubview(horizontalStack)
        let margins = contentView.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: margins.topAnchor),
            horizontalStack.leadingAnchor.constraint(
                                            equalTo: margins.leadingAnchor,
                                            constant: Metrics.leadingOffset
                                            ),
            
            horizontalStack.trailingAnchor.constraint(
                                            equalTo: margins.trailingAnchor,
                                            constant: Metrics.trailingOffset
                                            ),
            horizontalStack.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            serviceImageView.heightAnchor.constraint(equalToConstant: Metrics.imageSize),
            serviceImageView.widthAnchor.constraint(equalToConstant: Metrics.imageSize)
        ])
    }
    

    func configure(model: CellModel) {
        DispatchQueue.main.async {
            self.serviceImageView.loadImage(withURL: model.iconUrl, placeholder: UIImage(named: Constants.Images.placeHolder), id: model.id)
        }
        descriptionLabel.text = model.description
        titleLabel.text = model.name
    }
}


