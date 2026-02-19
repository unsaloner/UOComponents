
# UOComponents

A Swift library that provides reusable UI components and ready-made screen kits (Onboarding, Settings, Popup) for UIKit using a builder pattern.

**Requirements:** iOS 15+, Swift 5.9, Xcode 14+

---

## Installation (Swift Package Manager)

### In Xcode

1. **File → Add Package Dependencies...**
2. Paste the package URL in the search field:
   ```
   https://github.com/unsaloner/UOComponents
   ```
3. Set **Dependency Rule** to *Up to Next Major Version* starting from `1.0.0` (or your preferred version).
4. Click **Add Package**, select your target, then **Add Package**.

### In Package.swift (as a dependency of another package)

```swift
dependencies: [
    .package(url: "https://github.com/unsaloner/UOComponents", from: "1.0.0")
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["UOComponents"]
    )
]
```

Then add `import UOComponents` in your code. SnapKit is resolved automatically as a transitive dependency.

---

## Usage

### Building components

```swift
import UOComponents

// Label
let titleLabel = UILabel
    .builder()
    .text("Title")
    .font(UOFont.title())
    .textColor(UOColor.textPrimary)
    .build()

// Button
let button = UIButton
    .builder()
    .title("Continue")
    .titleColor(.white)
    .onTap { print("Tapped") }
    .build()

// Stack
let stack = UIStackView
    .builder()
    .vertical(spacing: 16)
    .addArranged(titleLabel, button)
    .build()
```

### Onboarding screen

```swift
import UOComponents

let config = UOOnboardingConfig(
    pages: [
        UOOnboardingPage(
            title: "Welcome",
            description: "Explore our app.",
            mediaName: "onboarding_1",
            highlightWord: "Welcome",
            highlightColor: UOColor.primary
        )
    ],
    continueTitle: "Continue",
    lastPageTitle: "Get Started"
)

let onboarding = UOOnboardingViewController(config: config, style: .default())
onboarding.delegate = self
present(onboarding, animated: true)
```

### Bottom sheet

```swift
import UOComponents

let config = UOPopupBottomSheetConfig(
    icon: UIImage(systemName: "star"),
    title: "Options",
    message: "Choose an action.",
    actions: [
        UOPopupBottomSheetAction(title: "Edit", style: .default()) { },
        UOPopupBottomSheetAction(title: "Delete", style: .destructive()) { }
    ]
)

let sheet = UOBottomSheetViewController(config: config, style: .default())
present(sheet, animated: true)
```

---

## Contents

| Section | Description |
|--------|-------------|
| **Builders** | Fluent builder API for `UILabel`, `UIButton`, `UIImageView`, `UIStackView`, `UITextField`, `UOPageControl`, and more. |
| **Tokens** | `UOColor` and `UOFont` for consistent colors and typography. |
| **OnboardingKit** | Page-based onboarding flow (`UOOnboardingViewController` with config and style). |
| **SettingsKit** | Settings screen and web view (`UOSettingsViewController`, `UOWebViewController`). |
| **PopupKit** | Toast, center dialog, bottom sheet, and popover. |

To try the demo app, clone this repo and run the **UOComponentsDemo** scheme.

