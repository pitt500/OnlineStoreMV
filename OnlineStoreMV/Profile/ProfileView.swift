//
//  ProfileView.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 07/03/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(AccountStore.self) var accountStore
    
    var body: some View {
        NavigationView {
            ZStack {
                switch accountStore.loadingState {
                case .loading, .notStarted:
                    ProgressView()
                        .task {
                            await accountStore.fetchUserProfile()
                        }
                case .error:
                    VStack {
                        Text("Unable to load user profile")
                        Button {
                            Task {
                                await accountStore.fetchUserProfile()
                            }
                        } label: {
                            Text("Retry")
                        }
                    }
                case .loaded(let user):
                    Form {
                        Section {
                            Text(user.firstName.capitalized)
                            +
                            Text(" \(user.lastName.capitalized)")
                        } header: {
                            Text("Full name")
                        }
                        
                        Section {
                            Text(user.email)
                        } header: {
                            Text("Email")
                        }
                    }
                }
            }
            .navigationTitle("Profile")
        }
        
    }
}

#Preview {
    ProfileView()
        .environment(AccountStore(apiClient: .test))
}
