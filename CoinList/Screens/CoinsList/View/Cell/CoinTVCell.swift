//
//  CoinTVCell.swift
//  CoinList
//
//  Created by Yerem Sargsyan on 13.09.22.
//

import UIKit
import Kingfisher

class CoinTVCell: UITableViewCell {

    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var index: UILabel!
    @IBOutlet weak var btc: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var indexView: UIView!
    @IBOutlet weak var percentView: UIStackView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var percentIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        icon.image = nil
        title.text = nil
        index.text = nil
        btc.text = nil
        price.text = nil
    }
    
    func configure(vm: CoinCellViewModel) {
        if let url = URL(string: vm.imageUrl) {
            self.icon.kf.setImage(with: url)
        }
        title.text = vm.title
        index.text = vm.index
        btc.text = vm.btc
        price.text = vm.price
        setupPercentView(vm: vm)
    }
    
    func initView() {
        backgroundColor = .clear
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    func setupView() {
        title.textColor = AppColors.Text.secondary
        index.textColor = AppColors.Text.darkGray
        btc.textColor = AppColors.Text.ghost
        price.textColor = AppColors.Text.default
        indexView.layer.cornerRadius = Constants.indexViewCornerRadius
        indexView.backgroundColor = AppColors.Background.secondary
    }
    
    func setupPercentView(vm: CoinCellViewModel) {
        percentView.layer.cornerRadius = Constants.percentViewCornerRadius
        percentView.backgroundColor = vm.percent.bacgroundColor
        percentIcon.tintColor = vm.percent.color
        percentIcon.image = vm.percent.icon
        percentLabel.text = vm.percent.text
        percentLabel.textColor = vm.percent.color
    }
}

extension CoinTVCell {
    struct Constants {
        static let indexViewCornerRadius: CGFloat = 4
        static let percentViewCornerRadius: CGFloat = 8
    }
}
