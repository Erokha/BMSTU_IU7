import Foundation
import UIKit
import PinLayout


class CopiedToClipboardView: UIView {
    let copiedLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildView()
    }
    
    private func buildView() {
        self.backgroundColor = .opaqueSeparator
        buildLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutLabel()
    }
    
    private func buildLabel() {
        copiedLabel.text = "Copied"
        copiedLabel.textColor = .label
        copiedLabel.textAlignment = .center
        copiedLabel.numberOfLines = 0
        copiedLabel.adjustsFontSizeToFitWidth = true
        addSubview(copiedLabel)
    }
    
    func animateOnCopy(completion: (() -> Void)? = nil) {
        guard let _ = superview else { return }
        UIView.animate(withDuration: 0.85, animations: { [weak self] in
            guard let self = self else { return }
            self.pin
                .hCenter()
                .top(50)
                .height(50)
                .width(150)
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.animate(withDuration: 0.85, animations:  { [weak self] in
                    guard let self = self else { return }
                    self.pin
                        .hCenter()
                        .top(-50)
                        .height(50)
                        .width(150)
                }, completion: { _ in
                    completion?()
                })
            }
        })
    }
    
    private func layoutLabel() {
        copiedLabel.pin
            .all()
            .margin(5)
    }
}

