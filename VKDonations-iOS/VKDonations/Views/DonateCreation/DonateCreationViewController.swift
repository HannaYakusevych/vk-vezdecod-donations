//
//  DonateCreationViewController.swift
//  VKDonations
//
//  Created by Анна Якусевич on 12.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit
import SnapKit
import TPKeyboardAvoiding

final class DonateCreationViewController: UIViewController {
    
    enum FlowType {
        case oneTime
        case repeating
    }
    
    // MARK: - View elements
    
    private lazy var imagePlaceholderView: UIView = {
        let view = viewBuilder.imagePlaceholderView()
        view.enableTapping {
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.snp.makeConstraints { $0.height.equalTo(140) }
        view.layer.cornerRadius = 10
        
        view.enableTapping {
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        return view
    }()
    
    private lazy var titleView: InputView = {
        let view = InputView()
        view.setup(title: .donateName, placeholder: .donateName, isEditable: true)
        return view
    }()
    
    private lazy var priceView: InputView = {
        let view = InputView()
        view.setup(title: flowType == .oneTime ? .sumTitle : .monthlySumTitle,
                   placeholder: flowType == .oneTime ? .sumPlaceholder : .monthlySumPlaceholder,
                   isEditable: true,
                   inputType: .int)
        return view
    }()
    
    private lazy var purposeView: InputView = {
        let view = InputView()
        view.setup(title: .purpose, placeholder: .purposePlaceholder, isEditable: true)
        return view
    }()
    
    private lazy var descriptionView: InputView = {
        let view = InputView()
        view.setup(title: .donationDescription, placeholder: .donationDescriptionPlaceholder, isEditable: true, linesCount: 2)
        return view
    }()
    
    private lazy var cardView: ChoiceView = {
        let view = ChoiceView()
        view.setup(title: .bankCardTitle, default: .bankCard) { [weak self] in
            self?.openPlaceholderView()
        }
        return view
    }()
    
    private lazy var authorView: ChoiceView = {
        let view = ChoiceView()
        view.setup(title: .nameTitle, default: .name) { [weak self] in
            self?.openPlaceholderView()
        }
        return view
    }()
    
    private lazy var continueButton: UIButton = {
        let button = viewBuilder.continueButton(title: flowType == .oneTime ? .continueButton : .createDonation)
        button.enableTapping(continueCreation)
        return button
    }()
    
    // MARK: - Dependencies
    
    private let viewBuilder = DonateCreationViewBuilder()
    private let imagePicker = UIImagePickerController()
    private let networkService = NetworkService()
    private var flowType: FlowType
    
    // MARK: - Initialization
    
    init(flowType: FlowType) {
        self.flowType = flowType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        setupUI()
        
        addViews()
        
        let item = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        item.tintColor = .headerTint
        navigationItem.backBarButtonItem = item
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.shadowColor = nil
            navBarAppearance.backgroundColor = .headerBackground

            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            navigationController?.navigationBar.shadowImage = nil
            navigationController?.navigationBar.backgroundColor = .headerBackground
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.shadowColor = .separatorCommon
            navBarAppearance.backgroundColor = .headerBackground

            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            navigationController?.navigationBar.shadowImage = UIImage(color: UIColor.separatorCommon!)
            navigationController?.navigationBar.backgroundColor = .headerBackground
        }
    }
}

extension DonateCreationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.image = pickedImage
            UIView.animate(withDuration: 0.3) {
                self.imageView.alpha = 1
                self.imagePlaceholderView.isHidden = true
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

private extension DonateCreationViewController {
    func setupUI() {
        switch flowType {
        case .oneTime:
            title = .oneTimeDonationTitle
        case .repeating:
            title = .repeatableDonationTitle
        }
        
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
        
        contentView.addSubview(imagePlaceholderView)
        imagePlaceholderView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(10)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
        }
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(10)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
        }
        imageView.alpha = 0
        
        contentView.addSubview(titleView)
        titleView.snp.makeConstraints { maker in
            maker.top.equalTo(imageView.snp.bottom).offset(12)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        contentView.addSubview(priceView)
        priceView.snp.makeConstraints { maker in
            maker.top.equalTo(titleView.snp.bottom)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        contentView.addSubview(purposeView)
        purposeView.snp.makeConstraints { maker in
            maker.top.equalTo(priceView.snp.bottom)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        contentView.addSubview(descriptionView)
        descriptionView.snp.makeConstraints { maker in
            maker.top.equalTo(purposeView.snp.bottom)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints { maker in
            maker.top.equalTo(descriptionView.snp.bottom)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        if flowType == .repeating {
            contentView.addSubview(authorView)
            authorView.snp.makeConstraints { maker in
                maker.top.equalTo(cardView.snp.bottom)
                maker.leading.equalToSuperview()
                maker.trailing.equalToSuperview()
            }
        }
        
        contentView.addSubview(continueButton)
        continueButton.snp.makeConstraints { maker in
            maker.top.equalTo(flowType == .oneTime ? cardView.snp.bottom : authorView.snp.bottom).offset(12)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
            maker.bottom.equalToSuperview().offset(-12)
        }
    }
    
    func openPlaceholderView() {
        let view = PlaceholderViewController()
        present(view, animated: true, completion: nil)
    }
    
    func continueCreation() {
        if let image = imageView.image,
            titleView.validate(),
            priceView.validate(),
            purposeView.validate(),
            descriptionView.validate() {
            
            let donate = Donate(title: titleView.getText(),
                                price: Int(priceView.getText())!,
                                purpose: purposeView.getText(),
                                donateType: .repeatable,
                                description: descriptionView.getText(),
                                startDate: Date(),
                                endDate: nil,
                                bankCard: cardView.getText(),
                                author: flowType == .oneTime ? "" : authorView.getText())
            
            switch flowType {
            case .oneTime:
                let view = DonateCreationDetailsViewController(donate: donate, image: image)
                navigationController?.pushViewController(view, animated: true)
            case .repeating:
                networkService.createDonate(donate: donate) { [weak self] result in
                    switch result {
                    case .success(let id):
                        self?.networkService.saveImage(image: image, id: id)
                    case .failure:
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Ошибка сети", message: "Нам очень жаль", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                            self?.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
}
