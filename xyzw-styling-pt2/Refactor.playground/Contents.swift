import Foundation
import Overture
import PlaygroundSupport
import UIKit

extension CGFloat {
  public static func pf_grid(_ n: Int) -> CGFloat {
    return CGFloat(n) * 4.0
  }
}

let autolayoutStyle = mut(\UIView.translatesAutoresizingMaskIntoConstraints, false)
let verticalStackViewStyle = mut(\UIStackView.axis, .vertical)
let leadingStackViewStyle = mut(\UIStackView.alignment, .leading)
let enableMargins = mut(\UIStackView.isLayoutMarginsRelativeArrangement, true)

let generousMargins = mut(
  \UIView.layoutMargins,
  .init(top: .pf_grid(6), left: .pf_grid(6), bottom: .pf_grid(6), right: .pf_grid(6))
)

let baseTableViewCellStyle = concat(
  mut(\UITableViewCell.backgroundColor, .white),
  mut(\.selectionStyle, .none),
  mut(\.layoutMargins, .zero),
  { generousMargins($0.contentView) }
)

let baseStackViewStyle = concat(
  autolayoutStyle,
  generousMargins,
  enableMargins,
  verticalStackViewStyle,
  mut(\UIStackView.spacing, .pf_grid(6))
)

let longFormLabelStyle = concat(
  mut(\UILabel.numberOfLines, 0),
  mut(\.font, UIFont.preferredFont(forTextStyle: .subheadline))
)

func baseTableViewStyle(estimatedRowHeight: CGFloat) -> (UITableView) -> Void {
  return concat(
    mut(\.estimatedRowHeight, estimatedRowHeight),
    mut(\.rowHeight, UITableViewAutomaticDimension)
  )
}

func roundedStyle(cornerRadius: CGFloat) -> (UIView) -> Void {
  return concat(
    mut(\UIView.layer.cornerRadius, cornerRadius),
    mut(\UIView.layer.masksToBounds, true)
  )
}

let baseRoundedStyle = roundedStyle(cornerRadius: 6)
let bolded: (inout UIFont!) -> Void = { $0 = $0.bolded }

let baseTextButtonStyle = concat(
  mut(\UIButton.titleLabel!.font, UIFont.preferredFont(forTextStyle: .subheadline)),
  mver(\UIButton.titleLabel!.font, bolded)
)

let baseButtonStyle = concat(
  baseTextButtonStyle,
  mut(\UIButton.contentEdgeInsets, .init(top: .pf_grid(2), left: .pf_grid(4), bottom: .pf_grid(2), right: .pf_grid(4)))
)

let baseFillButtonStyle = concat(
  baseButtonStyle,
  baseRoundedStyle
)

let primaryButtonStyle: (UIButton) -> Void = concat(
  baseFillButtonStyle,
  { $0.setTitleColor(.white, for: .normal) },
  { $0.setBackgroundImage(.from(color: .pf_purple), for: .normal) }
)

let primaryTextButtonStyle = concat(
  baseTextButtonStyle,
  { $0.setTitleColor(.pf_purple, for: .normal) }
)

let secondaryTextButtonStyle = concat(
  baseTextButtonStyle,
  { $0.setTitleColor(.black, for: .normal) }
)

let titleLabelStyle = mut(\UILabel.font, UIFont.preferredFont(forTextStyle: .title3))

let calloutContainerViewStyle = concat(
  mut(\UIView.backgroundColor, .pf_gray950)
)

let horizontalButtonsStackView = concat(
  mut(\UIStackView.spacing, .pf_grid(2)),
  mut(\.axis, .horizontal),
  mut(\.alignment, .firstBaseline)
)

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

    self.titleLabel.text = "Subscribe to Point-Free"
    self.bodyLabel.text = "👋 Hey there! See anything you like? You may be interested in subscribing so that you get access to these episodes and all future ones."
    self.subscribeButton.setTitle("See subscription options", for: .normal)
    self.loginButton.setTitle("Login", for: .normal)
    self.orLabel.text = "or"

    with(self, baseTableViewCellStyle)
    with(self.titleLabel, titleLabelStyle)
    with(self.bodyLabel, longFormLabelStyle)
    with(self.containerView, concat(calloutContainerViewStyle, autolayoutStyle))
    with(self.rootStackView, concat(baseStackViewStyle, leadingStackViewStyle))
    with(self.subscribeButton, concat(primaryButtonStyle))
    with(self.loginButton, secondaryTextButtonStyle)
    with(self.buttonsStackView, horizontalButtonsStackView)
    self.orLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)

    self.contentView.addSubview(self.containerView)
    self.rootStackView.addArrangedSubview(self.titleLabel)
    self.rootStackView.addArrangedSubview(self.bodyLabel)
    self.rootStackView.addArrangedSubview(self.buttonsStackView)
    self.contentView.addSubview(self.rootStackView)
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

    self.watchNowButton.setTitle("Watch episode →", for: .normal)

    with(self, baseTableViewCellStyle)
    with(self.blurbLabel, longFormLabelStyle)
    with(
      self.labelsStackView,
      concat(
        baseStackViewStyle,
        verticalStackViewStyle,
        leadingStackViewStyle,
        mut(\.layoutMargins.bottom, .pf_grid(8)),
        mut(\.spacing, .pf_grid(3))
      )
    )
    with(self.rootStackView, concat(autolayoutStyle, verticalStackViewStyle))
    with(self.titleLabel, titleLabelStyle)
    with(self.watchNowButton, primaryTextButtonStyle)
    self.sequenceAndDateLabel.font = UIFont.preferredFont(forTextStyle: .caption1).smallCaps

    self.labelsStackView.addArrangedSubview(self.sequenceAndDateLabel)
    self.labelsStackView.addArrangedSubview(self.titleLabel)
    self.labelsStackView.addArrangedSubview(self.blurbLabel)
    self.labelsStackView.addArrangedSubview(self.watchNowButton)
    self.rootStackView.addArrangedSubview(self.posterImageView)
    self.rootStackView.addArrangedSubview(self.labelsStackView)
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
    with(self.tableView, baseTableViewStyle(estimatedRowHeight: 400))
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
