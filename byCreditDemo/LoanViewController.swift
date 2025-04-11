import UIKit

class LoanViewController: UIViewController {
    
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Оформление займа"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Сумма займа"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.textColor = .white
        textField.tintColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите сумму",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        textField.keyboardType = .decimalPad
        textField.layer.cornerRadius = 12
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let termLabel: UILabel = {
        let label = UILabel()
        label.text = "Срок займа (дней)"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let termTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.textColor = .white
        textField.tintColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите количество дней",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 12
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let collateralLabel: UILabel = {
        let label = UILabel()
        label.text = "Залог (в BTC)"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collateralTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.textColor = .white
        textField.tintColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введите сумму залога",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        textField.keyboardType = .decimalPad
        textField.layer.cornerRadius = 12
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let interestRateLabel: UILabel = {
        let label = UILabel()
        label.text = "Процентная ставка: 12% годовых"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalRepaymentLabel: UILabel = {
        let label = UILabel()
        label.text = "Сумма к возврату: $0"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Оформить займ", for: .normal)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var onLoanCreated: ((Double, Int, Double) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupKeyboardHandling()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.06, green: 0.11, blue: 0.23, alpha: 1.0)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(closeButton)
        contentView.addSubview(amountLabel)
        contentView.addSubview(amountTextField)
        contentView.addSubview(termLabel)
        contentView.addSubview(termTextField)
        contentView.addSubview(collateralLabel)
        contentView.addSubview(collateralTextField)
        contentView.addSubview(infoView)
        infoView.addSubview(interestRateLabel)
        infoView.addSubview(totalRepaymentLabel)
        contentView.addSubview(confirmButton)
        
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
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            
            amountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            amountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            amountTextField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
            amountTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            amountTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            amountTextField.heightAnchor.constraint(equalToConstant: 50),
            
            termLabel.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 20),
            termLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            termTextField.topAnchor.constraint(equalTo: termLabel.bottomAnchor, constant: 8),
            termTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            termTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            termTextField.heightAnchor.constraint(equalToConstant: 50),
            
            collateralLabel.topAnchor.constraint(equalTo: termTextField.bottomAnchor, constant: 20),
            collateralLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            collateralTextField.topAnchor.constraint(equalTo: collateralLabel.bottomAnchor, constant: 8),
            collateralTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            collateralTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            collateralTextField.heightAnchor.constraint(equalToConstant: 50),
            
            infoView.topAnchor.constraint(equalTo: collateralTextField.bottomAnchor, constant: 30),
            infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            interestRateLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 15),
            interestRateLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 15),
            interestRateLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -15),
            
            totalRepaymentLabel.topAnchor.constraint(equalTo: interestRateLabel.bottomAnchor, constant: 8),
            totalRepaymentLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 15),
            totalRepaymentLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -15),
            totalRepaymentLabel.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -15),
            
            confirmButton.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 30),
            confirmButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
            confirmButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        
        [amountTextField, termTextField, collateralTextField].forEach { textField in
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
    
    @objc private func confirmTapped() {
        guard let amount = Double(amountTextField.text ?? ""),
              let term = Int(termTextField.text ?? ""),
              let collateral = Double(collateralTextField.text ?? "") else {
            // Показать ошибку
            return
        }
        
        // В реальном приложении здесь была бы логика оформления займа
        let alert = UIAlertController(
            title: "Успешно!",
            message: "Ваш займ успешно оформлен",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.onLoanCreated?(amount, term, collateral)
            self?.dismiss(animated: true)
        })
        
        present(alert, animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        calculateRepayment()
    }
    
    private func calculateRepayment() {
        guard let amountText = amountTextField.text,
              let amount = Double(amountText),
              let termText = termTextField.text,
              let term = Double(termText) else {
            totalRepaymentLabel.text = "Сумма к возврату: $0"
            return
        }
        
        // Простой расчет суммы к возврату (12% годовых)
        let interest = amount * 0.12 * (term / 365.0)
        let total = amount + interest
        
        totalRepaymentLabel.text = String(format: "Сумма к возврату: $%.2f", total)
    }
    
    private func setupKeyboardHandling() {
        // Добавляем жест нажатия для скрытия клавиатуры
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        // Подписываемся на уведомления о появлении/скрытии клавиатуры
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        // Настраиваем делегаты для текстовых полей
        [amountTextField, termTextField, collateralTextField].forEach { textField in
            textField.delegate = self
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        // Определяем активное текстовое поле
        guard let activeField = [amountTextField, termTextField, collateralTextField].first(where: { $0.isFirstResponder }) else {
            return
        }
        
        // Прокручиваем до активного поля
        let frameInContentView = activeField.convert(activeField.bounds, to: scrollView)
        let targetRect = frameInContentView.insetBy(dx: 0, dy: -20)
        scrollView.scrollRectToVisible(targetRect, animated: true)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UITextFieldDelegate
extension LoanViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Разрешаем только цифры и точку
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        let characterSet = CharacterSet(charactersIn: string)
        
        // Проверяем, что новый символ является допустимым
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }
        
        // Получаем текущий текст и новый текст после изменения
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // Проверяем, что в строке только одна точка
        if string == "." {
            return !currentText.contains(".")
        }
        
        // Ограничиваем количество символов после точки
        if updatedText.contains(".") {
            let components = updatedText.components(separatedBy: ".")
            if components.count > 1 && components[1].count > 2 {
                return false
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Определяем следующее поле для ввода
        switch textField {
        case amountTextField:
            termTextField.becomeFirstResponder()
        case termTextField:
            collateralTextField.becomeFirstResponder()
        case collateralTextField:
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
