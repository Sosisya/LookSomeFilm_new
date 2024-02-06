//
//  HomeView.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import UIKit
import SnapKit

protocol HomeViewProtocol: AnyObject {
    func displayData(viewModel: [HomeModel])
    func displayError()
}

final class HomeView: UIView {

    var interactor: HomeInteractorProtocol?
    var router: HomeRouter?

    var model: [HomeModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    private lazy var collectionView: UICollectionView = {
        let layout = HomeCompositionalLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout.createLayout())
        collection.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.cellId())
        collection.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FooterCollectionReusableView.cellId())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        return collection
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .white

        addSubview(collectionView)
        
        collectionView.snp.remakeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension HomeView: HomeViewProtocol {
    func displayData(viewModel: [HomeModel]) {
        model = viewModel
    }

    func displayError() {
        showAlert()
    }

    func showAlert() {
        let alertController = UIAlertController(title: "Error", message: "Error", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        router?.presentAlert(alert: alertController)
    }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        model.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        let section = model[section]

        switch section.section {
        case .nowPlaying(let nowPlaying):
            return nowPlaying.count
        case .upcoming(let upcoming):
            return upcoming.count
        case .topRated(let topRated):
            return topRated.count
        case .popular(let popular):
            return popular.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let section = model[indexPath.section]

        switch section.section {
        case .popular(let popular):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.cellId(), for: indexPath) as? HomeCell {
                cell.movie = popular[indexPath.item]
                return cell
            }
        case .upcoming(let upcoming):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.cellId(), for: indexPath) as? HomeCell {
                cell.movie = upcoming[indexPath.item]
                return cell
            }
        case .topRated(let topRated):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.cellId(), for: indexPath) as? HomeCell {
                cell.movie = topRated[indexPath.item]
                return cell
            }
        case .nowPlaying(let nowPlaying):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.cellId(), for: indexPath) as? HomeCell {
                cell.movie = nowPlaying[indexPath.item]
                return cell
            }
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 42)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let section = model[indexPath.section]

        switch section.section {
        case .popular(_):
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.cellId(), for: indexPath) as? FooterCollectionReusableView {
                header.headerModel = section
                return header
            }
        case .upcoming(_):
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.cellId(), for: indexPath) as? FooterCollectionReusableView {
                header.headerModel = section
                return header
            }
        case .topRated(_):
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.cellId(), for: indexPath) as? FooterCollectionReusableView {
                header.headerModel = section
                return header
            }
        case .nowPlaying(_):
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.cellId(), for: indexPath) as? FooterCollectionReusableView {
                header.headerModel = section
                return header
            }
        }
        return UICollectionReusableView()
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var id: Int?
        let section = model[indexPath.section]

        switch section.section {
        case .nowPlaying(let nowPlaying):
            let object = nowPlaying[indexPath.item]
            id = object.id

        case .upcoming(let upcoming):
            let object = upcoming[indexPath.item]
            id = object.id

        case .topRated(let topRated):
            let object = topRated[indexPath.item]
            id = object.id

        case .popular(let popular):
            let object = popular[indexPath.item]
            id = object.id
        }
        router?.presentMovieDetails(id: id)
    }
}
