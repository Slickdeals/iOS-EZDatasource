import Foundation
import UIKit

public class ViewBuilder {
    
    public static func collectionView(frame: CGRect) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 25
        layout.minimumLineSpacing = 25
        layout.sectionInset = UIEdgeInsets.init(top: 25, left: 50, bottom: 25, right: 50)
        layout.itemSize = CGSize(width: 125, height: 125)
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        return cv
    }
    
    public static func buildButton() -> UIButton {
        let buttonSize = CGSize(width: 35, height: 35)
        let buttonOrigin = CGPoint(x: 10, y: 10)
        let button = UIButton(frame: CGRect(origin: buttonOrigin, size: buttonSize))
        button.layer.cornerRadius = buttonSize.height / 2
        button.backgroundColor = UIColor.purple
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("⇪", for: .normal)
        return button
    }
    
    public static func buildLevel(size: CGSize) -> UILabel {
        let labelOrigin = CGPoint(x: 0, y: 25)
        let label = UILabel(frame: CGRect(origin: labelOrigin, size: size))
        label.textAlignment = .center
        return label
    }
}
