//
//  CastAndCrewView.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import UIKit

protocol CastAndCrewViewProtocol: AnyObject {
    func displayCastAndCrew(viewModel: [CastAndCrewModel])
    func displayError()
}

final class CastAndCrewView: UIView, CastAndCrewViewProtocol {

    var interactor: CastAndCrewInteractorProtocol?
    var router: CastAndCrewRouter?

    private var model: [CastAndCrewModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    private lazy var navigationView: NavigationView = {
        let view = NavigationView()
        view.actionButton.isHidden = true
        view.titleLabel.text = CastAndCrewTitles.headerTitle
        view.delegate = self
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CastAndCrewCell.self, forCellReuseIdentifier: CastAndCrewCell.cellId())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
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

    func displayCastAndCrew(viewModel: [CastAndCrewModel]) {
        model = viewModel
    }

    func displayError() {
    #warning("JTBD: Добавить системный алерт который обсуждали")
    }
}

extension CastAndCrewView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        model.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let section = model[section]

        switch section.section {
        case .cast(let cast):
            return cast.count
        case .crew(let crew):
            return crew.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let section = model[indexPath.section]

        switch section.section {
        case .cast(let cast):
            if let cell = tableView.dequeueReusableCell(withIdentifier: CastAndCrewCell.cellId(), for: indexPath) as? CastAndCrewCell {
                cell.castAndCrew = cast[indexPath.row]
                cell.selectionStyle = .none
                return cell
            }
        case .crew(let crew):
            if let cell = tableView.dequeueReusableCell(withIdentifier: CastAndCrewCell.cellId(), for: indexPath) as? CastAndCrewCell {
                cell.castAndCrew = crew[indexPath.row]
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension CastAndCrewView: NavigationViewDelegate {
    func action() { }
    
    func back() {
        router?.goBack()
    }
}

