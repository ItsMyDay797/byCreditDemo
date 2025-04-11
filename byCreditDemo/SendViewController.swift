import UIKit

class SendViewController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Отправить средства"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BTC", for: .normal)
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Сумма"
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.textColor = .white
        textField.tintColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Сумма",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        textField.keyboardType = .decimalPad
        textField.layer.cornerRadius = 12
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Адрес получателя"
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.textColor = .white
        textField.tintColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Адрес получателя",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        textField.layer.cornerRadius = 12
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let networkFeeLabel: UILabel = {
        let label = UILabel()
        label.text = "Комиссия сети: 0.0001 BTC"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "Итого к отправке: 0 BTC"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отправить", for: .normal)
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
    
    private let availableBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Доступно: 1.2345 BTC"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var selectedCurrency: String {
        return currencyButton.title(for: .normal) ?? "BTC"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupKeyboardHandling()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.06, green: 0.11, blue: 0.23, alpha: 1.0)
        
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(currencyButton)
        containerView.addSubview(amountTextField)
        containerView.addSubview(availableBalanceLabel)
        containerView.addSubview(addressTextField)
        containerView.addSubview(networkFeeLabel)
        containerView.addSubview(totalAmountLabel)
        containerView.addSubview(sendButton)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            currencyButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            currencyButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            currencyButton.widthAnchor.constraint(equalToConstant: 80),
            currencyButton.heightAnchor.constraint(equalToConstant: 50),
            
            amountTextField.topAnchor.constraint(equalTo: currencyButton.topAnchor),
            amountTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            amountTextField.trailingAnchor.constraint(equalTo: currencyButton.leadingAnchor, constant: -10),
            amountTextField.heightAnchor.constraint(equalToConstant: 50),
            
            availableBalanceLabel.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 8),
            availableBalanceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            availableBalanceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            addressTextField.topAnchor.constraint(equalTo: availableBalanceLabel.bottomAnchor, constant: 20),
            addressTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            addressTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            addressTextField.heightAnchor.constraint(equalToConstant: 50),
            
            networkFeeLabel.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 15),
            networkFeeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            networkFeeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            totalAmountLabel.topAnchor.constraint(equalTo: networkFeeLabel.bottomAnchor, constant: 8),
            totalAmountLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            totalAmountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            sendButton.topAnchor.constraint(equalTo: totalAmountLabel.bottomAnchor, constant: 20),
            sendButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
            sendButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        amountTextField.addTarget(self, action: #selector(amountChanged), for: .editingChanged)
        currencyButton.addTarget(self, action: #selector(currencyTapped), for: .touchUpInside)
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
    
    @objc private func currencyTapped() {
        let alert = UIAlertController(title: "Выберите валюту", message: nil, preferredStyle: .actionSheet)
        
        let currencies = [
            ("BTC", "bitcoinsign.circle.fill"),
            ("ETH", "ethereum.circle.fill"),
            ("USDT", "dollarsign.circle.fill"),
            ("BNB", "b.circle.fill")
        ]
        
        for (currency, icon) in currencies {
            let action = UIAlertAction(title: currency, style: .default) { [weak self] _ in
                self?.currencyButton.setTitle(currency, for: .normal)
                self?.updateAvailableBalance()
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
        updateTotalAmount()
    }
    
    private func updateAvailableBalance() {
        let currency = currencyButton.title(for: .normal) ?? "BTC"
        let balance = getBalance(for: currency)
        availableBalanceLabel.text = "Доступно: \(balance) \(currency)"
    }
    
    private func updateTotalAmount() {
        guard let amount = Double(amountTextField.text ?? ""),
              let currency = currencyButton.title(for: .normal) else {
            totalAmountLabel.text = "Итого: 0 \(currencyButton.title(for: .normal) ?? "")"
            return
        }
        
        let fee = getNetworkFee(for: currency)
        let total = amount + fee
        totalAmountLabel.text = "Итого: \(formatNumber(total)) \(currency)"
    }
    
    private func getBalance(for currency: String) -> String {
        // Используем реальный баланс из UserData
        return String(format: "%.8f", UserData.shared.balance)
    }
    
    private func getNetworkFee(for currency: String) -> Double {
        // В реальном приложении здесь был бы расчет комиссии
        switch currency {
        case "BTC": return 0.0001
        case "ETH": return 0.001
        case "USDT": return 1.0
        case "BNB": return 0.0005
        default: return 0.0
        }
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
    
    @objc private func sendTapped() {
        guard let amountText = amountTextField.text,
              let amount = Double(amountText),
              let address = addressTextField.text,
              !address.isEmpty else {
            showError(message: "Пожалуйста, заполните все поля")
            return
        }
        
        // Проверяем достаточно ли средств
        let fee = getNetworkFee(for: selectedCurrency)
        let total = amount + fee
        
        guard total <= UserData.shared.balance else {
            showError(message: "Недостаточно средств")
            return
        }
        
        let alert = UIAlertController(
            title: "Подтверждение",
            message: "Вы уверены, что хотите отправить \(formatNumber(amount)) \(selectedCurrency) на адрес \(address)?\nКомиссия сети: \(formatNumber(fee)) \(selectedCurrency)\nИтого: \(formatNumber(total)) \(selectedCurrency)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Отправить", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            // Создаем транзакцию
            let transaction = Transaction(
                type: .send,
                amount: amount,
                currency: self.selectedCurrency,
                date: Date(),
                address: address
            )
            
            // Сохраняем транзакцию (баланс обновится автоматически в UserData)
            UserData.shared.addTransaction(transaction)
            
            // Закрываем окно
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
