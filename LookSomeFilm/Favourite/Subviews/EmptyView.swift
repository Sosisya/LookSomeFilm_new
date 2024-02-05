//
//  EmptyView.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 29.01.2024.
//

import UIKit
import SnapKit

class EmptyView: UIView {

    private lazy var emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()

    private lazy var emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "tray")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .lightGray
        return imageView
    }()

    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = EmptyViewTitle.title
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(emptyView)
        emptyView.addSubview(stackView)
        stackView.addArrangedSubview(emptyImageView)
        stackView.addArrangedSubview(textLabel)

        emptyView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }

        emptyImageView.snp.remakeConstraints {
            $0.height.width.equalTo(100)
        }

        stackView.snp.remakeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.width.equalTo(200)
        }
    }
}
