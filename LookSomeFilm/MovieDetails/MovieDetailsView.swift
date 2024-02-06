//
//  MovieDetailsView.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import UIKit
import SnapKit
import Kingfisher

protocol MovieDetailsViewProtocol: AnyObject {
    func displayData(viewModel: [MovieDetailsModel])
    func displayError()
}

final class MovieDetailsView: UIView {

    var interactor: MovieDetailsInteractorProtocol?
    var router: MovieDetailsRouter?
    
    private var model: [MovieDetailsModel] = [] {
        didSet {
            configureStrechyHeader()
        }
    }

    private lazy var header: HeaderView = {
        let view = HeaderView(frame: CGRect(x: 0, y: 0, width: .zero, height: 450))
        view.delegate = self
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTitleCell.self, forCellReuseIdentifier: MovieTitleCell.cellId())
        tableView.register(FooterCell.self, forCellReuseIdentifier: FooterCell.cellId())
        tableView.register(CastAndCrewCell.self, forCellReuseIdentifier: CastAndCrewCell.cellId())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .white

        addSubview(tableView)
        tableView.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func configureStrechyHeader() {
        switch model[0].section {
        case .details(let movieDetails):
            header.movieDetails = movieDetails
        default:
            break
        }
        tableView.tableHeaderView = header
        tableView.reloadData()
    }
}

extension MovieDetailsView: MovieDetailsViewProtocol {
    
    func displayData(viewModel: [MovieDetailsModel]) {
        model = viewModel
    }

    func displayError() {
        debugPrint("Error")
    }
}

extension MovieDetailsView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        model.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let section = model[section]

        switch section.section {
        case .details(_):
            return 1
        case .footer:
            return 1
        case .castAndCrew(let castAndCrew):
            return min(castAndCrew.count, 12)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = model[indexPath.section]
        switch section.section {
        case .details(let movieDetails):
            if let cell = tableView.dequeueReusableCell(withIdentifier: MovieTitleCell.cellId(), for: indexPath) as? MovieTitleCell {
                cell.movieDetails = movieDetails
                return cell
            }
        case .footer:
            if let cell = tableView.dequeueReusableCell(withIdentifier: FooterCell.cellId(), for: indexPath) as? FooterCell {
                cell.delegate = self
                return cell
            }
        case .castAndCrew(let castAndCrew):
            if let cell = tableView.dequeueReusableCell(withIdentifier: CastAndCrewCell.cellId(), for: indexPath) as? CastAndCrewCell {
                cell.castAndCrew = castAndCrew[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
}


extension MovieDetailsView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        header.scrollViewDidScroll(scrollView: scrollView)
    }
}

extension MovieDetailsView: FooterCellDelegate, HeaderViewDelegate {

    func actionFooterButton() {
        var id: Int?
        switch model[0].section {
        case .details(let movieDetails):
            id = movieDetails.id
        default:
            break
        }
        router?.presentAllCrew(id: id)
    }

    func backAction() {
        router?.dismissScene()
    }

    func saveAction() {
        switch model[0].section {
        case .details(let movieDetalis):
            let id = movieDetalis.id
            guard let id = id else { return }
            interactor?.saveData(id: id, movieDetails: movieDetalis)
        default:
            break
        }
    }

    func deleteAction(id: Int?) {
        switch model[0].section {
        case .details(let movieDetalis):
            let id = movieDetalis.id
            guard let id = id else { return }
            interactor?.deleteData(id: id)
        default:
            break
        }
    }
}
