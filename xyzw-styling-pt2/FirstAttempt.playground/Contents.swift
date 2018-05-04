import Foundation
import Overture
import PlaygroundSupport
import UIKit

final class SubscribeCalloutCell: UITableViewCell {
  private let bodyLabel = UILabel()
  private let buttonsStackView = UIStackView()
  private let containerView = UIView()
  private let loginButton = UIButton()
  private let orLabel = UILabel()
  private let rootStackView = UIStackView()
  private let subscribeButton = UIButton()
  private let titleLabel = UILabel()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.selectionStyle = .none
    self.contentView.layoutMargins = .init(top: 24, left: 24, bottom: 24, right: 24)

    self.titleLabel.text = "Subscribe to Point-Free"
    self.titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)

    self.bodyLabel.text = "👋 Hey there! See anything you like? You may be interested in subscribing so that you get access to these episodes and all future ones."
    self.bodyLabel.numberOfLines = 0
    self.bodyLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)

    self.containerView.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
    self.containerView.layoutMargins = .init(top: 24, left: 24, bottom: 24, right: 24)
    self.containerView.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(self.containerView)

    self.rootStackView.alignment = .leading
    self.rootStackView.spacing = 24
    self.rootStackView.translatesAutoresizingMaskIntoConstraints = false
    self.rootStackView.axis = .vertical
    self.rootStackView.layoutMargins = .init(top: 24, left: 24, bottom: 24, right: 24)
    self.rootStackView.isLayoutMarginsRelativeArrangement = true
    self.rootStackView.addArrangedSubview(self.titleLabel)
    self.rootStackView.addArrangedSubview(self.bodyLabel)
    self.rootStackView.addArrangedSubview(self.buttonsStackView)
    self.contentView.addSubview(self.rootStackView)

    self.orLabel.text = "or"
    self.orLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)

    self.subscribeButton.setTitle("See subscription options", for: .normal)
    self.subscribeButton.setTitleColor(.white, for: .normal)
    self.subscribeButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline).bolded
    self.subscribeButton.setBackgroundImage(.from(color: .pf_purple), for: .normal)
    self.subscribeButton.layer.cornerRadius = 6
    self.subscribeButton.layer.masksToBounds = true
    self.subscribeButton.contentEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)

    self.loginButton.setTitle("Login", for: .normal)
    self.loginButton.setTitleColor(.black, for: .normal)
    self.loginButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline).bolded

    self.buttonsStackView.spacing = 8
    self.buttonsStackView.alignment = .firstBaseline
    self.buttonsStackView.addArrangedSubview(self.subscribeButton)
    self.buttonsStackView.addArrangedSubview(self.orLabel)
    self.buttonsStackView.addArrangedSubview(self.loginButton)

    NSLayoutConstraint.activate([
      self.rootStackView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
      self.rootStackView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),

      self.containerView.leadingAnchor.constraint(equalTo: self.rootStackView.leadingAnchor),
      self.containerView.topAnchor.constraint(equalTo: self.rootStackView.topAnchor),
      self.containerView.trailingAnchor.constraint(equalTo: self.rootStackView.trailingAnchor),
      self.containerView.bottomAnchor.constraint(equalTo: self.rootStackView.bottomAnchor),
      ])
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

final class EpisodeCell: UITableViewCell {
  private let blurbLabel = UILabel()
  private let labelsStackView = UIStackView()
  private let posterImageView = UIImageView()
  private let rootStackView = UIStackView()
  private let sequenceAndDateLabel = UILabel()
  private let titleLabel = UILabel()
  private let watchNowButton = UIButton()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.blurbLabel.numberOfLines = 0
    self.blurbLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)

    self.labelsStackView.axis = .vertical
    self.labelsStackView.layoutMargins = .init(top: 24, left: 24, bottom: 32, right: 24)
    self.labelsStackView.isLayoutMarginsRelativeArrangement = true
    self.labelsStackView.spacing = 12
    self.labelsStackView.alignment = .leading
    self.labelsStackView.addArrangedSubview(self.sequenceAndDateLabel)
    self.labelsStackView.addArrangedSubview(self.titleLabel)
    self.labelsStackView.addArrangedSubview(self.blurbLabel)
    self.labelsStackView.addArrangedSubview(self.watchNowButton)

    self.rootStackView.translatesAutoresizingMaskIntoConstraints = false
    self.rootStackView.axis = .vertical
    self.rootStackView.addArrangedSubview(self.posterImageView)
    self.rootStackView.addArrangedSubview(self.labelsStackView)

    self.sequenceAndDateLabel.font = UIFont.preferredFont(forTextStyle: .caption1).smallCaps

    self.titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)

    self.watchNowButton.setTitle("Watch episode →", for: .normal)
    self.watchNowButton.setTitleColor(.pf_purple, for: .normal)
    self.watchNowButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout).bolded

    self.contentView.addSubview(self.rootStackView)

    NSLayoutConstraint.activate([
      self.rootStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      self.rootStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

      self.posterImageView.widthAnchor.constraint(equalTo: self.posterImageView.heightAnchor, multiplier: 16/9),
      ])
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with episode: Episode) {
    self.titleLabel.text = episode.title
    self.blurbLabel.text = episode.blurb
    let formattedDate = episodeDateFormatter.string(from: episode.publishedAt)
    self.sequenceAndDateLabel.text = "#\(episode.sequence) • \(formattedDate)"

    URLSession.shared.dataTask(with: URL(string: episode.posterImageUrl)!) { data, _, _ in
      DispatchQueue.main.async { self.posterImageView.image = data.flatMap(UIImage.init(data:)) }
      }.resume()
  }
}

final class EpisodeListViewController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.estimatedRowHeight = 400
    self.tableView.rowHeight = UITableViewAutomaticDimension
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      return SubscribeCalloutCell(style: .default, reuseIdentifier: nil)
    }

    let cell = EpisodeCell(style: .default, reuseIdentifier: nil)
    cell.configure(with: episodes[indexPath.row - 1])
    return cell
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return episodes.count + 1
  }
}

let vc = EpisodeListViewController()
vc.preferredContentSize = .init(width: 376, height: 1000)
PlaygroundPage.current.liveView = vc
