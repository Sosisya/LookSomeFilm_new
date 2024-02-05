//
//  MovieTitleCell.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 05.12.2023.
//

import UIKit
import SnapKit

class MovieTitleCell: UITableViewCell {

    static func cellId() -> String {
        String(describing: MovieTitleCell.self)
    }

    var movieDetails: MovieDetails? {
        didSet {
            updateUI()
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    private lazy var raitingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()

    private lazy var raitingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .customGreen
        return imageView
    }()

    private lazy var raitingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .customDarkGray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateUI() {
        guard let movieDetails = movieDetails else { return }
        
        if let duration = movieDetails.runtime {
            durationLabel.text = "Duration: \(String(describing: duration)) min."
        }
        
        if let voteAverage = movieDetails.voteAverage {
            raitingLabel.text = String(format:"%.01f", voteAverage)
            raitingImageView.tintColor = voteAverage < 6.9 ? .customDarkGray : .customGreen
        }
        
        descriptionLabel.text = movieDetails.overview
        titleLabel.text = movieDetails.title
    }

    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(raitingStackView)
        raitingStackView.addArrangedSubview(raitingImageView)
        raitingStackView.addArrangedSubview(raitingLabel)
        contentView.addSubview(durationLabel)
        contentView.addSubview(descriptionLabel)

        titleLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        raitingStackView.snp.remakeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }

        durationLabel.snp.remakeConstraints {
            $0.top.equalTo(raitingStackView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.remakeConstraints {
            $0.top.equalTo(durationLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
