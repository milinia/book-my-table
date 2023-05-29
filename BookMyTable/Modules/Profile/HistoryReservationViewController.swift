//
//  ProfileViewController.swift
//  BookMyTable
//
//  Created by Evelina on 21.05.2023.
//

import UIKit

class HistoryReservationViewController: UIViewController {
    
    // MARK: - Private constants
    private enum UIConstants {
        static let titleLabelFontSize: CGFloat = 15
        static let xStackSpacing: CGFloat = 8
        static let contentInset: CGFloat = 16
        static let textFieldWidth: CGFloat = 20
        static let buttonCornerRadius: CGFloat = 20
        static let buttonLabelFontSize: CGFloat = 18
        static let spaceAfterTitleLabel: CGFloat = 18
        static let spaceAfterInfoLabel: CGFloat = 36
        static let buttonBorderWidth: CGFloat = 2
        static let textFieldHeight: CGFloat = 50
        static let bottomConstaint: CGFloat = 24
        static let agreementLabeFontSize: CGFloat = 14
    }
    
    var reservations: [ReservationData] = []
    //MARK: - Private UI properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.titleLabelFontSize, weight: .bold)
        label.text = StringConstants.Profile.reservations
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(origin: CGPoint(), size: CGSize()))
        return table
    }()

    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func updateTable() {
        tableView.reloadData()
    }
    
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        setupConstraints()
        setupSubview()
    }
    
    private func setupSubview() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UpcomingReservationTableViewCell.self, forCellReuseIdentifier: String(describing: UpcomingReservationTableViewCell.self))
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(75)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
            make.width.equalToSuperview().inset(UIConstants.textFieldWidth)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(UIConstants.contentInset)
        }
    }
}

extension HistoryReservationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UpcomingReservationTableViewCell.self), for: indexPath)
                        as? UpcomingReservationTableViewCell else { return UpcomingReservationTableViewCell()}
        cell.configure(with: reservations[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reservationDetailViewController = ReservationDetailViewController()
        reservationDetailViewController.reservationData = reservations[indexPath.section]
//        present(reservationDetailViewController, animated: true)
        navigationController?.pushViewController(reservationDetailViewController, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return reservations.count
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         if (section == 0) {
             return 0
         } else {
             return 4
         }
    }
        
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
        
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
        
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         if (section == 0) {
             return 0
         } else {
             return CGFloat.leastNormalMagnitude
         }
    }
}
