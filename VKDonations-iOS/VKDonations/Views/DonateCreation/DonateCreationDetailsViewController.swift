//
//  DonateCreationDetailsViewController.swift
//  VKDonations
//
//  Created by Анна Якусевич on 12.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit
import SnapKit
import TPKeyboardAvoiding
import AYPopupPickerView

final class DonateCreationDetailsViewController: UIViewController {
    
    // MARK: - View elements
    
    private lazy var authorView: ChoiceView = {
        let view = ChoiceView()
        view.setup(title: .nameTitle, default: .name) { [weak self] in
            self?.openPlaceholderView()
        }
        return view
    }()
    
    private lazy var singleChoiceView: SingleChoiceView = {
        let view = SingleChoiceView()
        view.setup(title: .dоnateWillEnd, delegate: self)
        return view
    }()
    
    private lazy var endDateView: ChoiceView = {
        let view = ChoiceView()
        view.setup(title: .endDate, default: .chooseDate) { [weak self] in
            self?.openDatePicker()
        }
        return view
    }()
    
    private lazy var continueButton: UIButton = {
        let button = viewBuilder.continueButton(title: .createDonation)
        button.enableTapping(continueCreation)
        return button
    }()
    
    // MARK: - Dependencies
    
    private let networkService = NetworkService()
    private let viewBuilder = DonateCreationViewBuilder()
    private let datePicker = UIDatePicker()
    
    // State
    let donate: Donate
    let image: UIImage
    var date: Date?
    
    // MARK: - Initialization
    
    init(donate: Donate, image: UIImage) {
        self.donate = donate
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        addViews()
        
        continueButton.alpha = 1.0
        continueButton.isUserInteractionEnabled = true
        
        endDateView.alpha = 0.4
        endDateView.isUserInteractionEnabled = false
    }
}

extension DonateCreationDetailsViewController: SingleChoiceViewDelegate {
    func userDidChoose(_ option: Int) {
        if option == 0 {
            continueButton.alpha = 1.0
            continueButton.isUserInteractionEnabled = true
            
            endDateView.alpha = 0.4
            endDateView.isUserInteractionEnabled = false
        } else if date == nil {
            continueButton.alpha = 0.4
            continueButton.isUserInteractionEnabled = false
            
            endDateView.alpha = 1.0
            endDateView.isUserInteractionEnabled = true
        } else {
            continueButton.alpha = 1.0
            continueButton.isUserInteractionEnabled = true
            
            continueButton.alpha = 1.0
            continueButton.isUserInteractionEnabled = true
        }
    }
}

private extension DonateCreationDetailsViewController {
    func setupUI() {
        title = .additional
        
        view.backgroundColor = .backgroundContent
        edgesForExtendedLayout = []
    }
    
    func addViews() {
        let contentScrollView = TPKeyboardAvoidingScrollView()
        view.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { $0.edges.equalToSuperview(); $0.width.equalToSuperview() }
        
        let contentView = UIView()
        contentScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { $0.edges.equalToSuperview(); $0.width.equalToSuperview() }
        
        contentView.addSubview(authorView)
        authorView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(4)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        contentView.addSubview(singleChoiceView)
        singleChoiceView.snp.makeConstraints { maker in
            maker.top.equalTo(authorView.snp.bottom)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        contentView.addSubview(endDateView)
        endDateView.snp.makeConstraints { maker in
            maker.top.equalTo(singleChoiceView.snp.bottom)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        contentView.addSubview(continueButton)
        continueButton.snp.makeConstraints { maker in
            maker.top.greaterThanOrEqualTo(endDateView.snp.bottom).offset(12)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
            maker.bottom.equalToSuperview().offset(-12)
        }
    }
    
    func openPlaceholderView() {
        let view = PlaceholderViewController()
        present(view, animated: true, completion: nil)
    }
    
    func openDatePicker() {
        let popupDatePickerView = AYPopupDatePickerView()
        popupDatePickerView.display(defaultDate: Date(), doneHandler: { date in
            self.date = date
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ru_RU")
            formatter.dateFormat = "d MMMM"
            self.endDateView.setText(formatter.string(from: date))
            
            self.continueButton.alpha = 1.0
            self.continueButton.isUserInteractionEnabled = true
        })
    }
    
    func continueCreation() {
        let donate = Donate(title: self.donate.title,
                            price: self.donate.price,
                            purpose: self.donate.purpose,
                            donateType: self.donate.donateType,
                            description: self.donate.description,
                            startDate: self.donate.startDate,
                            endDate: date,
                            bankCard: self.donate.bankCard,
                            author: authorView.getText())
        networkService.createDonate(donate: donate) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let id):
                self.networkService.saveImage(image: self.image, id: id)
            case .failure:
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Ошибка сети", message: "Нам очень жаль", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
