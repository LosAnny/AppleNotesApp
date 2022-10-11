//
//  NoteListPresenter.swift
//  AppleNotesApp
//
//  Created by Анна Лошакова on 10.10.2022.
//

import Foundation

protocol NoteListPresenterInput: AnyObject {
    
    init(view: NoteListPresenterOutput, model: NoteModelInput)
    
    func getNotesCount() -> Int?
    func getNoteBy(index: Int) -> Note?
    func addNewNote(title: String?, bodyText: String?)
    func deleteNoteBy(index: Int)
}

protocol NoteListPresenterOutput: AnyObject {
    func reloadData()
}

final class NoteListPresenter: NoteListPresenterInput {
    
    // MARK: - Properties
    
    private weak var view: NoteListPresenterOutput?
    private var model: NoteModelInput?
    
    // MARK: - Initialization
    
    init(view: NoteListPresenterOutput, model: NoteModelInput) {
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
}
