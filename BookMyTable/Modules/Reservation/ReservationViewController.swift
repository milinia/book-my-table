//
//  ReservationViewController.swift
//  BookMyTable
//
//  Created by Evelina on 08.05.2023.
//

import UIKit

class ReservationViewController: UIViewController {
    
    // MARK: - Private constants
    private enum UIConstants {
        static let labelsFontSize: CGFloat = 20
        static let viewsCornerSize: CGFloat = 14
        static let contentInset: CGFloat = 16
        static let guestsViewHeight: CGFloat = 80
        static let timeViewHeight: CGFloat = 240
        static let spaceBetweenViews: CGFloat = 20
        static let titleLabelFontSize: CGFloat = 30
        static let buttonCornerRadius: CGFloat = 20
        static let pickerViewLabelHeight: CGFloat = 30
        static let textViewHeight: CGFloat = 130
        static let buttonLabelFontSize: CGFloat = 18
        static let dateCellWidth: CGFloat = 65
    }
    
    // TODO: подумать, будет ли от сервера или на уровне приложения генерируется
    private var dateArray: [String] = ["17 мая, среда", "18 мая, четверг", "19 мая, пятница", "20 мая, суббота", "21 мая, воскресенье"]
    private var timeArray: [String] = ["10:00", "11:30", "13:00", "14:00", "16:00", "17:30", "19:00", "20:00", "21:30", "10:00", "11:30", "13:00", "14:00", "16:00", "17:30", "19:00", "20:00", "21:30"]
    private var restaurantTitle: String = "Ресторан «На крыше»"
    private var tableID: String = ""
    private var restaurantID: String = ""
    private var selectedCell: UICollectionViewCell = UICollectionViewCell()
    
    //MARK: - Private UI properties
    
//    private lazy var reservationLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.font = .systemFont(ofSize: UIConstants.titleLabelFontSize, weight: .bold)
//        label.text = StringConstants.reservation + " в «" + restaurantTitle + "»"
//        return label
//    }()
    
    private lazy var numberOfGuestsStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.maximumValue = 10
        stepper.minimumValue = 1
        stepper.value = 1
        stepper.stepValue = 1
        return stepper
    }()
    
    private lazy var numberOfGuestsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "1"
        label.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .regular)
        return label
    }()
    
    private lazy var guestsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .bold)
        label.text = StringConstants.Reservation.guests
        return label
    }()
    
    private lazy var guestsView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = UIConstants.viewsCornerSize
        return view
    }()
    
    private lazy var reservationDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .bold)
        label.text = dateArray[0]
        label.textAlignment = .center
        return label
    }()
    
    private lazy var chooseDateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        button.tintColor = UIColor(red: 0.07, green: 0.29, blue: 0.71, alpha: 0.82)
//        button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        return button
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .bold)
        label.text = StringConstants.Reservation.date
        return label
    }()
    
    private lazy var dateView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = UIConstants.viewsCornerSize
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .bold)
        label.text = StringConstants.Reservation.time
        return label
    }()
    
    private lazy var timeCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private lazy var timeView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = UIConstants.viewsCornerSize
        return view
    }()
    
    private lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .bold)
        textView.text = StringConstants.Reservation.comment
        textView.textColor = UIColor.systemGray3
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.cornerRadius = UIConstants.viewsCornerSize
        return textView
    }()
    
    private lazy var tableLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .bold)
        label.text = StringConstants.Reservation.table
        return label
    }()
    
    private lazy var tableView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = UIConstants.viewsCornerSize
        return view
    }()
    
    private lazy var reserveButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIConstants.buttonCornerRadius
        button.clipsToBounds = true
        button.setTitle(StringConstants.Reservation.button, for: .normal)
        button.backgroundColor = UIColor(red: 0.07, green: 0.29, blue: 0.71, alpha: 0.82)
        button.contentEdgeInsets = UIEdgeInsets(top: UIConstants.contentInset, left: UIConstants.contentInset, bottom: UIConstants.contentInset, right: UIConstants.contentInset)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.buttonLabelFontSize)
        return button
    }()
    
    
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.delegate = self
        timeCollection.delegate = self
        timeCollection.dataSource = self
        
        timeCollection.register(TimeCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TimeCollectionViewCell.self))
        
        setupView()
        
        numberOfGuestsStepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
        chooseDateButton.addTarget(self, action: #selector(chooseDateButtonPressed), for: .touchUpInside)
        reserveButton.addTarget(self, action: #selector(reserveButtonPressed), for: .valueChanged)
    }
    
    @objc func chooseDateButtonPressed() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: UIScreen.main.bounds.width - 10, height: UIScreen.main.bounds.height / 2)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width:  UIScreen.main.bounds.width - 10, height: UIScreen.main.bounds.height / 2))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(0, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        let alert = UIAlertController(title: StringConstants.Reservation.chooseDate, message: "", preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = chooseDateButton
        alert.popoverPresentationController?.sourceRect = chooseDateButton.bounds
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: StringConstants.Reservation.cancel, style: .cancel))
        alert.addAction(UIAlertAction(title: StringConstants.Reservation.choose, style: .default, handler: {_ in
            self.reservationDateLabel.text = self.dateArray[pickerView.selectedRow(inComponent: 0)]
        }))
        
        present(alert, animated: true)
    }
    
    @objc func stepperChanged(){
        numberOfGuestsLabel.text = String(Int(numberOfGuestsStepper.value))
    }
    
    @objc func reserveButtonPressed(){
        // TODO: переход к другому экрану
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
        
//        let scrollView = UIScrollView()
//        scrollView.isScrollEnabled = true
////        scrollView.showsVerticalScrollIndicator = false
//        scrollView.contentSize = CGSize(width: view.bounds.width, height: 1000)
//
        view.addSubview(guestsView)
        view.addSubview(dateView)
        view.addSubview(timeView)
        view.addSubview(commentTextView)
//        view.addSubview(tableView)
        
//        view.addSubview(scrollView)
        view.addSubview(reserveButton)
        
//        scrollView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
//            make.width.equalToSuperview()
//            make.bottom.equalTo(reserveButton.snp.top).offset(UIConstants.contentInset)
//        }
        
        setupConstraints()
        setupSubview()
    }
    
    private func setupSubview() {
        guestsView.addSubview(guestsLabel)
        guestsView.addSubview(numberOfGuestsLabel)
        guestsView.addSubview(numberOfGuestsStepper)
        
        guestsLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        
        numberOfGuestsStepper.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        
        numberOfGuestsLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(numberOfGuestsStepper.snp.leadingMargin).offset(-UIConstants.contentInset - 8)
        }
        

        dateView.addSubview(dateLabel)
        dateView.addSubview(reservationDateLabel)
        dateView.addSubview(chooseDateButton)
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        
        reservationDateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(chooseDateButton.snp.leading).inset(UIConstants.contentInset)
            make.width.equalToSuperview().inset(60)
        }
        
        chooseDateButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
