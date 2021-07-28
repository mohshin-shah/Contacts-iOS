//
//  PreviewContactViewModel.swift
//  ContactApp
//
//  Created by Mohshin on 28/7/21.
//

import Foundation

final class PreviewContactViewModel {
    var coordinator: PreviewContactCoordinator?
    let contact: User
    
    init(contact: User) {
        self.contact = contact
    }
}

extension PreviewContactViewModel {
    func onViewDidDisappear() {
        coordinator?.onViewDidDisappear()
    }
}
