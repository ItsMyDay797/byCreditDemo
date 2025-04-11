import UIKit

class LoansViewController: UIViewController {
    
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
        label.text = "Мои кредиты"
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
    
    private let loansStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "Активных кредитов нет"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emptyStateIcon: UIImageView = {
        let imageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium)
        imageView.image = UIImage(systemName: "doc.text.magnifyingglass")?
            .withConfiguration(config)
            .withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white.withAlphaComponent(0.5)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emptyStateContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Заменяем статические данные на динамические
    private var loans: [(amount: Double, term: Int, collateral: Double, date: Date)] = []
    
    func setLoans(_ loans: [(amount: Double, term: Int, collateral: Double, date: Date)]) {
        self.loans = loans
        
        // Очищаем стек перед добавлением новых кредитов
        loansStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if loans.isEmpty {
            emptyStateContainer.addSubview(emptyStateIcon)
            emptyStateContainer.addSubview(emptyStateLabel)
            
            NSLayoutConstraint.activate([
                emptyStateIcon.topAnchor.constraint(equalTo: emptyStateContainer.topAnchor, constant: 30),
                emptyStateIcon.centerXAnchor.constraint(equalTo: emptyStateContainer.centerXAnchor),
                
                emptyStateLabel.topAnchor.constraint(equalTo: emptyStateIcon.bottomAnchor, constant: 15),
                emptyStateLabel.leadingAnchor.constraint(equalTo: emptyStateContainer.leadingAnchor, constant: 20),
                emptyStateLabel.trailingAnchor.constraint(equalTo: emptyStateContainer.trailingAnchor, constant: -20),
                emptyStateLabel.bottomAnchor.constraint(equalTo: emptyStateContainer.bottomAnchor, constant: -30)
            ])
            
            loansStackView.addArrangedSubview(emptyStateContainer)
        } else {
            setupLoans()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.06, green: 0.11, blue: 0.23, alpha: 1.0)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(closeButton)
        contentView.addSubview(loansStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
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
            
            loansStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            loansStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            loansStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            loansStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    }
    
    private func setupLoans() {
        loans.forEach { loan in
            let loanView = createLoanView(amount: loan.amount, term: loan.term, collateral: loan.collateral, date: loan.date)
            loansStackView.addArrangedSubview(loanView)
        }
    }
    
    private func createLoanView(amount: Double, term: Int, collateral: Double, date: Date) -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor(white: 1, alpha: 0.1)
        container.layer.cornerRadius = 12
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let amountLabel = UILabel()
        amountLabel.text = String(format: "Сумма: $%.2f", amount)
        amountLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        amountLabel.textColor = .white
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let termLabel = UILabel()
        termLabel.text = "Срок: \(term) дней"
        termLabel.font = .systemFont(ofSize: 14)
        termLabel.textColor = .white.withAlphaComponent(0.7)
        termLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let collateralLabel = UILabel()
        collateralLabel.text = String(format: "Залог: %.4f BTC", collateral)
        collateralLabel.font = .systemFont(ofSize: 14)
        collateralLabel.textColor = .white.withAlphaComponent(0.7)
        collateralLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let dateLabel = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateLabel.text = "Дата: \(dateFormatter.string(from: date))"
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .white.withAlphaComponent(0.7)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Вычисляем оставшиеся дни
        let calendar = Calendar.current
        let endDate = calendar.date(byAdding: .day, value: term, to: date)!
        let remainingDays = calendar.dateComponents([.day], from: Date(), to: endDate).day ?? 0
        
        let remainingDaysLabel = UILabel()
        remainingDaysLabel.text = "Осталось дней: \(max(0, remainingDays))"
        remainingDaysLabel.font = .systemFont(ofSize: 14)
        remainingDaysLabel.textColor = remainingDays > 0 ? .systemGreen : .systemRed
        remainingDaysLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Вычисляем следующую оплату (12% годовых, разбитые на месяцы)
        let monthlyPayment = (amount * 0.12 / 12) + (amount / Double(term) * 30)
        let nextPaymentDate = calendar.date(byAdding: .month, value: 1, to: date)!
        let nextPaymentLabel = UILabel()
        nextPaymentLabel.text = String(format: "Следующая оплата: $%.2f (%@)",
                                     monthlyPayment,
                                     dateFormatter.string(from: nextPaymentDate))
        nextPaymentLabel.font = .systemFont(ofSize: 14)
        nextPaymentLabel.textColor = .white.withAlphaComponent(0.7)
        nextPaymentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(amountLabel)
        container.addSubview(termLabel)
        container.addSubview(collateralLabel)
        container.addSubview(dateLabel)
        container.addSubview(remainingDaysLabel)
        container.addSubview(nextPaymentLabel)
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 15),
            amountLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            amountLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15),
            
            termLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
            termLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            
            collateralLabel.topAnchor.constraint(equalTo: termLabel.bottomAnchor, constant: 8),
            collateralLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            
            dateLabel.topAnchor.constraint(equalTo: collateralLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            
            remainingDaysLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            remainingDaysLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            
            nextPaymentLabel.topAnchor.constraint(equalTo: remainingDaysLabel.bottomAnchor, constant: 8),
            nextPaymentLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            nextPaymentLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -15)
        ])
        
        return container
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}
