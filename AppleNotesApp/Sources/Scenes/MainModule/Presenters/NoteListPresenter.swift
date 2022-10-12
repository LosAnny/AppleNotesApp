//
//  NoteListPresenter.swift
//  AppleNotesApp
//
//  Created by Анна Лошакова on 10.10.2022.
//

import Foundation

// MARK: - Input Protocol

protocol NoteListPresenterInput: AnyObject {
    
    init(coordinator: ProjectCoordinator, view: NoteListPresenterOutput, model: NoteModelInput)
    
    func getNotesCount() -> Int?
    func getNoteBy(index: Int) -> Note?
    func addNewNote(title: String?, bodyText: String?)
    func deleteNoteBy(index: Int)
    func showNoteDetailBy(index: Int)
}

// MARK: - Output Protocol

protocol NoteListPresenterOutput: AnyObject {
    func reloadData()
}

final class NoteListPresenter: NoteListPresenterInput {
    
    // MARK: - Properties
    
    private weak var view: NoteListPresenterOutput?
    private var model: NoteModelInput?
    private var coordinator: ProjectCoordinator?
    
    // MARK: - Initialization
    
    init(coordinator: ProjectCoordinator, view: NoteListPresenterOutput, model: NoteModelInput) {
        self.coordinator = coordinator
        self.view = view
        self.model = model
    }
    
    // MARK: - Presenter input functions
    
    func getNotesCount() -> Int? {
        guard let model = model else { return nil }
        return model.fetchAllNotes().count
    }
    
    func getNoteBy(index: Int) -> Note? {
        guard let note = model?.fetchAllNotes()[index] else { return nil }
        return note
    }
    
    func addNewNote(title: String?, bodyText: String?) {
        model?.createNewNote(title: title, bodyText: bodyText)
        view?.reloadData()
    }
    
    func deleteNoteBy(index: Int) {
        guard let note = model?.fetchAllNotes()[index] else { return }
        model?.deleteNote(note: note)
        view?.reloadData()
    }
    
    func showNoteDetailBy(index: Int) {
        guard let note = model?.fetchAllNotes()[index] else { return }
        coordinator?.moveToDetail(with: note)
    }
}
