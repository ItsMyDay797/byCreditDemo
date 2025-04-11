//
//  TransactionsViewController.swift
//  byCreditDemo
//
//  Created by Марк Русаков on 11.04.25.
//

import UIKit

class TransactionsViewController: UIViewController {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.06, green: 0.11, blue: 0.23, alpha: 1.0)
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "История транзакций"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск транзакций"
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = .clear
        searchBar.backgroundColor = .clear
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .white
            textField.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        }
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private var transactions: [Transaction] = []
    private var filteredTransactions: [Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupTableView()
        setupNotifications()
        loadTransactions()
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(closeButton)
        containerView.addSubview(searchBar)
        containerView.addSubview(filterButton)
        containerView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -20),
            
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -10),
            
            filterButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            filterButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            filterButton.widthAnchor.constraint(equalToConstant: 30),
            filterButton.heightAnchor.constraint(equalToConstant: 30),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        searchBar.delegate = self
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(transactionsDidChange),
            name: .transactionsDidChange,
            object: nil
        )
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
    
    @objc private func filterTapped() {
        let alert = UIAlertController(title: "Фильтры", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Все", style: .default) { _ in
            self.filteredTransactions = self.transactions
            self.tableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Получение", style: .default) { _ in
            self.filteredTransactions = self.transactions.filter { $0.type == .receive }
            self.tableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Отправка", style: .default) { _ in
            self.filteredTransactions = self.transactions.filter { $0.type == .send }
            self.tableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Обмен", style: .default) { _ in
            self.filteredTransactions = self.transactions.filter { $0.type == .exchange }
            self.tableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc private func transactionsDidChange() {
        loadTransactions()
    }
    
    private func loadTransactions() {
        transactions = UserData.shared.transactions
        filteredTransactions = transactions
        tableView.reloadData()
    }
    
    func showExchangeDetails(for transaction: Transaction) {
        let detailsVC = UIViewController()
        detailsVC.view.backgroundColor = .systemBackground
        
        let container = UIView()
        container.backgroundColor = UIColor.systemGray6
        container.layer.cornerRadius = 12
        detailsVC.view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Детали обмена"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        container.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        container.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        if let details = transaction.details {
            let fromAmountLabel = createDetailRow(title: "Отправлено:", value: "\(formatNumber(details.fromAmount)) \(details.fromCurrency)")
            let toAmountLabel = createDetailRow(title: "Получено:", value: "\(formatNumber(details.toAmount)) \(details.toCurrency)")
            let rateLabel = createDetailRow(title: "Курс обмена:", value: "1 \(details.fromCurrency) = \(formatNumber(details.rate)) \(details.toCurrency)")
            let dateLabel = createDetailRow(title: "Дата:", value: formatDate(transaction.date))
            
            [fromAmountLabel, toAmountLabel, rateLabel, dateLabel].forEach { stackView.addArrangedSubview($0) }
        }
        
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Закрыть", for: .normal)
        closeButton.addTarget(detailsVC, action: #selector(UIViewController.dismiss(animated:completion:)), for: .touchUpInside)
        container.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: detailsVC.view.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: detailsVC.view.trailingAnchor, constant: -20),
            container.centerYAnchor.constraint(equalTo: detailsVC.view.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            
            closeButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            closeButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            closeButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20)
        ])
        
        let nav = UINavigationController(rootViewController: detailsVC)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(nav, animated: true)
    }
    
    private func createDetailRow(title: String, value: String) -> UIView {
        let container = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .secondaryLabel
        titleLabel.font = .systemFont(ofSize: 14)
        container.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 16, weight: .medium)
        container.addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            valueLabel.topAnchor.constraint(equalTo: container.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }
    
    private func formatNumber(_ number: Double) -> String {
        if number < 0.0001 {
            return String(format: "%.8f", number)
        } else if number < 1 {
            return String(format: "%.4f", number)
        } else if number > 1000000 {
            return String(format: "%.2f", number)
        } else {
            return String(format: "%.2f", number)
        }
    }
}

extension TransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
        cell.configure(with: filteredTransactions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let transaction = filteredTransactions[indexPath.row]
        if transaction.type == .exchange, let details = transaction.details {
            showExchangeDetails(for: transaction)
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

extension TransactionsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredTransactions = transactions
        } else {
            filteredTransactions = transactions.filter { transaction in
                transaction.address.lowercased().contains(searchText.lowercased()) ||
                transaction.currency.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}

class TransactionCell: UITableViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let typeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(typeIcon)
        containerView.addSubview(amountLabel)
        containerView.addSubview(addressLabel)
        containerView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            typeIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            typeIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            typeIcon.widthAnchor.constraint(equalToConstant: 30),
            typeIcon.heightAnchor.constraint(equalToConstant: 30),
            
            amountLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            amountLabel.leadingAnchor.constraint(equalTo: typeIcon.trailingAnchor, constant: 15),
            amountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            addressLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 5),
            addressLabel.leadingAnchor.constraint(equalTo: typeIcon.trailingAnchor, constant: 15),
            addressLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            dateLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: typeIcon.trailingAnchor, constant: 15),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15)
        ])
    }
    
    private func formatNumber(_ number: Double) -> String {
        if number < 0.0001 {
            return String(format: "%.8f", number)
        } else if number < 1 {
            return String(format: "%.4f", number)
        } else if number > 1000000 {
            return String(format: "%.2f", number)
        } else {
            return String(format: "%.2f", number)
        }
    }
    
    func configure(with transaction: Transaction) {
        switch transaction.type {
        case .receive:
            typeIcon.image = UIImage(systemName: "arrow.down.circle.fill")
            typeIcon.tintColor = .systemGreen
            amountLabel.text = "+\(formatNumber(transaction.amount)) \(transaction.currency)"
        case .send:
            typeIcon.image = UIImage(systemName: "arrow.up.circle.fill")
            typeIcon.tintColor = .systemRed
            amountLabel.text = "-\(formatNumber(transaction.amount)) \(transaction.currency)"
        case .exchange:
            typeIcon.image = UIImage(systemName: "arrow.triangle.2.circlepath.circle.fill")
            typeIcon.tintColor = .systemBlue
            if let details = transaction.details {
                amountLabel.text = "\(formatNumber(details.fromAmount)) \(details.fromCurrency) → \(formatNumber(details.toAmount)) \(details.toCurrency)"
                addressLabel.text = "Курс: 1 \(details.fromCurrency) = \(formatNumber(details.rate)) \(details.toCurrency)"
            } else {
                amountLabel.text = "\(formatNumber(transaction.amount)) \(transaction.currency)"
                addressLabel.text = "Обмен валют"
            }
        }
        
        if transaction.type != .exchange {
            addressLabel.text = transaction.address
        }
        
        dateLabel.text = formatDate(transaction.date)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
