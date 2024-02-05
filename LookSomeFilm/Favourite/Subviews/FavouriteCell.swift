//
//  FsvouriteCell.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 31.01.2024.
//

import UIKit
import Kingfisher
import RealmSwift

protocol FavouriteCellDelegate: AnyObject {
    func deleteFromFavourite(object: FavouriteModel)
}

class FavouriteCell: UITableViewCell {

    weak var delegate: FavouriteCellDelegate?

    static func cellId() -> String {
        String(describing: FavouriteCell.self)
    }

    var favouriteModel: FavouriteModel? {
        didSet {
            updateUI()
        }
    }

    private lazy var movieBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.customDarkGray?.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        return view
    }()

    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    private lazy var movieTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()

    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private lazy var releaseDateOfMovieLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private lazy var scoreOfMovieStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()

    private lazy var scoreOfMovieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .customDarkGray
        return imageView
    }()

    private lazy var scoreOfMovieLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .customDarkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private lazy var favouriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .customOrange
        button.addTarget(self, action: #selector(deleteObject), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear

        contentView.addSubview(movieBackgroundView)
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitleStackView)
        movieBackgroundView.addSubview(favouriteButton)
        movieTitleStackView.addArrangedSubview(movieTitleLabel)
        movieTitleStackView.addArrangedSubview(releaseDateOfMovieLabel)
        movieTitleStackView.addArrangedSubview(scoreOfMovieStackView)
        scoreOfMovieStackView.addArrangedSubview(scoreOfMovieImageView)
        scoreOfMovieStackView.addArrangedSubview(scoreOfMovieLabel)

        movieBackgroundView.snp.remakeConstraints {
            $0.left.right.equalToSuperview().inset(12)
            $0.top.equalToSuperview().inset(64)
            $0.bottom.equalToSuperview().inset(8)
        }

        favouriteButton.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(-3)
            $0.right.equalToSuperview().inset(16)
        }

        movieImageView.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.bottom.equalTo(movieBackgroundView.snp.bottom).inset(12)
            $0.left.equalToSuperview().inset(32)
            $0.width.equalTo(150)
            $0.height.equalTo(200)
        }

        movieTitleStackView.snp.remakeConstraints {
            $0.top.equalTo(movieBackgroundView.snp.top).inset(20)
            $0.left.equalTo(movieImageView.snp.right).offset(16)
            $0.right.equalTo(movieBackgroundView.snp.right).inset(16)
            $0.bottom.equalTo(movieBackgroundView.snp.bottom).inset(20)
        }
    }

    private func updateUI() {
        guard let favouriteModel = favouriteModel else { return }

        if let path = favouriteModel.posterPath {
            let mock = URLs.imageBaseURL + path
            let url = URL(string: mock)
            let placeholder = UIImage(named: "testImage")
            movieImageView.kf.setImage(with: url, placeholder: placeholder, options: [.backgroundDecode])
        }

        if let movieScore = favouriteModel.voteAverage {
            let movieScoreLabel = String(format:"%.01f", movieScore)
            scoreOfMovieLabel.text = movieScoreLabel
            scoreOfMovieImageView.tintColor = movieScore < 6.9 ? .customDarkGray : .customGreen
        }
        movieTitleLabel.text = favouriteModel.title
        releaseDateOfMovieLabel.text = favouriteModel.releaseDate

        favouriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
    }

    @objc func deleteObject() {
        guard let favouriteModel = favouriteModel else { return }
        delegate?.deleteFromFavourite(object: favouriteModel)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        favouriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
    }
}

