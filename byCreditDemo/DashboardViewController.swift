import UIKit

class DashboardViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        button.setImage(UIImage(systemName: "person.circle.fill")?
            .withConfiguration(config)
            .withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let transactionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "clock.arrow.circlepath"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = String(format: "$%.2f", UserData.shared.balance)
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let balanceChangeView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple.withAlphaComponent(0.3)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let balanceChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "+5.27%"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let actionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Мои активы"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loansButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Мои кредиты", for: .normal)
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupActions()
        setupNotifications()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.06, green: 0.11, blue: 0.23, alpha: 1.0)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(headerView)
        headerView.addSubview(profileButton)
        headerView.addSubview(transactionsButton)
        headerView.addSubview(balanceLabel)
        headerView.addSubview(balanceChangeView)
        balanceChangeView.addSubview(balanceChangeLabel)
        contentView.addSubview(actionStackView)
        contentView.addSubview(sectionTitleLabel)
        contentView.addSubview(loansButton)
        contentView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 120),
            
            profileButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            profileButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            profileButton.widthAnchor.constraint(equalToConstant: 40),
            profileButton.heightAnchor.constraint(equalToConstant: 40),
            
            transactionsButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            transactionsButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            transactionsButton.widthAnchor.constraint(equalToConstant: 40),
            transactionsButton.heightAnchor.constraint(equalToConstant: 40),
            
            balanceLabel.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 20),
            balanceLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            
            balanceChangeView.centerYAnchor.constraint(equalTo: balanceLabel.centerYAnchor),
            balanceChangeView.leadingAnchor.constraint(equalTo: balanceLabel.trailingAnchor, constant: 12),
            balanceChangeView.widthAnchor.constraint(equalToConstant: 80),
            balanceChangeView.heightAnchor.constraint(equalToConstant: 30),
            balanceChangeView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
            
            balanceChangeLabel.centerXAnchor.constraint(equalTo: balanceChangeView.centerXAnchor),
            balanceChangeLabel.centerYAnchor.constraint(equalTo: balanceChangeView.centerYAnchor),
            
            actionStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            actionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            actionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            sectionTitleLabel.topAnchor.constraint(equalTo: actionStackView.bottomAnchor, constant: 30),
            sectionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sectionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            loansButton.topAnchor.constraint(equalTo: sectionTitleLabel.bottomAnchor, constant: 15),
            loansButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            loansButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            loansButton.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: loansButton.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        createActionButtons()
    }
    
    private func setupActions() {
        loansButton.addTarget(self, action: #selector(loansButtonTapped), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        transactionsButton.addTarget(self, action: #selector(transactionsTapped), for: .touchUpInside)
    }
    
    @objc private func profileButtonTapped() {
        let profileVC = ProfileViewController()
        profileVC.modalPresentationStyle = .overFullScreen
        present(profileVC, animated: true)
    }
    
    @objc private func transactionsTapped() {
        let transactionsVC = TransactionsViewController()
        transactionsVC.modalPresentationStyle = .overFullScreen
        present(transactionsVC, animated: true)
    }
    
    private func createActionButtons() {
        let actions = [
            ("Получить", "arrow.down.circle.fill", UIColor.systemGreen),
            ("Отправить", "arrow.up.circle.fill", UIColor.systemBlue),
            ("Обменять", "arrow.triangle.2.circlepath.circle.fill", UIColor.systemPurple),
            ("Кредит", "dollarsign.circle.fill", UIColor.systemOrange)
        ]
        
        for (title, imageName, color) in actions {
            let container = createActionButton(title: title, imageName: imageName, color: color)
            if let button = container.subviews.first(where: { $0 is UIButton }) as? UIButton {
                switch title {
                case "Получить":
                    button.addTarget(self, action: #selector(receiveButtonTapped), for: .touchUpInside)
                case "Отправить":
                    button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
                case "Обменять":
                    button.addTarget(self, action: #selector(exchangeButtonTapped), for: .touchUpInside)
                case "Кредит":
                    button.addTarget(self, action: #selector(loanButtonTapped), for: .touchUpInside)
                default:
                    break
                }
            }
            actionStackView.addArrangedSubview(container)
        }
    }
    
    @objc private func receiveButtonTapped() {
        let receiveVC = ReceiveViewController()
        receiveVC.modalPresentationStyle = .pageSheet
        if let sheet = receiveVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        present(receiveVC, animated: true)
    }
    
    @objc private func sendButtonTapped() {
        let sendVC = SendViewController()
        sendVC.modalPresentationStyle = .pageSheet
        if let sheet = sendVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        present(sendVC, animated: true)
    }
    
    @objc private func exchangeButtonTapped() {
        let exchangeVC = ExchangeViewController()
        exchangeVC.modalPresentationStyle = .pageSheet
        if let sheet = exchangeVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        present(exchangeVC, animated: true)
    }
    
    @objc private func loanButtonTapped() {
        let loanVC = LoanViewController()
        loanVC.onLoanCreated = { [weak self] amount, term, collateral in
            self?.addNewLoan(amount: amount, term: term, collateral: collateral)
        }
        loanVC.modalPresentationStyle = .pageSheet
        if let sheet = loanVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        present(loanVC, animated: true)
    }
    
    private func addNewLoan(amount: Double, term: Int, collateral: Double) {
        // Добавляем новый кредит в список
        let newLoan = (amount: amount, term: term, collateral: collateral, date: Date())
        loans.append(newLoan)
        
        // Создаем транзакцию для займа
        let loanDetails = LoanDetails(
            term: term,
            collateral: collateral,
            collateralCurrency: "BTC"
        )
        
        let loanTransaction = Transaction(
            type: .loan,
            amount: amount,
            currency: "USDT",
            date: Date(),
            address: "Займ под залог",
            loanDetails: loanDetails
        )
        
        // Добавляем транзакцию в историю
        UserData.shared.addTransaction(loanTransaction)
        
        // Обновляем таблицу
        tableView.reloadData()
    }
    
    // Добавляем массив для хранения кредитов
    private var loans: [(amount: Double, term: Int, collateral: Double, date: Date)] = []
    
    @objc private func loansButtonTapped() {
        let loansVC = LoansViewController()
        loansVC.setLoans(loans)
        loansVC.modalPresentationStyle = .pageSheet
        if let sheet = loansVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        present(loansVC, animated: true)
    }
    
    private func createActionButton(title: String, imageName: String, color: UIColor) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton(type: .system)
        button.backgroundColor = color.withAlphaComponent(0.1)
        button.layer.cornerRadius = 25
        button.setImage(UIImage(systemName: imageName)?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 24, weight: .medium))
            .withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = color
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(button)
        container.addSubview(label)
        
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 90),
            
            button.topAnchor.constraint(equalTo: container.topAnchor),
            button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 50),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        
        return container
    }
    
    private func setupTableView() {
        tableView.register(CoinCell.self, forCellReuseIdentifier: "CoinCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(balanceDidChange),
            name: .balanceDidChange,
            object: nil
        )
    }
    
    @objc private func balanceDidChange() {
        balanceLabel.text = String(format: "$%.2f", UserData.shared.balance)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath) as! CoinCell
        
        let loan = loans[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        cell.configure(
            symbol: "LOAN",
            name: "Кредит #\(indexPath.row + 1)",
            price: String(format: "$%.2f", loan.amount),
            change: String(format: "%.4f BTC", loan.collateral)
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - CoinCell

class CoinCell: UITableViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let symbolContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
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
        containerView.addSubview(symbolContainer)
        symbolContainer.addSubview(symbolLabel)
        containerView.addSubview(nameLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(changeLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            symbolContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            symbolContainer.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            symbolContainer.widthAnchor.constraint(equalToConstant: 40),
            symbolContainer.heightAnchor.constraint(equalToConstant: 40),
            
            symbolLabel.centerXAnchor.constraint(equalTo: symbolContainer.centerXAnchor),
            symbolLabel.centerYAnchor.constraint(equalTo: symbolContainer.centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: symbolContainer.trailingAnchor, constant: 12),
            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            priceLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            
            changeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            changeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(symbol: String, name: String, price: String, change: String) {
        symbolLabel.text = symbol
        nameLabel.text = name
        priceLabel.text = price
        changeLabel.text = change
        changeLabel.textColor = change.hasPrefix("+") ? .systemGreen : .systemRed
    }
}
