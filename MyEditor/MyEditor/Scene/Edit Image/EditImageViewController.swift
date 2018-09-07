//
//  EditImageViewController.swift
//  MyEditor
//
//  Created by Do Hung on 9/6/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import Photos

class EditImageViewController: UIViewController, BindableType {
    private struct Constant {
        static let widthCell = 100
    }
    
    var viewModel: EditImageViewModel!
    private var lastestImage = PublishSubject<UIImage>()
    private var saveItem = UIBarButtonItem()
    private var doneItem = UIBarButtonItem()

    @IBOutlet private var viewContentImage: UIView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var editView: EditView!
    @IBOutlet private var viewCrop: UIView!
    @IBOutlet private var bottom: NSLayoutConstraint!
    @IBOutlet private var trailing: NSLayoutConstraint!
    @IBOutlet private var leading: NSLayoutConstraint!
    @IBOutlet private var top: NSLayoutConstraint!
    @IBOutlet private var leadingImageView: NSLayoutConstraint!
    @IBOutlet private var topImageView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        editView.configCollectionView(viewController: self)
        saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
        doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        viewCrop.isHidden = true
    }
    
    private func doneEdit() {
        imageView.image = imageView.image?.resize(scaledTo: imageView.frame.size)?.crop(rect: viewCrop.frame)
        updateConstaintImageView()
        viewCrop.isHidden = true
        navigationItem.rightBarButtonItem = saveItem
        guard let image = imageView.image else {
            return
        }
        lastestImage.onNext(image)
    }
    
    func resetConstraitViewCrop() {
        top.constant = 0
        leading.constant = 0
        trailing.constant = 0
        bottom.constant = 0
    }
    
    func updateConstaintImageView() {
        guard let image = imageView.image else {
            return
        }
        let ratioImage = Float(image.size.width) / Float(image.size.height)
        if ratioImage > 1 {
            leadingImageView.constant = 0
            topImageView.constant = (viewContentImage.frame.size.height - viewContentImage.frame.size.width / CGFloat(ratioImage)) / 2
        } else {
            topImageView.constant = 0
            leadingImageView.constant = (viewContentImage.frame.size.width - viewContentImage.frame.size.height * CGFloat(ratioImage)) / 2
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateConstaintImageView()
    }
    
    func bindViewModel() {
        let input = EditImageViewModel.Input(loadTrigger: Driver.just(()),
                                             clickSaveTrigger: saveItem.rx.tap.asDriver(),
                                             latestImage: lastestImage.asDriverOnErrorJustComplete(),
                                             clickDoneTrigger: doneItem.rx.tap.asDriver())
        let output = viewModel.transform(input)
        output.image
            .drive(imageView.rx.image)
            .disposed(by: rx.disposeBag)
        output.clickedSave
            .drive(onNext: { (result) in
            print("success")
        })
            .disposed(by: rx.disposeBag)
        output.clickedDone.drive(onNext: { _ in
            self.doneEdit()
        })
            .disposed(by: rx.disposeBag)
        output.listEdit.drive(editView.getCollection().rx.items) { collectionView, index, element in
            let indexPath = IndexPath(row: index, section: 0)
            let cell: EditCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setContentForCell(title: element.0, image: element.1)
            return cell
        }
            .disposed(by: rx.disposeBag)
        guard let image = imageView.image else {
            return
        }
        lastestImage.onNext(image)
    }
    
    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: viewCrop)
        guard let viewPan = sender.view else {
            return
        }
        switch viewPan.tag {
        case 1:
            if leading.constant + translation.x >= 0 {
                leading.constant += translation.x
            }
            if top.constant + translation.y >= 0 {
                top.constant += translation.y
            }
        case 2:
            if trailing.constant - translation.x >= 0 {
                trailing.constant -= translation.x
            }
            if top.constant + translation.y >= 0 {
                top.constant += translation.y
            }
        case 3:
            if leading.constant + translation.x >= 0 {
                leading.constant += translation.x
            }
            if bottom.constant - translation.y >= 0 {
                bottom.constant -= translation.y
            }
        case 4:
            if trailing.constant - translation.x >= 0 {
                trailing.constant -= translation.x
            }
            if bottom.constant - translation.y >= 0 {
                bottom.constant -= translation.y
            }
        case 5:
            if top.constant + translation.y >= 0 {
                top.constant += translation.y
            }
        case 6:
            if leading.constant + translation.x >= 0 {
                leading.constant += translation.x
            }
        case 7:
            if trailing.constant - translation.x >= 0 {
                trailing.constant -= translation.x
            }
        case 8:
            if bottom.constant - translation.y >= 0 {
                bottom.constant -= translation.y
            }
        case 9:
            if leading.constant + translation.x >= 0 {
                leading.constant += translation.x
            }
            if top.constant + translation.y >= 0 {
                top.constant += translation.y
            }
            if trailing.constant - translation.x >= 0 {
                trailing.constant -= translation.x
            }
            if bottom.constant - translation.y >= 0 {
                bottom.constant -= translation.y
            }
        default:
            break
        }
        sender.setTranslation(CGPoint.zero, in: viewCrop)
    }
}

extension EditImageViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            viewCrop.isHidden = false
            navigationItem.rightBarButtonItem = doneItem
            resetConstraitViewCrop()
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(Constant.widthCell), height: collectionView.frame.size.height)
    }
}

extension EditImageViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.editImage
}
