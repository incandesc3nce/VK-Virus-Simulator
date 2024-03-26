//
//  ViewController.swift
//  VK Virus Simulator
//
//  Created by Dmitry on 24.03.2024.
//

import UIKit

class StartViewController: UIViewController {
    
    
    var peopleCountLabel: UILabel!
    var peopleCountTextField: UITextField!
    
    var infectCountLabel: UILabel!
    var infectCountTextField: UITextField!
    
    var infectPeriodLabel: UILabel!
    var infectPeriodTextField: UITextField!
    
    var startButton: UIButton!
    
    override func loadView() {
        
        view = UIView()
        
        // we need to make 3 lables (Количество людей в группе, Заражений при контакте, Период заражения), 3 text fields, where you should only input Int numbers, and 1 button (Запустить моделирование)

        peopleCountLabel = UILabel()
        peopleCountLabel.text = "Количество людей в группе"
        peopleCountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        peopleCountLabel.textColor = .white
        peopleCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(peopleCountLabel)

        
        peopleCountTextField = UITextField()
        peopleCountTextField.placeholder = "Введите число"
        peopleCountTextField.keyboardType = .numberPad
        peopleCountTextField.translatesAutoresizingMaskIntoConstraints = false
        peopleCountTextField.returnKeyType = .done
        peopleCountTextField.backgroundColor = .white
        peopleCountTextField.font = .systemFont(ofSize: 18)
        peopleCountTextField.textColor = .black
        peopleCountTextField.layer.cornerRadius = 10
        view.addSubview(peopleCountTextField)

        infectCountLabel = UILabel()
        infectCountLabel.text = "Заражений при контакте"
        infectCountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        infectCountLabel.textColor = .white
        infectCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infectCountLabel)

        infectCountTextField = UITextField()
        infectCountTextField.placeholder = "Введите число"
        infectCountTextField.keyboardType = .numberPad
        infectCountTextField.translatesAutoresizingMaskIntoConstraints = false
        infectCountTextField.returnKeyType = .done
        infectCountTextField.backgroundColor = .white
        infectCountTextField.font = .systemFont(ofSize: 18)
        infectCountTextField.textColor = .black
        infectCountTextField.layer.cornerRadius = 10
        view.addSubview(infectCountTextField)

        infectPeriodLabel = UILabel()
        infectPeriodLabel.text = "Период заражения"
        infectPeriodLabel.font = UIFont.boldSystemFont(ofSize: 20)
        infectPeriodLabel.textColor = .white
        infectPeriodLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infectPeriodLabel)

        infectPeriodTextField = UITextField()
        infectPeriodTextField.placeholder = "Введите число"
        infectPeriodTextField.keyboardType = .numbersAndPunctuation
        infectPeriodTextField.translatesAutoresizingMaskIntoConstraints = false
        infectPeriodTextField.returnKeyType = .done
        infectPeriodTextField.backgroundColor = .white
        infectPeriodTextField.font = .systemFont(ofSize: 18)
        infectPeriodTextField.textColor = .black
        infectPeriodTextField.layer.cornerRadius = 10
        view.addSubview(infectPeriodTextField)

        startButton = UIButton()
        startButton.setTitle("Запустить моделирование", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.backgroundColor = convertColorFromRGB(r: 54, g: 183, b: 82, alpha: 0.6)
        startButton.layer.cornerRadius = 10
        view.addSubview(startButton)


        let padding: CGFloat = 30
        NSLayoutConstraint.activate([
            peopleCountLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 80),
            peopleCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            peopleCountTextField.topAnchor.constraint(equalTo: peopleCountLabel.bottomAnchor, constant: 15),
            peopleCountTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            peopleCountTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            peopleCountTextField.heightAnchor.constraint(equalToConstant: 50),

            infectCountLabel.topAnchor.constraint(equalTo: peopleCountTextField.bottomAnchor, constant: padding),
            infectCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            infectCountTextField.topAnchor.constraint(equalTo: infectCountLabel.bottomAnchor, constant: 15),
            infectCountTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infectCountTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            infectCountTextField.heightAnchor.constraint(equalToConstant: 50),

            infectPeriodLabel.topAnchor.constraint(equalTo: infectCountTextField.bottomAnchor, constant: padding),
            infectPeriodLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            infectPeriodTextField.topAnchor.constraint(equalTo: infectPeriodLabel.bottomAnchor, constant: 15),
            infectPeriodTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infectPeriodTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            infectPeriodTextField.heightAnchor.constraint(equalToConstant: 50),

            startButton.topAnchor.constraint(equalTo: infectPeriodTextField.bottomAnchor, constant: 60),
            startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // настройка клавиатур, чтобы их можно было спрятать
        setupToolbar()
        initializeHideKeyboard()
        
        
        startButton.addTarget(self, action: #selector(startSimulation), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let startAlert = UIAlertController(title: "Добро пожаловать!", message: "Данное приложение создано в целях симуляции и визуализации распространение инфекции в группе людей.\nДля начала, введите количество людей в группе, количество заражаемых людей при контакте и период распространения инфекции.", preferredStyle: .alert)
        startAlert.addAction(UIAlertAction(title: "Начать", style: .default))
        
        present(startAlert, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }


}

