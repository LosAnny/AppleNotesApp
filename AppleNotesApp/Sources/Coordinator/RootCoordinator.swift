//
//  RootCoordinator.swift
//  AppleNotesApp
//
//  Created by Анна Лошакова on 11.10.2022.
//

import Foundation
import UIKit

protocol RootCoordinator: AnyObject {
    func start(with navigationController: UINavigationController)
}
