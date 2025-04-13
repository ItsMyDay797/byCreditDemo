import UIKit

class NotificationsViewController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Уведомления"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let notificationsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.06, green: 0.11, blue: 0.23, alpha: 1.0)
        
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(notificationsStack)
        
        // Добавляем настройки уведомлений
        addNotificationRow(title: "Push-уведомления", value: "Вкл", isToggle: true)
        addNotificationRow(title: "Транзакции", value: "Вкл", isToggle: true)
        addNotificationRow(title: "Обмен валют", value: "Вкл", isToggle: true)
        addNotificationRow(title: "Займы", value: "Вкл", isToggle: true)
        addNotificationRow(title: "Новости и акции", value: "Выкл", isToggle: true)
        addNotificationRow(title: "Email-уведомления", value: "Вкл", isToggle: true)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            notificationsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            notificationsStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            notificationsStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
    
    private func addNotificationRow(title: String, value: String, isToggle: Bool = false) {
        let rowView = UIView()
        rowView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        rowView.addSubview(titleLabel)
        
        if isToggle {
            let toggle = UISwitch()
            toggle.isOn = value == "Вкл"
            toggle.onTintColor = .systemBlue
            toggle.translatesAutoresizingMaskIntoConstraints = false
            rowView.addSubview(toggle)
            
            NSLayoutConstraint.activate([
                toggle.centerYAnchor.constraint(equalTo: rowView.centerYAnchor),
                toggle.trailingAnchor.constraint(equalTo: rowView.trailingAnchor)
            ])
        } else {
            let valueLabel = UILabel()
            valueLabel.text = value
            valueLabel.textColor = .white.withAlphaComponent(0.7)
            valueLabel.font = .systemFont(ofSize: 16)
            valueLabel.translatesAutoresizingMaskIntoConstraints = false
            rowView.addSubview(valueLabel)
            
            let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
            chevronImageView.tintColor = .white.withAlphaComponent(0.7)
            chevronImageView.translatesAutoresizingMaskIntoConstraints = false
            rowView.addSubview(chevronImageView)
            
            NSLayoutConstraint.activate([
                valueLabel.centerYAnchor.constraint(equalTo: rowView.centerYAnchor),
                valueLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),
                
                chevronImageView.centerYAnchor.constraint(equalTo: rowView.centerYAnchor),
                chevronImageView.trailingAnchor.constraint(equalTo: rowView.trailingAnchor),
                chevronImageView.widthAnchor.constraint(equalToConstant: 20),
                chevronImageView.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
        
        NSLayoutConstraint.activate([
            rowView.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.leadingAnchor.constraint(equalTo: rowView.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: rowView.centerYAnchor)
        ])
        
        notificationsStack.addArrangedSubview(rowView)
    }
}
