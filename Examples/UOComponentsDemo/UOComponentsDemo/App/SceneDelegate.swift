//
//  SceneDelegate.swift
//  UOComponents
//
//  Created by Ünsal Öner on 12.02.2026.
//

import UIKit
import UOComponents

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Örnek onboarding: uygulama açılışında gösterilir, tamamlanınca ana ekrana geçilir
        let onboardingConfig = UOOnboardingConfig(
            pages: [
                UOOnboardingPage(
                    title: "Build Components",
                    description: "Create beautiful UI components with a clean builder pattern. No more messy view configuration.",
                    mediaName: "onboarding_0",
                    highlightWord: "Components",
                    highlightColor: UOColor.primary
                ),
                UOOnboardingPage(
                    title: "Apply Styles",
                    description: "Use pre-built styles or create your own. Consistent design across your entire app.",
                    mediaName: "onboarding_1",
                    highlightWord: "Styles",
                    highlightColor: UOColor.accent
                ),
                UOOnboardingPage(
                    title: "Ship Faster",
                    description: "Focus on what matters. Stop writing repetitive UIKit boilerplate code.",
                    mediaName: "onboarding_2",
                    highlightWord: "Faster",
                    highlightColor: UOColor.success
                )
            ],
            mediaType: .video,
            continueTitle: "Continue",
            lastPageTitle: "Get Started"
        )

        let onboardingVC = UOOnboardingViewController(config: onboardingConfig)
        onboardingVC.delegate = self

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = onboardingVC
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

// MARK: - UOOnboardingDelegate

extension SceneDelegate: UOOnboardingDelegate {
    func onboardingDidComplete(_ controller: UOOnboardingViewController) {
        let mainVC = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = mainVC

        UIView.transition(with: window!, duration: 0.4, options: .transitionCrossDissolve) {}
    }
}
