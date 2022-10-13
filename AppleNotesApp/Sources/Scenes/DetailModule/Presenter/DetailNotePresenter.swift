//
//  DetailNotePresenter.swift
//  AppleNotesApp
//
//  Created by Анна Лошакова on 11.10.2022.
//

import Foundation

// MARK: - Input Protocol

protocol DetailNotePresenterInput: AnyObject {
    
    init(coordinator: ProjectCoordinator, view: DetailNotePresenterOutput, model: NoteModelInput)
    
    func showNote(_ note: Note)
    func updateNoteWith(note: Note, title: String?, bodyText: String?)
    func deleteNote(_ note: Note)
    func returnToMainView()
}

// MARK: - Output Protocol

protocol DetailNotePresenterOutput: AnyObject {
    func showInformationFor(note: Note)
}

final class DetailNotePresenter: DetailNotePresenterInput {
    
    
    // MARK: - Properties
    
    private weak var view: DetailNotePresenterOutput?
    private var model: NoteModelInput?
    private var coordinator: ProjectCoordinator?
    
    init(coordinator: ProjectCoordinator, view: DetailNotePresenterOutput, model: NoteModelInput) {
        self.coordinator = coordinator
        self.view = view
        self.model = model
    }
    
    func showNote(_ note: Note) {
        view?.showInformationFor(note: note)
    }
    
    func updateNoteWith(note: Note, title: String?, bodyText: String?) {
        model?.updateNote(note: note, title: title, bodyText: bodyText)
    }
    
    func deleteNote(_ note: Note) {
        model?.deleteNote(note: note)
    }
    
    func returnToMainView() {
        print("Обратно")
    }
}
