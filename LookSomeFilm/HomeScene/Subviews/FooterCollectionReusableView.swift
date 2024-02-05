//
//  FooterCollectionReusableView.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 05.12.2023.
//

import UIKit
import SnapKit

class FooterCollectionReusableView: UICollectionReusableView {
    static func cellId() -> String {
        String(describing: FooterCollectionReusableView.self)
    }

    var headerModel: HomeModel? {
        didSet {
            updateUI()
        }
    }
    
   private lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    private lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .customOrange
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        addSubview(footerLabel)
        addSubview(underlineView)
        footerLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
        underlineView.snp.remakeConstraints {
            $0.top.equalTo(footerLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalTo(footerLabel)
            $0.height.equalTo(2)
        }
    }

    func updateUI() {
        footerLabel.text = headerModel?.title
    }
}
