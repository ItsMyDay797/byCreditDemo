import UIKit

class ProfileViewController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Профиль"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemPurple
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = UserData.shared.name
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = UserData.shared.email
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let verificationStatusView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let verificationStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Верифицирован"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let verificationStatusIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.seal.fill")
        imageView.tintColor = .systemGreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let statsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let totalBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Общий баланс"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalBalanceValueLabel: UILabel = {
        let label = UILabel()
        label.text = String(format: "$%.2f", UserData.shared.balance)
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func createStatView(title: String, value: String) -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor(white: 1, alpha: 0.1)
        container.layer.cornerRadius = 8
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.textColor = .white.withAlphaComponent(0.7)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        valueLabel.textColor = .white
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.numberOfLines = 1
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.minimumScaleFactor = 0.7
        
        container.addSubview(titleLabel)
        container.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -4),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            valueLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 4),
            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -4),
            valueLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -6)
        ])
        
        return container
    }
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "Версия 1.0.0"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white.withAlphaComponent(0.5)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.layer.cornerRadius = 8
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupNotifications()
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
        totalBalanceValueLabel.text = String(format: "$%.2f", UserData.shared.balance)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.06, green: 0.11, blue: 0.23, alpha: 1.0)
        
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(avatarImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(emailLabel)
        containerView.addSubview(verificationStatusView)
        verificationStatusView.addSubview(verificationStatusLabel)
        verificationStatusView.addSubview(verificationStatusIcon)
        containerView.addSubview(statsContainer)
        statsContainer.addSubview(totalBalanceLabel)
        statsContainer.addSubview(totalBalanceValueLabel)
        statsContainer.addSubview(statsStackView)
        containerView.addSubview(versionLabel)
        containerView.addSubview(logoutButton)
        view.addSubview(closeButton)
        
        // Добавляем статистику
        let totalTransactionsView = createStatView(title: "Всего транзакций", value: "24")
        let activeLoansView = createStatView(title: "Активные кредиты", value: "2")
        let successRateView = createStatView(title: "Успешность", value: "98%")
        
        statsStackView.addArrangedSubview(totalTransactionsView)
        statsStackView.addArrangedSubview(activeLoansView)
        statsStackView.addArrangedSubview(successRateView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.85),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            avatarImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            avatarImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            emailLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            verificationStatusView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            verificationStatusView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            verificationStatusView.heightAnchor.constraint(equalToConstant: 30),
            
            verificationStatusLabel.leadingAnchor.constraint(equalTo: verificationStatusView.leadingAnchor, constant: 10),
            verificationStatusLabel.centerYAnchor.constraint(equalTo: verificationStatusView.centerYAnchor),
            
            verificationStatusIcon.leadingAnchor.constraint(equalTo: verificationStatusLabel.trailingAnchor, constant: 5),
            verificationStatusIcon.centerYAnchor.constraint(equalTo: verificationStatusView.centerYAnchor),
            verificationStatusIcon.trailingAnchor.constraint(equalTo: verificationStatusView.trailingAnchor, constant: -10),
            verificationStatusIcon.widthAnchor.constraint(equalToConstant: 20),
            verificationStatusIcon.heightAnchor.constraint(equalToConstant: 20),
            
            statsContainer.topAnchor.constraint(equalTo: verificationStatusView.bottomAnchor, constant: 10),
            statsContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            statsContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            statsContainer.heightAnchor.constraint(equalToConstant: 120),
            
            totalBalanceLabel.topAnchor.constraint(equalTo: statsContainer.topAnchor, constant: 15),
            totalBalanceLabel.leadingAnchor.constraint(equalTo: statsContainer.leadingAnchor, constant: 15),
            totalBalanceLabel.trailingAnchor.constraint(equalTo: statsContainer.trailingAnchor, constant: -15),
            
            totalBalanceValueLabel.topAnchor.constraint(equalTo: totalBalanceLabel.bottomAnchor, constant: 5),
            totalBalanceValueLabel.leadingAnchor.constraint(equalTo: statsContainer.leadingAnchor, constant: 15),
            totalBalanceValueLabel.trailingAnchor.constraint(equalTo: statsContainer.trailingAnchor, constant: -15),
            
            statsStackView.topAnchor.constraint(equalTo: totalBalanceValueLabel.bottomAnchor, constant: 10),
            statsStackView.leadingAnchor.constraint(equalTo: statsContainer.leadingAnchor, constant: 10),
            statsStackView.trailingAnchor.constraint(equalTo: statsContainer.trailingAnchor, constant: -10),
            statsStackView.bottomAnchor.constraint(equalTo: statsContainer.bottomAnchor, constant: -10),
            
            versionLabel.topAnchor.constraint(equalTo: statsContainer.bottomAnchor, constant: 20),
            versionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            versionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            logoutButton.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 20),
            logoutButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            logoutButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            logoutButton.heightAnchor.constraint(equalToConstant: 44),
            logoutButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
    
    @objc private func logoutTapped() {
        let alert = UIAlertController(
            title: "Выход",
            message: "Вы уверены, что хотите выйти из аккаунта?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Выйти", style: .destructive) { _ in
            NotificationCenter.default.post(name: .userDidLogout, object: nil)
            self.dismiss(animated: true)
        })
        
        present(alert, animated: true)
    }
}
