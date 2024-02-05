//
//  FooterCellTableViewCell.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 05.12.2023.
//

import UIKit

protocol FooterCellDelegate: AnyObject {
    func actionFooterButton()
}

class FooterCell: UITableViewCell {

    static func cellId() -> String {
        String(describing: FooterCell.self)
    }

    weak var delegate: FooterCellDelegate?

    private lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = CastAndCrewTitles.headerTitle
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()

    private lazy var footerButton: UIButton = {
        let button = UIButton()
        button.setTitle(CastAndCrewTitles.headerButtonTitle, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(footerButtonTapped), for: .touchUpInside)
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
        contentView.addSubview(footerLabel)
        contentView.addSubview(footerButton)

        footerLabel.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.left.equalToSuperview().inset(16)
        }

        footerButton.snp.remakeConstraints {
            $0.left.equalTo(footerLabel.snp.right).offset(8)
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalTo(footerLabel.snp.centerY)
        }
    }

    @objc func footerButtonTapped() {
        delegate?.actionFooterButton()
    }
}
