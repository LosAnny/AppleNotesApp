//
//  ProjectFactory.swift
//  AppleNotesApp
//
//  Created by Анна Лошакова on 11.10.2022.
//

import UIKit

protocol Factory {
    func makeInitialViewController(coordinator: ProjectCoordinator) -> UIViewController
    func makeDetailViewController(coordinator: ProjectCoordinator, note: Note) -> UIViewController
}

class ProjectFactory: Factory {
    
    func makeInitialViewController(coordinator: ProjectCoordinator) -> UIViewController {
        let viewController = NotesListVC()
        let model = NoteModel()
        let presenter = NoteListPresenter(coordinator: coordinator,
                                          view: viewController,
                                          model: model)
        viewController.setupPresenter(presenter: presenter)
        
        return viewController
    }
  
    func makeDetailViewController(coordinator: ProjectCoordinator, note: Note) -> UIViewController {
        let viewController = DetailNoteVC()
        let model = NoteModel()
        let presenter = DetailNotePresenter(coordinator: coordinator,
                                            view: viewController,
                                            model: model)
        viewController.setupPresenter(presenter: presenter)
        viewController.showInformationFor(note: note)
        
        return viewController
    }
    
    func makeInitialCoordinator() -> RootCoordinator {
        let coordinator = ProjectCoordinator(factory: self)
        return coordinator
    }
}
