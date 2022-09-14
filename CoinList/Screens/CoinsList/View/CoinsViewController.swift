//
//  CoinsViewController.swift
//  CoinList
//
//  Created by Yerem Sargsyan on 13.09.22.
//

import UIKit

class CoinsViewController: UIViewController {

    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var upIcon: UIImageView!
    @IBOutlet weak var downIcon: UIImageView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel = {
        CoinsViewModel()
    }()
    
    lazy var alertViewModel = {
        AlertViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkedNetworkConnection()
        setupTableView()
        setupView()
        setupNavBar()
        initViewModel()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = AppColors.Background.default
        tableView.separatorStyle = .none
        tableView.allowsSelection = false

        tableView.register(CoinTVCell.nib, forCellReuseIdentifier: CoinTVCell.identifier)
    }
    
    func setupView() {
        let item = viewModel.configurePageData
        navigationItem.title = item.name
        coinLabel.text = item.category
        hourLabel.text = item.hour
        priceLabel.text = item.price
        upIcon.image = item.arrowUp
        downIcon.image = item.arrowDown
        
        coinLabel.textColor = AppColors.Text.ghost
        hourLabel.textColor = AppColors.Text.ghost
        priceLabel.textColor = AppColors.Text.secondary
        
        topView.backgroundColor = AppColors.Background.default
        upIcon.tintColor = AppColors.Image.upPrice
        downIcon.tintColor = AppColors.Image.downPrice
    }
    
    func setupNavBar() {
        let button = UIButton()
        button.setTitle(viewModel.configurePageData.curentPrice, for: .normal)
        button.setTitleColor(AppColors.Text.ghost, for: .normal)
        let item = UIBarButtonItem(customView: button)
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
        search.tintColor = AppColors.Text.ghost
        self.navigationItem.setRightBarButtonItems([search, item], animated: true)
    }
    
    func initViewModel() {
        // Get coins data
        viewModel.getCoins()
        
        // Get coins error data
        viewModel.error = { [weak self] error in
            guard let self = self else { return }
            self.alertViewModel.simpleAlert(self,
                                            title: error.title,
                                            message: error.message,
                                            firstActionTitle: error.firstActionTitle,
                                            secondActionTitle: error.secondActionTitle,
                                            completionFirst: nil) {
                self.viewModel.getCoins()
            }
        }
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
            self?.tableView.reloadData()
            }
        }
        // Update TableView closure
        viewModel.updateTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.beginUpdates()
                self?.tableView.reloadData()
                self?.tableView.endUpdates()
            }
        }
    }
}

// MARK: UITableViewDataSource
extension CoinsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coinCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTVCell.identifier, for: indexPath) as? CoinTVCell else { fatalError("xib does not exists") }
        let vm = viewModel.getCellViewModel(at: indexPath)
        cell.configure(vm: vm)
        return cell
    }
}

// MARK: UITableViewDelegate
extension CoinsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
}

// MARK: Constants
extension CoinsViewController {
    struct Constants {
        static let rowHeight: CGFloat = 52
    }
}
