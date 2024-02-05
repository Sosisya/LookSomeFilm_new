//
//  GenreCollectionViewCell.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 19.11.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class GenreCell: UICollectionViewCell {
    static func cellId() -> String {
        String(describing: GenreCell.self)
    }

    var genres: Genre? {
        didSet {
            updateUI()
        }
    }

    private lazy var genreImageView: UIImageView = {
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

    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
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
        shadowView.addSubview(genreImageView)
        contentView.addSubview(genreLabel)

        shadowView.snp.remakeConstraints {
            $0.top.equalTo(contentView).inset(4)
            $0.leading.trailing.equalTo(contentView).inset(8)
            $0.height.equalTo(260)
            $0.width.equalTo(150)
        }

        genreImageView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }

        genreLabel.snp.remakeConstraints {
            $0.top.equalTo(genreImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(contentView).inset(12)
            $0.bottom.equalTo(contentView).inset(4)
        }
    }

    private func updateUI() {
        guard let genres = genres else { return }

        if let genre = genres.name {
            genreImageView.image = UIImage(named: genre)
            genreLabel.text = genre
        }
    }

    override func prepareForReuse() {
        genreImageView.kf.cancelDownloadTask()
        genreImageView.image = nil
    }
}
