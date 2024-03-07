//
//  AccountStore.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 07/03/24.
//

import Foundation

@Observable
class AccountStore {
    enum LoadingState {
        case notStarted
        case loading
        case loaded(user: UserProfile)
        case error(message: String)
    }
    
    private var user: UserProfile?
    private let apiClient: APIClient
    var loadingState = LoadingState.notStarted
    
    
    init(apiClient: APIClient = .live) {
        self.apiClient = apiClient
    }
    
    func fetchUserProfile() async {
        if let user = self.user {
            loadingState = .loaded(user: user)
            return
        }
        
        do {
            loadingState = .loading
            let user = try await apiClient.fetchUserProfile()
            self.user = user
            loadingState = .loaded(user: user)
        } catch {
            loadingState = .error(message: error.localizedDescription)
        }
    }
}
