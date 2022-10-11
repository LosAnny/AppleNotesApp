//
//  ProjectCoordinator.swift
//  AppleNotesApp
//
//  Created by Анна Лошакова on 11.10.2022.
//

import Foundation
import UIKit

class ProjectCoordinator: RootCoordinator {
    
    // MARK: - Properties
    
    weak var navigationController: UINavigationController?
    private var factory: Factory
    
    // MARK: - Initialization
    
    init(factory: Factory) {
        self.factory = factory
    }
    
    // MARK: - Functions
    
    func start(with navigationController: UINavigationController) {
        let viewController = factory.makeInitialViewController(coordinator: self)
        self.navigationController = navigationController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToDetail(with data: Note) {
        let viewController = factory.makeDetailViewController(coordinator: self, data: data)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
