//
//  MoviesOfTheGenreView.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import UIKit
import SnapKit

protocol MoviesOfTheGenreViewProtocol: AnyObject {
    func displayData(id: Int, viewModel: MoviesOfGenre, title: String)
    func displayTitle(title: String)
    func displayError()
}

final class MoviesOfTheGenreView: UIView {

    var interactor: MoviesOfTheGenreInteractorProtocol?
    var router: MoviesOfTheGenreRouter?

    private var currentPage = 1
    private var currentID: Int?

    private var moviesOfTheGenre: [Result]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    private lazy var navigationView: NavigationView = {
        let view = NavigationView()
        view.actionButton.isHidden = true
        view.delegate = self
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MoviesOfTheGenreCell.self, forCellReuseIdentifier: MoviesOfTheGenreCell.cellId())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 240
        return tableView
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
        addSubview(tableView)

        navigationView.snp.remakeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(36)
        }

        tableView.snp.remakeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension MoviesOfTheGenreView: MoviesOfTheGenreViewProtocol {
    func displayData(id: Int, viewModel: MoviesOfGenre, title: String) {
        guard let movies = viewModel.results else { return }
        navigationView.titleLabel.text = title
        currentID = id

        if moviesOfTheGenre?.count ?? 0 > 0 {
            moviesOfTheGenre?.append(contentsOf: movies)
        } else {
            moviesOfTheGenre = movies
        }
    }

    func displayError() {
        debugPrint("Error")
    }

    func displayTitle(title: String) {
        navigationView.titleLabel.text = title
    }
}

extension MoviesOfTheGenreView: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            currentPage += 1
//            interactor?.getData(id: currentID, page: currentPage)
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesOfTheGenre?.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MoviesOfTheGenreCell.cellId() , for: indexPath) as? MoviesOfTheGenreCell {
            cell.movieOfTheGenre = moviesOfTheGenre?[indexPath.row]
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let moviesOfTheGenre = moviesOfTheGenre else { return }
        var id: Int?
        let object = moviesOfTheGenre[indexPath.row]
        id = object.id
        router?.presentMovieDetails(id: id)
    }
}


extension MoviesOfTheGenreView: MoviesOfTheGenreCellDelegate {
    func deleteFromFavourite(id: Int?) {
        guard let id = id else { return }
        interactor?.deleteData(id: id)
    }

    func addToFavorite(model: Result) {
        interactor?.saveData(model: model)
    }
}


extension MoviesOfTheGenreView: NavigationViewDelegate {
    func action() { }

    func back() {
        router?.goBack()
    }
}
