//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import UIKit

protocol ReplyCellViewInput: class {
    func configure(reply: Reply)
//    func setupInitialState()
}

protocol ReplyCellViewOutput {
    func like()
    func avatarPressed()
    func likesPressed()
    func optionsPressed()
}

class ReplyCell: UICollectionViewCell, ReplyCellViewInput {

    static let defaultHeight: CGFloat = 120

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var totalLikesButton: UIButton!
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var replyLabel: UILabel!
    @IBOutlet weak var separator: UIView!
    
    var replyView: ReplyViewModel!
    
    var output: ReplyCellViewOutput!
    
    private var formatter = DateFormatterTool()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userPhoto.layer.cornerRadius = userPhoto.layer.bounds.height / 2
    }
    
    func configure(reply: Reply) {
        userName.text = User.fullName(firstName: reply.user?.firstName, lastName: reply.user?.lastName)
        replyLabel.text = reply.text ?? ""
        totalLikesButton.setTitle(L10n.Post.likesCount(Int(reply.totalLikes)), for: .normal)
        
        postTimeLabel.text = reply.createdTime == nil ? "" : formatter.timeAgo(since: reply.createdTime!)
        
        if reply.user?.photo?.url == nil {
            userPhoto.image = UIImage(asset: AppConfiguration.shared.theme.assets.userPhotoPlaceholder)
        } else {
            userPhoto.setPhotoWithCaching(Photo(url: reply.user?.photo?.url),
                                          placeholder: UIImage(asset: AppConfiguration.shared.theme.assets.userPhotoPlaceholder))
        }
        
        likeButton.isSelected = reply.liked
        contentView.layoutIfNeeded()
    }
    
    func cellSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: self.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height)
    }
    
    @IBAction func like(_ sender: Any) {
        output.like()
    }

    @IBAction func toLikes(_ sender: Any) {
        output.likesPressed()
    }
    
    @IBAction func actionsPressed(_ sender: Any) {
        output.optionsPressed()
    }
    
    @IBAction func toProfile(_ sender: Any) {
        output.avatarPressed()
    }

}

extension ReplyCell {
    
    func apply(theme: Theme?) {
        guard let palette = theme?.palette else {
            return
        }
        
        backgroundColor = palette.contentBackground
        
        totalLikesButton.setTitleColor(palette.topicSecondaryText, for: .normal)
        totalLikesButton.titleLabel?.font = AppFonts.small
        
        postTimeLabel.textColor = palette.topicSecondaryText
        postTimeLabel.font = AppFonts.medium
        
        userName.textColor = palette.textPrimary
        userName.font = AppFonts.medium
        
        separator.backgroundColor = palette.separator
        
        replyLabel.textColor = palette.textPrimary
        replyLabel.font = AppFonts.regular
    }
}
