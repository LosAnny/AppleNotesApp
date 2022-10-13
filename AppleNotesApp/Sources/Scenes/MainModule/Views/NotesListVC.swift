//
//  NotesListVC.swift
//  AppleNotesApp
//
//  Created by Анна Лошакова on 08.10.2022.
//

import UIKit

class NotesListVC: UIViewController {
    
    // MARK: - Properties
    
    private var presenter: NoteListPresenterInput?
    
    // MARK: - Outlets
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .systemGroupedBackground
        tableView.rowHeight = 80
        
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupToolBar()
        setupView()
        setupHierarchy()
        setupLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }
    
    // MARK: - Setup
    
    private func setupNavigationController() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Заметки"
        let imageForNavigationItem = UIImage(systemName: "ellipsis.circle")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: imageForNavigationItem,
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .systemYellow
    }
    
    private func setupToolBar() {
        
        navigationController?.setToolbarHidden(false, animated: false)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: self,
                                     action: nil)
        let newNoteTool = UIBarButtonItem(barButtonSystemItem: .compose,
                                          target: self,
                                          action: #selector(createNewNote))
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.textAlignment = .center
        label.text = presenter?.getNotesCount()?.showCountNote()
        let noteCount = UIBarButtonItem(customView: label)
        
        toolbarItems = [spacer, noteCount, spacer, newNoteTool]
        navigationController?.toolbar.tintColor = .systemYellow
    }
    
    private func setupView() {
        view.backgroundColor = .systemGroupedBackground
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
        
    private func setupLayouts() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - Objc functions
    
    @objc func createNewNote() {
        presenter?.addNewNote(title: "Список покупок!!! УРАААА", bodyText: "Картошка, макароны, соус, кетчуп")
    }
}

// MARK: - Extension for NoteListPresenterOutput

extension NotesListVC: NoteListPresenterOutput {
    
    func reloadData() {
        tableView.reloadData()
        setupToolBar()
    }
}

// MARK: - Extension for UITableViewDataSource

extension NotesListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        guard let counNote = presenter?.getNotesCount() else { return 0 }
        
        return counNote
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier,
                                                       for: indexPath) as? NoteTableViewCell else {
            let cell = NoteTableViewCell(style: .default,
                                         reuseIdentifier: NoteTableViewCell.identifier)
            return cell
        }

        let note = presenter?.getNoteBy(index: indexPath.row)
        cell.configureCell(with: note)
        
        return cell
    }
}

// MARK: - Extension for UITableViewDelegate

extension NotesListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showNoteDetailBy(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        presenter?.deleteNoteBy(index: indexPath.row)
    }
}

// MARK: - Extension for setup presenter

extension NotesListVC {
    func setupPresenter(presenter: NoteListPresenterInput) {
        self.presenter = presenter
    }
}
