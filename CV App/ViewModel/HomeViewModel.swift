//
//  HomeViewModel.swift
//  CV App
//
//  Created by Satish Birajdar on 2019-07-18.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import Foundation

class HomeViewModel {

    private var webService: WebService?
    
    public var biodatas: [Biodata]? {
        didSet{
            guard let b = biodatas else { return }
            self.isLoading = false
            self.updateViewData(biodates: b)
            self.didFinishFetch?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var error : Error? {
        didSet {
            self.showAlertClosure?()
            self.isLoading = false
        }
    }
    
    var nameString: String?
    var profilePicturePath: String?
    var contactString: String?
    var detailString: String?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    init(service: WebService) {
        webService = service
    }
}

extension HomeViewModel {
    
    // Request Candidate details
    public func getCandidateDetails(){
        self.isLoading = true
        // Request for candidate detail
        self.webService?.getBiodata { (candidateDetail, error) in
            if let error = error {
                print("Get candidate detail request error: \(error.localizedDescription)")
                self.error = error
                return
            }
            guard let candidateDetail = candidateDetail  else { return }
            self.biodatas = candidateDetail
        }
    }
    
    // Update View
    private func updateViewData(biodates: [Biodata]){
        guard let candidDetails = biodatas else {
            print("Candidate detail is null")
            return
        }
        self.nameString = candidDetails.first?.name
        self.profilePicturePath = candidDetails.first?.profilePicture
        self.contactString = candidDetails.first?.contactDetails
        self.detailString = candidDetails.first?.professionalSummary
    }
}
