//
//  GenresView.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 17.01.2024.
//

import UIKit
import SnapKit

protocol GenresViewProtocol: AnyObject {
    func displayGenres(viewModel: [Genre])
    func displayError()
}

final class GenresView: UIView {

    var interactor: GenresInteractorProtocol?
    var router: GenresRouter?

    private var genres: [Genre] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    private lazy var navigationView: NavigationView = {
        let view = NavigationView()
        view.actionButton.isHidden = true
        view.backButton.isHidden = true
        view.titleLabel.text = NavigationTitles.genres
        view.delegate = self
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = GenreCompositionalLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout.createLayout())
        collection.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.cellId())
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

        addSubview(navigationView)
        addSubview(collectionView)

        navigationView.snp.remakeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(36)
        }

        collectionView.snp.remakeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension GenresView: GenresViewProtocol {
    func displayGenres(viewModel: [Genre]) {
        genres = viewModel
    }

    func displayError() {
    #warning("JTBD: Добавить системный алерт который обсуждали")
    }
}

extension GenresView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genres.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.cellId(), for: indexPath) as? GenreCell {
            cell.genres = genres[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = genres[indexPath.item]
        let id = object.id
        let title = object.name
        router?.presentMovieSet(id: id, title: title)
    }
}

extension GenresView: NavigationViewDelegate {
    func back() { }
    func action() { }
}
