//
//  NavigationView.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 27.01.2024.
//

import UIKit
import SnapKit

protocol NavigationViewDelegate: AnyObject {
    func back()
    func action()
}

class NavigationView: UIView {

    weak var delegate: NavigationViewDelegate?

    private lazy var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .customDarkGray
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()

    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowshape.backward.fill"), for: .normal)
        button.tintColor = .customDarkGray
        button.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        return button
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
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
        layer.shadowColor = UIColor.customDarkGray?.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 4)

        addSubview(navigationView)
        navigationView.addSubview(backButton)
        navigationView.addSubview(actionButton)
        navigationView.addSubview(titleLabel)

        navigationView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }

        backButton.snp.remakeConstraints {
            $0.centerY.equalTo(navigationView.snp.centerY)
            $0.left.equalToSuperview().inset(16)
        }

        actionButton.snp.remakeConstraints {
            $0.centerY.equalTo(navigationView.snp.centerY)
            $0.right.equalToSuperview().inset(16)
        }

        titleLabel.snp.remakeConstraints {
            $0.centerY.equalTo(navigationView.snp.centerY)
            $0.centerX.equalToSuperview()
        }
    }

    @objc func backTapped() {
        delegate?.back()
    }

    @objc func actionTapped() {
        delegate?.action()
    }
}

