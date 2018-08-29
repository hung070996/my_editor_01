//
//  ViewController.swift
//  MyEditor
//
//  Created by Do Hung on 8/28/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import paper_onboarding
import SnapKit

enum OnboardingItemType: Int {
    private struct ConstantData {
        static let homeDescription = "This is description of Home"
        static let listDescription =  "This is description of List"
        static let detailDescription =  "This is description of Detail"
        static let homeTitle = "Home"
        static let listTitle = "List"
        static let detailTitle = "Detail"
    }
    
    case home = 0
    case list
    case detail
    
    var title: String {
        switch self {
        case .home:
            return ConstantData.homeTitle
        case .list:
            return ConstantData.listTitle
        case .detail:
            return ConstantData.detailTitle
        }
    }
    
    var description: String {
        switch self {
        case .home:
            return ConstantData.homeDescription
        case .list:
            return ConstantData.listDescription
        case .detail:
            return ConstantData.detailDescription
        }
    }
    
    var pageIcon: UIImage {
        switch self {
        case .home:
            return #imageLiteral(resourceName: "Intro_Icon_Home")
        case .list:
            return #imageLiteral(resourceName: "Intro_Icon_List")
        case .detail:
            return #imageLiteral(resourceName: "Intro_Icon_View")
        }
    }
    
    var backgroundImage: UIImage {
        switch self {
        case .home:
            return #imageLiteral(resourceName: "Intro_Background_Home")
        case .list:
            return #imageLiteral(resourceName: "Intro_Background_ListImage")
        case .detail:
            return #imageLiteral(resourceName: "Intro_Background_Detail")
        }
    }
    
}

class IntroViewController: UIViewController {

    @IBOutlet private weak var introOnboarding: PaperOnboarding!
    
    private struct ConstantData {
        static let onboardingCount = 3
        static let titleFont = UIFont(name: "Helvetica", size: 20)
        static let descriptionFont = UIFont(name: "Helvetica", size: 20)
        static let zero = 0
        static let alphaBlurEffect = 0.50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension IntroViewController: PaperOnboardingDataSource, PaperOnboardingDelegate {
    func onboardingItemsCount() -> Int {
        return ConstantData.onboardingCount
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        guard let type = OnboardingItemType.init(rawValue: index),
            let titleFont = ConstantData.titleFont,
            let descriptionFont = ConstantData.descriptionFont else {
            fatalError()
        }
        return OnboardingItemInfo(informationImage: UIImage(),
                                  title: type.title,
                                  description: type.description,
                                  pageIcon: type.pageIcon,
                                  color: UIColor.white,
                                  titleColor: UIColor.white,
                                  descriptionColor: UIColor.white,
                                  titleFont: titleFont,
                                  descriptionFont: descriptionFont)
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        guard let type = OnboardingItemType.init(rawValue: index) else {
            return
        }
        //set up img view
        let imgView = UIImageView(image: type.backgroundImage)
        imgView.contentMode = .scaleAspectFill
        item.insertSubview(imgView, at: ConstantData.zero)
        let blurOverlay = getBlurView(style: .extraLight, alpha: CGFloat(ConstantData.alphaBlurEffect), superView: introOnboarding)
        imgView.addSubview(blurOverlay)
        //auto-layout for img view
        imgView.snp.remakeConstraints({ (make) in
            make.top.equalTo(introOnboarding.snp.top)
            make.bottom.equalTo(introOnboarding.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        })
        //auto-layout for blur view
        blurOverlay.snp.remakeConstraints({ (make) in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        })
    }
}
