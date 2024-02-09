//

import UIKit

class ViewController: UIViewController {

    var animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut, animations: nil)

    private let square = View()
    private let image = Image()
    private let slider = UISlider()

    private let squareSide: CGFloat = 100.0
    private let contentInset: CGFloat = 16.0
    private let maxScale: CGFloat = 1.5

    override func viewDidLoad() {
        super.viewDidLoad()

        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)

        square.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(square)

        image.translatesAutoresizingMaskIntoConstraints = false
        square.addSubview(image)


        square.frame = CGRect(x: contentInset, y: 200, width: squareSide, height: squareSide)
        slider.value = 0.0
        slider.frame = CGRect(x: contentInset, y: view.frame.height / 2, width: view.frame.width - 2 * contentInset, height: 44)
        image.frame = CGRect(x: 8, y: 8, width: 24, height: 24)


        slider.addTarget(self, action: #selector(handleSliderChanged(slider:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(handleSliderUp(slider:)), for: .touchUpInside)
        animator.fractionComplete = CGFloat(slider.value)
        animator.pausesOnCompletion = true
        animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut, animations: animation)
    }

    private func animation() {
        square.transform = CGAffineTransform(scaleX: maxScale, y: maxScale).rotated(by: .pi / 2)
        square.center.x = view.frame.width - contentInset - (squareSide * maxScale / 2)
        view.layoutIfNeeded()
    }

    @objc
    private func handleSliderUp(slider: UISlider) {

        // FiXME: this solution is too fast and ignoring withDuration parameter
//        UIView.animate(
//            withDuration: 15.0, delay: 0.0, options: .curveEaseInOut,
//            animations: {
//                self.slider.value = 1.0
//                self.handleSliderChanged(slider: slider)
//            },
//            completion: nil
//        )

        // NOTE: don't like this solution because slider and animator not synced
        slider.setValue(slider.maximumValue, animated: true)
        animator.continueAnimation(withTimingParameters: .none, durationFactor: 0)
    }

    @objc
    private func handleSliderChanged(slider: UISlider) {
        animator.pausesOnCompletion = true
        animator.fractionComplete = CGFloat(slider.value)
    }

}

class View: UIView {
    init() {
        super.init(frame: .zero)

        layer.cornerRadius = 8.0
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Image: UIImageView {
    init() {
        super.init(image: UIImage(systemName: "figure")?.withTintColor(.white, renderingMode: .alwaysOriginal))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
