//
//  CastAndCrewCell.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 05.12.2023.
//

import UIKit
import Kingfisher
import SnapKit

class CastAndCrewCell: UITableViewCell {

    static func cellId() -> String {
        String(describing: CastAndCrewCell.self)
    }

    var castAndCrew: Cast? {
        didSet {
            updateUI()
        }
    }

    private lazy var personImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(named: CastAndCrewTitles.defaultImageName)
        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var personNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .customDarkGray
        return label
    }()

    private lazy var personRoleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        label.textColor = .lightGray
        return label
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

        contentView.addSubview(personImage)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(personNameLabel)
        stackView.addArrangedSubview(personRoleLabel)

        personImage.snp.remakeConstraints { 
            $0.height.equalTo(40)
            $0.width.equalTo(40)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
        }

        stackView.snp.remakeConstraints {
            $0.centerY.equalTo(personImage.snp.centerY)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.left.equalTo(personImage.snp.right).offset(8)
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    private func updateUI() {
        guard let castAndCrew = castAndCrew else { return }

        if let path = castAndCrew.profilePath {
            let mock = URLs.imageBaseURL + path
            let url = URL(string: mock)
            let placeholder = UIImage(named: CastAndCrewTitles.defaultImageName)
            personImage.kf.setImage(with: url, placeholder: placeholder, options: [.backgroundDecode])
        }

        personNameLabel.text = castAndCrew.name
        personRoleLabel.text = castAndCrew.character

        if castAndCrew.character == nil {
            personRoleLabel.text = castAndCrew.job
        }
    }
}
