//
//  AssemblyBuilder.swift
//  AppleNotesApp
//
//  Created by Анна Лошакова on 14.10.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(note: Note?, router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = NotesListVC()
        let model = NoteModel()
        let presenter = NoteListPresenter(view: view, model: model, router: router)
        view.setupPresenter(presenter: presenter)
        
        return view
    }
    
    func createDetailModule(note: Note?, router: RouterProtocol) -> UIViewController {
        let view = DetailNoteVC()
        let model = NoteModel()
        let presenter = DetailNotePresenter(view: view, model: model, router: router)
        view.setupPresenter(presenter: presenter)
        view.showInformationFor(note: note ?? Note())
        
        return view
    }
}