//            make.width.equalTo(60)
//            make.height.equalTo(60)
        }
        
        timeView.addSubview(timeLabel)
        timeView.addSubview(timeCollection)
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIConstants.contentInset)
            make.leading.equalToSuperview().offset(UIConstants.contentInset)
        }
        
        timeCollection.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(UIConstants.contentInset)
            make.width.equalToSuperview().inset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(UIConstants.contentInset)
        }
        
//        tableView.addSubview(tableLabel)
        
//        tableLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(UIConstants.contentInset)
//            make.leading.equalToSuperview().offset(UIConstants.contentInset)
//        }
        
        
    }
    
    private func setupConstraints() {
        
//        reservationLabel.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(6)
//            make.trailing.leading.equalToSuperview().offset(UIConstants.contentInset)
//        }
        
        guestsView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(UIConstants.contentInset)
            make.width.equalToSuperview().inset(UIConstants.contentInset)
            make.height.equalTo(UIConstants.guestsViewHeight)
        }
        
        dateView.snp.makeConstraints { make in
            make.top.equalTo(guestsView.snp.bottom).offset(UIConstants.spaceBetweenViews)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(UIConstants.contentInset)
            make.height.equalTo(UIConstants.guestsViewHeight)
        }
        
        timeView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(UIConstants.spaceBetweenViews)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(UIConstants.contentInset)
            make.height.equalTo(UIConstants.timeViewHeight)
        }
        
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(timeView.snp.bottom).offset(UIConstants.spaceBetweenViews)
//            make.centerX.equalToSuperview()
//            make.width.equalToSuperview().inset(UIConstants.contentInset)
//            make.height.equalTo(UIConstants.guestsViewHeight)
//        }
        
        commentTextView.snp.makeConstraints { make in
            make.top.equalTo(timeView.snp.bottom).offset(UIConstants.spaceBetweenViews)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(UIConstants.contentInset)
            make.height.equalTo(UIConstants.textViewHeight)
        }
        
        reserveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(UIConstants.contentInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(UIConstants.contentInset + 20)
        }
    }
}

// MARK: - UITextViewDelegate
extension ReservationViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == StringConstants.Reservation.comment {
            textView.text = ""
            textView.textColor = UIColor.black
            textView.font = .systemFont(ofSize: UIConstants.labelsFontSize, weight: .regular)
        }
    }
        
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = StringConstants.Reservation.comment
            textView.textColor = UIColor.systemGray5
        }
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension ReservationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dateArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        dateArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reservationDateLabel.text = dateArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 10, height: UIConstants.pickerViewLabelHeight))
        label.text = dateArray[row]
        label.sizeToFit()
        return label
    }
    
}
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ReservationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeCollectionViewCell.self), for: indexPath) as? TimeCollectionViewCell else { return TimeCollectionViewCell()}
        cell.configure(with: timeArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TimeCollectionViewCell {
            cell.backgroundColor = UIColor(red: 0.07, green: 0.29, blue: 0.71, alpha: 0.5)
            selectedCell.backgroundColor = .white
            selectedCell = cell
        }
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension ReservationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewHeight = collectionView.bounds.height - 30
        let itemHeight = (collectionViewHeight - 15) / 3 // Assuming you want 3 rows with 20 points of spacing in between
        let itemWidth = UIConstants.dateCellWidth // Calculate the width based on your requirements and the available space
        return CGSize(width: Double(itemWidth), height: Double(itemHeight))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Set the desired spacing between columns
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Set the desired spacing between rows
    }
}

