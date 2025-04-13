import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.05)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Профиль"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemPurple
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = UserData.shared.name
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = UserData.shared.email
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Редактировать профиль", for: .normal)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        return button
    }()
    
    private let verificationStatusView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let verificationStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Верифицирован"
        label.font = .systemFont(ofSize: 16, weight: .medium)
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
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let totalBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Общий баланс"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalBalanceValueLabel: UILabel = {
        let label = UILabel()
        label.text = String(format: "$%.2f", UserData.shared.balance)
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let securityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "lock.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let notificationsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "Версия 1.0.0"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white.withAlphaComponent(0.5)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        button.tintColor = .systemRed
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
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
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(containerView)
        containerView.addSubview(headerView)
        headerView.addSubview(titleLabel)
        
        containerView.addSubview(avatarImageView)
        containerView.addSubview(cameraButton)
        containerView.addSubview(nameLabel)
        containerView.addSubview(emailLabel)
        containerView.addSubview(editProfileButton)
        
        containerView.addSubview(verificationStatusView)
        verificationStatusView.addSubview(verificationStatusLabel)
        verificationStatusView.addSubview(verificationStatusIcon)
        
        containerView.addSubview(statsContainer)
        statsContainer.addSubview(totalBalanceLabel)
        statsContainer.addSubview(totalBalanceValueLabel)
        statsContainer.addSubview(statsStackView)
        
        buttonsStackView.addArrangedSubview(settingsButton)
        buttonsStackView.addArrangedSubview(securityButton)
        buttonsStackView.addArrangedSubview(notificationsButton)
        containerView.addSubview(buttonsStackView)
        
        containerView.addSubview(versionLabel)
        containerView.addSubview(logoutButton)
        view.addSubview(closeButton)
        
        // Добавляем статистику
        let totalTransactionsView = createStatView(title: "Всего транзакций", value: "\(UserData.shared.transactions.count)")
        let activeLoansView = createStatView(title: "Активные займы", value: "\(UserData.shared.transactions.filter { $0.type == .loan }.count)")
        let successRateView = createStatView(title: "Успешность", value: "98%")
        
        statsStackView.addArrangedSubview(totalTransactionsView)
        statsStackView.addArrangedSubview(activeLoansView)
        statsStackView.addArrangedSubview(successRateView)
        
        // Загружаем сохраненный аватар
        if let savedAvatar = UserData.shared.avatarImage {
            avatarImageView.image = savedAvatar
        } else {
            avatarImageView.image = UIImage(systemName: "person.circle.fill")
        }
        
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
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            cameraButton.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            cameraButton.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            cameraButton.widthAnchor.constraint(equalToConstant: 30),
            cameraButton.heightAnchor.constraint(equalToConstant: 30),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            emailLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            editProfileButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
            editProfileButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            editProfileButton.widthAnchor.constraint(equalToConstant: 200),
            editProfileButton.heightAnchor.constraint(equalToConstant: 40),
            
            verificationStatusView.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 16),
            verificationStatusView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            verificationStatusView.heightAnchor.constraint(equalToConstant: 40),
            
            verificationStatusLabel.leadingAnchor.constraint(equalTo: verificationStatusView.leadingAnchor, constant: 16),
            verificationStatusLabel.centerYAnchor.constraint(equalTo: verificationStatusView.centerYAnchor),
            
            verificationStatusIcon.leadingAnchor.constraint(equalTo: verificationStatusLabel.trailingAnchor, constant: 8),
            verificationStatusIcon.centerYAnchor.constraint(equalTo: verificationStatusView.centerYAnchor),
            verificationStatusIcon.trailingAnchor.constraint(equalTo: verificationStatusView.trailingAnchor, constant: -16),
            verificationStatusIcon.widthAnchor.constraint(equalToConstant: 20),
            verificationStatusIcon.heightAnchor.constraint(equalToConstant: 20),
            
            statsContainer.topAnchor.constraint(equalTo: verificationStatusView.bottomAnchor, constant: 20),
            statsContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            statsContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            totalBalanceLabel.topAnchor.constraint(equalTo: statsContainer.topAnchor, constant: 16),
            totalBalanceLabel.leadingAnchor.constraint(equalTo: statsContainer.leadingAnchor, constant: 16),
            
            totalBalanceValueLabel.topAnchor.constraint(equalTo: totalBalanceLabel.bottomAnchor, constant: 8),
            totalBalanceValueLabel.leadingAnchor.constraint(equalTo: statsContainer.leadingAnchor, constant: 16),
            
            statsStackView.topAnchor.constraint(equalTo: totalBalanceValueLabel.bottomAnchor, constant: 16),
            statsStackView.leadingAnchor.constraint(equalTo: statsContainer.leadingAnchor, constant: 16),
            statsStackView.trailingAnchor.constraint(equalTo: statsContainer.trailingAnchor, constant: -16),
            statsStackView.bottomAnchor.constraint(equalTo: statsContainer.bottomAnchor, constant: -16),
            
            buttonsStackView.topAnchor.constraint(equalTo: statsContainer.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 50),
            
            versionLabel.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 20),
            versionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            logoutButton.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 16),
            logoutButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            logoutButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
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
        editProfileButton.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
        cameraButton.addTarget(self, action: #selector(changeAvatarTapped), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        securityButton.addTarget(self, action: #selector(securityTapped), for: .touchUpInside)
        notificationsButton.addTarget(self, action: #selector(notificationsTapped), for: .touchUpInside)
    }
    
    @objc private func editProfileTapped() {
        let alert = UIAlertController(title: "Редактирование профиля", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Имя"
            textField.text = UserData.shared.name
            textField.autocapitalizationType = .words
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Email"
            textField.text = UserData.shared.email
            textField.keyboardType = .emailAddress
            textField.autocapitalizationType = .none
        }
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
            guard let self = self,
                  let name = alert.textFields?[0].text,
                  let email = alert.textFields?[1].text,
                  !name.isEmpty,
                  !email.isEmpty else {
                return
            }
            
            // Обновляем данные пользователя
            UserData.shared.name = name
            UserData.shared.email = email
            
            // Обновляем UI
            self.nameLabel.text = name
            self.emailLabel.text = email
            
            // Показываем уведомление об успешном обновлении
            let successAlert = UIAlertController(
                title: "Успешно",
                message: "Профиль обновлен",
                preferredStyle: .alert
            )
            successAlert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(successAlert, animated: true)
        })
        
        present(alert, animated: true)
    }
    
    @objc private func changeAvatarTapped() {
        let alert = UIAlertController(title: "Выберите фото", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Сделать фото", style: .default) { [weak self] _ in
            self?.openCamera()
        })
        
        alert.addAction(UIAlertAction(title: "Выбрать из галереи", style: .default) { [weak self] _ in
            self?.openPhotoLibrary()
        })
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func openCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    private func openPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    @objc private func settingsTapped() {
        let settingsVC = SettingsViewController()
        settingsVC.modalPresentationStyle = .pageSheet
        if let sheet = settingsVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(settingsVC, animated: true)
    }
    
    @objc private func securityTapped() {
        let securityVC = SecurityViewController()
        securityVC.modalPresentationStyle = .pageSheet
        if let sheet = securityVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(securityVC, animated: true)
    }
    
    @objc private func notificationsTapped() {
        let notificationsVC = NotificationsViewController()
        notificationsVC.modalPresentationStyle = .pageSheet
        if let sheet = notificationsVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(notificationsVC, animated: true)
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
    
    private func createStatView(title: String, value: String) -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor(white: 1, alpha: 0.1)
        container.layer.cornerRadius = 12
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .white.withAlphaComponent(0.7)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        valueLabel.textColor = .white
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.numberOfLines = 1
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.minimumScaleFactor = 0.7
        
        container.addSubview(titleLabel)
        container.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            valueLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            valueLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8)
        ])
        
        return container
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            avatarImageView.image = editedImage
            UserData.shared.avatarImage = editedImage
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
