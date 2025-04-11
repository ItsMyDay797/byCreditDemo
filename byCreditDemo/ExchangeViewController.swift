import UIKit

class ExchangeViewController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Обмен средств"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fromAmountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Сумма для обмена"
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.textColor = .white
        textField.tintColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Сумма для обмена",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        textField.keyboardType = .decimalPad
        textField.layer.cornerRadius = 12
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let fromCurrencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BTC", for: .normal)
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let toAmountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Получаемая сумма"
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.textColor = .white
        textField.tintColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Получаемая сумма",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        textField.keyboardType = .decimalPad
        textField.layer.cornerRadius = 12
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.isEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let toCurrencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("USDT", for: .normal)
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let exchangeRateLabel: UILabel = {
        let label = UILabel()
        label.text = "Курс обмена: 1 BTC = 50000 USDT"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let networkFeeLabel: UILabel = {
        let label = UILabel()
        label.text = "Комиссия сети: 0.0001 BTC"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let availableBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Доступно: 1.2345 BTC"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let exchangeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Обменять", for: .normal)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        button.setImage(UIImage(systemName: "xmark.circle.fill")?
            .withConfiguration(config)
            .withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let swapButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        button.setImage(UIImage(systemName: "arrow.triangle.2.circlepath")?
            .withConfiguration(config)
            .withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupKeyboardHandling()
        updateExchangeRate()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.06, green: 0.11, blue: 0.23, alpha: 1.0)
        
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(fromAmountTextField)
        containerView.addSubview(fromCurrencyButton)
        containerView.addSubview(swapButton)
        containerView.addSubview(toAmountTextField)
        containerView.addSubview(toCurrencyButton)
        containerView.addSubview(exchangeRateLabel)
        containerView.addSubview(networkFeeLabel)
        containerView.addSubview(availableBalanceLabel)
        containerView.addSubview(exchangeButton)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            fromAmountTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            fromAmountTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            fromAmountTextField.trailingAnchor.constraint(equalTo: fromCurrencyButton.leadingAnchor, constant: -10),
            fromAmountTextField.heightAnchor.constraint(equalToConstant: 50),
            
            fromCurrencyButton.topAnchor.constraint(equalTo: fromAmountTextField.topAnchor),
            fromCurrencyButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            fromCurrencyButton.widthAnchor.constraint(equalToConstant: 80),
            fromCurrencyButton.heightAnchor.constraint(equalToConstant: 50),
            
            swapButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            swapButton.topAnchor.constraint(equalTo: fromAmountTextField.bottomAnchor, constant: 20),
            swapButton.widthAnchor.constraint(equalToConstant: 40),
            swapButton.heightAnchor.constraint(equalToConstant: 40),
            
            toAmountTextField.topAnchor.constraint(equalTo: swapButton.bottomAnchor, constant: 20),
            toAmountTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            toAmountTextField.trailingAnchor.constraint(equalTo: toCurrencyButton.leadingAnchor, constant: -10),
            toAmountTextField.heightAnchor.constraint(equalToConstant: 50),
            
            toCurrencyButton.topAnchor.constraint(equalTo: toAmountTextField.topAnchor),
            toCurrencyButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            toCurrencyButton.widthAnchor.constraint(equalToConstant: 80),
            toCurrencyButton.heightAnchor.constraint(equalToConstant: 50),
            
            exchangeRateLabel.topAnchor.constraint(equalTo: toAmountTextField.bottomAnchor, constant: 15),
            exchangeRateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            exchangeRateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            networkFeeLabel.topAnchor.constraint(equalTo: exchangeRateLabel.bottomAnchor, constant: 8),
            networkFeeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            networkFeeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            availableBalanceLabel.topAnchor.constraint(equalTo: networkFeeLabel.bottomAnchor, constant: 8),
            availableBalanceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            availableBalanceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            exchangeButton.topAnchor.constraint(equalTo: availableBalanceLabel.bottomAnchor, constant: 20),
            exchangeButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            exchangeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            exchangeButton.heightAnchor.constraint(equalToConstant: 50),
            exchangeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        exchangeButton.addTarget(self, action: #selector(exchangeTapped), for: .touchUpInside)
        fromAmountTextField.addTarget(self, action: #selector(amountChanged), for: .editingChanged)
        fromCurrencyButton.addTarget(self, action: #selector(fromCurrencyTapped), for: .touchUpInside)
        toCurrencyButton.addTarget(self, action: #selector(toCurrencyTapped), for: .touchUpInside)
        swapButton.addTarget(self, action: #selector(swapCurrencies), for: .touchUpInside)
    }
    
    private func setupKeyboardHandling() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
    
    @objc private func fromCurrencyTapped() {
        showCurrencyPicker(for: fromCurrencyButton) { [weak self] in
            self?.updateExchangeRate()
            self?.updateAvailableBalance()
        }
    }
    
    @objc private func toCurrencyTapped() {
        showCurrencyPicker(for: toCurrencyButton) { [weak self] in
            self?.updateExchangeRate()
        }
    }
    
    @objc private func swapCurrencies() {
        let fromCurrency = fromCurrencyButton.title(for: .normal)
        let toCurrency = toCurrencyButton.title(for: .normal)
        
        fromCurrencyButton.setTitle(toCurrency, for: .normal)
        toCurrencyButton.setTitle(fromCurrency, for: .normal)
        
        updateExchangeRate()
        updateAvailableBalance()
    }
    
    private func showCurrencyPicker(for button: UIButton, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "Выберите валюту", message: nil, preferredStyle: .actionSheet)
        
        let currencies = [
            ("BTC", "bitcoinsign.circle.fill"),
            ("ETH", "ethereum.circle.fill"),
            ("USDT", "dollarsign.circle.fill"),
            ("BNB", "b.circle.fill"),
            ("SOL", "s.circle.fill"),
            ("ADA", "a.circle.fill"),
            ("DOT", "d.circle.fill"),
            ("XRP", "x.circle.fill")
        ]
        
        for (currency, icon) in currencies {
            let action = UIAlertAction(title: currency, style: .default) { _ in
                button.setTitle(currency, for: .normal)
                completion()
            }
            if let image = UIImage(systemName: icon) {
                action.setValue(image.withRenderingMode(.alwaysTemplate), forKey: "image")
            }
            alert.addAction(action)
        }
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func amountChanged() {
        updateToAmount()
    }
    
    private func updateExchangeRate() {
        let fromCurrency = fromCurrencyButton.title(for: .normal) ?? "BTC"
        let toCurrency = toCurrencyButton.title(for: .normal) ?? "USDT"
        let rate = getExchangeRate(from: fromCurrency, to: toCurrency)
        exchangeRateLabel.text = "Курс обмена: 1 \(fromCurrency) = \(formatNumber(rate)) \(toCurrency)"
    }
    
    private func updateToAmount() {
        guard let amount = Double(fromAmountTextField.text ?? ""),
              let fromCurrency = fromCurrencyButton.title(for: .normal),
              let toCurrency = toCurrencyButton.title(for: .normal) else {
            toAmountTextField.text = ""
            return
        }
        
        let rate = getExchangeRate(from: fromCurrency, to: toCurrency)
        let fee = getNetworkFee(for: fromCurrency)
        let total = (amount - fee) * rate
        toAmountTextField.text = formatNumber(total)
        
        networkFeeLabel.text = "Комиссия сети: \(formatNumber(fee)) \(fromCurrency)"
    }
    
    private func updateAvailableBalance() {
        let currency = fromCurrencyButton.title(for: .normal) ?? "BTC"
        let balance = getBalance(for: currency)
        availableBalanceLabel.text = "Доступно: \(balance) \(currency)"
    }
    
    private func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = ""
        return formatter.string(from: NSNumber(value: number)) ?? "0"
    }
    
    private func getExchangeRate(from: String, to: String) -> Double {
        // В реальном приложении здесь был бы запрос к API для получения актуального курса
        switch (from, to) {
        case ("BTC", "USDT"): return 65000.0
        case ("USDT", "BTC"): return 1 / 65000.0
        case ("ETH", "USDT"): return 3500.0
        case ("USDT", "ETH"): return 1 / 3500.0
        case ("BNB", "USDT"): return 500.0
        case ("USDT", "BNB"): return 1 / 500.0
        default: return 1.0
        }
    }
    
    private func getBalance(for currency: String) -> String {
        // В реальном приложении здесь был бы запрос баланса
        switch currency {
        case "BTC": return "1.2345"
        case "ETH": return "5.6789"
        case "USDT": return "1000.00"
        case "BNB": return "10.0000"
        case "SOL": return "100.0000"
        case "ADA": return "10000.0000"
        case "DOT": return "500.0000"
        case "XRP": return "10000.0000"
        default: return "0.0000"
        }
    }
    
    private func getNetworkFee(for currency: String) -> Double {
        // В реальном приложении здесь был бы расчет комиссии
        switch currency {
        case "BTC": return 0.0001
        case "ETH": return 0.001
        case "USDT": return 1.0
        case "BNB": return 0.0005
        case "SOL": return 0.01
        case "ADA": return 1.0
        case "DOT": return 0.1
        case "XRP": return 0.1
        default: return 0.0
        }
    }
    
    @objc private func exchangeTapped() {
        guard let amountText = fromAmountTextField.text,
              let amount = Double(amountText),
              let fromCurrency = fromCurrencyButton.title(for: .normal),
              let toCurrency = toCurrencyButton.title(for: .normal) else {
            showError(message: "Пожалуйста, введите сумму для обмена")
            return
        }
        
        // Проверяем достаточно ли средств
        guard amount <= UserData.shared.balance else {
            showError(message: "Недостаточно средств")
            return
        }
        
        let rate = getExchangeRate(from: fromCurrency, to: toCurrency)
        let receivedAmount = amount * rate
        
        let alert = UIAlertController(
            title: "Подтверждение обмена",
            message: "Вы хотите обменять \(formatNumber(amount)) \(fromCurrency) на \(formatNumber(receivedAmount)) \(toCurrency)?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Обменять", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            // Создаем детали транзакции
            let details = ExchangeDetails(
                fromAmount: amount,
                fromCurrency: fromCurrency,
                toAmount: receivedAmount,
                toCurrency: toCurrency,
                rate: rate,
                fee: self.getNetworkFee(for: fromCurrency)
            )
            
            // Создаем транзакцию обмена с деталями
            let exchangeTransaction = Transaction(
                type: Transaction.TransactionType.exchange,
                amount: amount,
                currency: "\(fromCurrency) → \(toCurrency)",
                date: Date(),
                address: "Курс: 1 \(fromCurrency) = \(self.formatNumber(rate)) \(toCurrency)",
                details: details
            )
            
            // Сохраняем транзакцию
            UserData.shared.addTransaction(exchangeTransaction)
            
            self.dismiss(animated: true)
        })
        
        present(alert, animated: true)
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
