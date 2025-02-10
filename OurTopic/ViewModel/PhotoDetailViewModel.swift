//
//  PhotoDetailViewModel.swift
//  OurTopic
//
//  Created by 조우현 on 2/11/25.
//

import Foundation

final class PhotoDetailViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    private var monthViews = 0
    private var monthDownloads = 0
    var failAlertTitle = ""
    var failAlertMessage = ""
    
    struct Input {
        let viewDidLoadTrigger: Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        let idContents: Observable<String?> = Observable(nil)
        let imageURLContents: Observable<String?> = Observable(nil)
        let imageWidthContents: Observable<Int?> = Observable(nil)
        let imageHeightContents: Observable<Int?> = Observable(nil)
        let postDateContents: Observable<String?> = Observable(nil)
        let userNameContents: Observable<String?> = Observable(nil)
        let userProfileImageContents: Observable<String?> = Observable(nil)
        let monthViews: Observable<String?> = Observable(nil)
        let monthDownloads: Observable<String?> = Observable(nil)
        let failHandler: Observable<Void?> = Observable(nil)
    }
    
    // MARK: - Initializer
    init() {
        print("PhotoDetailViewModel Init")
        
        input = Input()
        output = Output()
        transform()
    }
    
    deinit {
        print("PhotoDetailViewModel Deinit")
    }
    
    // MARK: - Functions
    func transform() {
        self.input.viewDidLoadTrigger.bind { _ in
            self.callRequest()
        }
    }
    
    private func callRequest() {
        guard let id = output.idContents.value else {
            print("id 가져오기 실패")
            return
        }

        NetworkManager.shared.callUnsplashAPI(api: .photoStatistics(id: id), type: Statistics.self) { value in
            
            for i in 0..<value.views.historical.values.count {
                self.monthViews += value.views.historical.values[i].value
            }
            
            let formattedViews = NumberFormattingManager.shared.numberFormatting(number: self.monthViews)
            self.output.monthViews.value = "\(formattedViews ?? "")"
            
            for i in 0..<value.downloads.historical.values.count {
                self.monthDownloads += value.downloads.historical.values[i].value
            }
            
            let formattedDownloads = NumberFormattingManager.shared.numberFormatting(number: self.monthDownloads)
            self.output.monthDownloads.value = "\(formattedDownloads ?? "")"
        } failHandler: { statusCode in
            self.failAlertTitle = NetworkStatus(rawValue: statusCode)?.title ?? "정의되지 않은 ERROR"
            self.failAlertMessage = NetworkStatus(rawValue: statusCode)?.message ?? "예상치 못한 에러입니다."
            self.output.failHandler.value = ()
        }
    }
}
