//
//  HeaderView.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 30.11.2023.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func backAction()
    func saveAction()
    func deleteAction(id: Int?)
}

class HeaderView: UIView {

    weak var delegate: HeaderViewDelegate?

    var movieDetails: MovieDetails? {
        didSet {
            updateUI()
        }
    }

    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "testImage")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .customDarkGray
        button.backgroundColor = .customLightGray
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        button.tintColor = .customDarkGray
        button.backgroundColor = .customLightGray
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        return button
    }()

    var containerViewHeight = NSLayoutConstraint()
    var imageViewHeight = NSLayoutConstraint()
    var imageViewBottom = NSLayoutConstraint()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupLayout()
        setupContsraints()
    }
    
    private func updateUI() {
        guard let movieDetails = movieDetails else { return }
        checkIsFavourite()

        if let path = movieDetails.posterPath {
            let mock = URLs.imageBaseURL + path
            let url = URL(string: mock)
            let placeholder = UIImage(named: "testImage")
            headerImageView.kf.setImage(with: url, placeholder: placeholder, options: [.backgroundDecode])
        }
    }
    
    func checkIsFavourite() {
        guard let movieDetails = movieDetails else { return }
        
        let favorites = RealmManager.shared.fetch()
        
        if favorites.contains(where: { $0.id == movieDetails.id }) {
            saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            saveButton.tintColor = .customOrange
        } else {
            saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }

    @objc private func backTapped() {
        delegate?.backAction()
    }
    
    @objc private func saveTapped() {
        guard let movieDetails = movieDetails else { return }
        let favorites = RealmManager.shared.fetch()
        
        if favorites.contains(where: { $0.id == movieDetails.id }) {
            saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            delegate?.deleteAction(id: movieDetails.id)
        } else {
            saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            saveButton.tintColor = .customOrange
            delegate?.saveAction()
        }
    }
}

extension HeaderView {
    private func setupLayout() {
        addSubview(headerView)
        headerView.addSubview(headerImageView)
        headerImageView.addSubview(backButton)
        headerImageView.addSubview(saveButton)
    }

    private func setupContsraints() {
        containerViewHeight = headerView.heightAnchor.constraint(equalTo: heightAnchor)
        imageViewBottom = headerImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        imageViewHeight = headerImageView.heightAnchor.constraint(equalTo: headerView.heightAnchor, constant: 60)
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: headerImageView.widthAnchor),
            containerViewHeight,
            imageViewBottom,
            imageViewHeight,

            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            backButton.topAnchor.constraint(equalTo: headerImageView.topAnchor, constant: 64),
            backButton.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 32),
            backButton.widthAnchor.constraint(equalToConstant: 32),

            saveButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            saveButton.trailingAnchor.constraint(equalTo: headerImageView.trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 32),
            saveButton.widthAnchor.constraint(equalToConstant: 32)
        ])
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        headerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
