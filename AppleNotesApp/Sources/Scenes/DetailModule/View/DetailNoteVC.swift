//
//  DetailNoteVC.swift
//  AppleNotesApp
//
//  Created by Анна Лошакова on 11.10.2022.
//

import UIKit

class DetailNoteVC: UIViewController {
    
    // MARK: - Properties
    
    private var presenter: DetailNotePresenterInput?

    // MARK: - Outlets
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private lazy var titleText = createTextViewWith(font: .boldSystemFont(ofSize: 32))
    private lazy var bodyText = createTextViewWith(font: .systemFont(ofSize: 17))

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationController()
        setupToolBar()
        setupView()
        setupHierarchy()
        setupLayouts()
    }
    
    // MARK: - Setup
    
    private func setupNavigationController() {

        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .systemYellow
    }
    
    private func setupToolBar() {
        
        navigationController?.setToolbarHidden(false, animated: false)

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: self,
                                     action: nil)
        let checklistTool = UIBarButtonItem(image: UIImage(systemName: "checklist"),
                                            style: .plain,
                                            target: self,
                                            action: nil)
        let cameraTool = UIBarButtonItem(barButtonSystemItem: .camera,
                                          target: self,
                                          action: nil)
        let pencilTool = UIBarButtonItem(image: UIImage(systemName: "pencil.tip.crop.circle"),
                                            style: .plain,
                                            target: self,
                                            action: nil)
        let newNoteTool = UIBarButtonItem(barButtonSystemItem: .compose,
                                          target: self,
                                          action: nil)
        
        toolbarItems = [checklistTool, spacer, cameraTool, spacer, pencilTool, spacer,newNoteTool]
        navigationController?.toolbar.tintColor = .systemYellow
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(titleText)
        scrollView.addSubview(bodyText)
    }
        
    private func setupLayouts() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleText.topAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.topAnchor).isActive = true
        titleText.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor).isActive = true
        titleText.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor).isActive = true
        titleText.heightAnchor.constraint(equalToConstant: 50).isActive = true

        bodyText.translatesAutoresizingMaskIntoConstraints = false
        bodyText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 10).isActive = true
        bodyText.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor).isActive = true
        bodyText.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    // MARK: - Functions for create UI
    
    func createTextViewWith(font: UIFont) -> UITextView {
        let textView = UITextView()
        textView.font = font
        textView.textColor = .label
        textView.textAlignment = .left
        
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.isScrollEnabled = false
        
        textView.delegate = self
        
        return textView
    }
}


// MARK: - Extensions

extension DetailNoteVC: DetailNotePresenterOutput {
    func showInformationFor(note: Note) {
        titleText.text = note.title
        bodyText.text = note.bodyText
    }
}

extension DetailNoteVC {
    func setupPresenter(presenter: DetailNotePresenterInput) {
        self.presenter = presenter
    }
}

extension DetailNoteVC: UITextViewDelegate {
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
