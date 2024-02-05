//
//  FavouriteView.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 24.01.2024.
//

import UIKit
import SnapKit

protocol FavouriteViewProtocol: AnyObject {
    func displayData(data: [FavouriteModel])
    func displayError()
}

final class FavouriteView: UIView {

    var interactor: FavouriteInteractorProtocol?
    var router: FavouriteRouter?

    private var model: [FavouriteModel]? {
        didSet {
            updateUI()
        }
    }

    private lazy var emptyView: EmptyView = {
        let view = EmptyView()
        return view
    }()

    private lazy var navigationView: NavigationView = {
        let view = NavigationView()
        view.actionButton.isHidden = true
        view.backButton.isHidden = true
        view.titleLabel.text = NavigationTitles.favourites
        view.delegate = self
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.cellId())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 240
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        addNotificationCenter()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .white

        addSubview(navigationView)
        addSubview(tableView)
        addSubview(emptyView)

        navigationView.snp.remakeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(36)
        }

        tableView.snp.remakeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }

        emptyView.snp.remakeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func updateUI() {
        guard let model = model else { return }
        if model.count == 0 {
            emptyView.isHidden = false
            tableView.isHidden = true
        } else {
            emptyView.isHidden = true
            tableView.isHidden = false
        }
    }

    private func addNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateData),
            name: NSNotification.Name("FavouriteObjectAddedNotification"),
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateData),
            name: NSNotification.Name("FavouriteObjectDeletedNotification"),
            object: nil
        )
    }

    @objc private func updateData() {
        interactor?.fetchData()
    }
}

extension FavouriteView: FavouriteCellDelegate {
    func deleteFromFavourite(object: FavouriteModel) {
        interactor?.removeData(object: object)
    }
}

extension FavouriteView: FavouriteViewProtocol {
    func displayData(data: [FavouriteModel]) {
        model = data
        tableView.reloadData()
    }

    func displayError() {
#warning("JTBD: Alert")
    }
}


extension FavouriteView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.cellId(), for: indexPath) as? FavouriteCell {
            cell.selectionStyle = .none
            cell.favouriteModel = model?[indexPath.row]
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = model else { return }
        var id: Int?
        let object = model[indexPath.row]
        id = object.id
        router?.presentMovieDetails(id: id)
    }
}


extension FavouriteView: NavigationViewDelegate {
    func back() { }
    func action() { }
}
