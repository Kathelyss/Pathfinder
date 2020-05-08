import UIKit

final class TabBarAnimator {

    // MARK: - Singleton

    private init() {}

    static let shared = TabBarAnimator()

    private(set) var tabBarPosition: TabBarPosition = .revealed
    private var animator = UIViewPropertyAnimator(duration: 1.2, dampingRatio: 0.7)

    // MARK: - Public Interface

    weak var tabBar: TabBarView?

    func changeTabBarPosition(to position: TabBarPosition) {
        guard position != tabBarPosition else {
            return
        }

        tabBarPosition = position

        animator.stopAnimation(true)
        animator.addAnimations(animationBlock(for: position))
        animator.addCompletion(completionBlock(for: position))
        animator.startAnimation()
    }

    // MARK: - Private Func

    private func animationBlock(for position: TabBarPosition) -> VoidBlock {
        switch position {
        case .revealed:
            return { [weak self] in
                self?.tabBar?.transform = .identity
            }

        case .hidden:
            return { [weak self] in
                self?.tabBar?.transform = CGAffineTransform.identity.translatedBy(x: 0,
                                                                                  y: Constants.tabBarRevealedSafeArea)
            }
        }
    }

    private func completionBlock(for position: TabBarPosition) -> ParameterClosure<UIViewAnimatingPosition> {
        switch position {
        case .revealed:
            return { [weak self] state in
                if state == .end {
                    self?.tabBar?.isUserInteractionEnabled = true
                }
            }

        case .hidden:
            return { [weak self] state in
                if state == .start {
                    self?.tabBar?.isUserInteractionEnabled = false
                }
            }
        }
    }
}
