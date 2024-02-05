//
//  HomeCell.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 31.01.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class HomeCell: UICollectionViewCell {
    static func cellId() -> String {
        String(describing: HomeCell.self)
    }

    var movie: Result? {
        didSet {
            updateUI()
        }
    }

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "testImage")
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    private lazy var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.customDarkGray?.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.isHidden = false
        return stackView
    }()

    private lazy var raitingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.isHidden = true
        return stackView
    }()

    private lazy var raitingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .customGreen
        return imageView
    }()

    private lazy var raitingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .customDarkGray
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(shadowView)
        shadowView.addSubview(imageView)
        contentView.addSubview(nameStackView)
        nameStackView.addArrangedSubview(titleLabel)
        nameStackView.addArrangedSubview(raitingStackView)
        raitingStackView.addArrangedSubview(raitingImage)
        raitingStackView.addArrangedSubview(raitingLabel)

        shadowView.snp.remakeConstraints {
            $0.top.equalTo(contentView).inset(4)
            $0.leading.trailing.equalTo(contentView).inset(8)
            $0.height.equalTo(260)
            $0.width.equalTo(150)
        }

        imageView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }

        nameStackView.snp.remakeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(contentView).inset(12)
            $0.bottom.equalTo(contentView).inset(4)
        }
    }

    private func updateUI() {
        raitingStackView.isHidden = false

        guard let movie = movie else { return }

        if let path = movie.posterPath {
            let mock = URLs.imageBaseURL + path
            let url = URL(string: mock)
            let placeholder = UIImage(named: "testImage")
            imageView.kf.setImage(with: url, placeholder: placeholder, options: [.backgroundDecode])
        }
        if let voteAverage = movie.voteAverage {
            raitingLabel.text = String(format:"%.01f", voteAverage)
            raitingImage.tintColor = voteAverage < 6.9 ? .customDarkGray : .customGreen
        }
        titleLabel.text = movie.title
    }

    override func prepareForReuse() {
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
}
