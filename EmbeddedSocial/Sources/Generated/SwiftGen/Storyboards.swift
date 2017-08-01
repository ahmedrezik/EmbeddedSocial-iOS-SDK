// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation
import UIKit

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable type_body_length

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: Bundle(for: BundleToken.self))
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func perform<S: StoryboardSegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

enum StoryboardScene {
  enum CreateAccount: String, StoryboardSceneType {
    static let storyboardName = "CreateAccount"

    static func initialViewController() -> EmbeddedSocial.CreateAccountViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? EmbeddedSocial.CreateAccountViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case createAccountViewControllerScene = "CreateAccountViewController"
    static func instantiateCreateAccountViewController() -> EmbeddedSocial.CreateAccountViewController {
      guard let vc = StoryboardScene.CreateAccount.createAccountViewControllerScene.viewController() as? EmbeddedSocial.CreateAccountViewController
      else {
        fatalError("ViewController 'CreateAccountViewController' is not of the expected class EmbeddedSocial.CreateAccountViewController.")
      }
      return vc
    }
  }
  enum CreatePost: String, StoryboardSceneType {
    static let storyboardName = "CreatePost"

    case createPostViewControllerScene = "CreatePostViewController"
    static func instantiateCreatePostViewController() -> EmbeddedSocial.CreatePostViewController {
      guard let vc = StoryboardScene.CreatePost.createPostViewControllerScene.viewController() as? EmbeddedSocial.CreatePostViewController
      else {
        fatalError("ViewController 'CreatePostViewController' is not of the expected class EmbeddedSocial.CreatePostViewController.")
      }
      return vc
    }
  }
  enum Home: String, StoryboardSceneType {
    static let storyboardName = "Home"

    case homeViewControllerScene = "HomeViewController"
    static func instantiateHomeViewController() -> EmbeddedSocial.HomeViewController {
      guard let vc = StoryboardScene.Home.homeViewControllerScene.viewController() as? EmbeddedSocial.HomeViewController
      else {
        fatalError("ViewController 'HomeViewController' is not of the expected class EmbeddedSocial.HomeViewController.")
      }
      return vc
    }
  }
  enum Login: String, StoryboardSceneType {
    static let storyboardName = "Login"

    static func initialViewController() -> EmbeddedSocial.LoginViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? EmbeddedSocial.LoginViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case loginViewControllerScene = "LoginViewController"
    static func instantiateLoginViewController() -> EmbeddedSocial.LoginViewController {
      guard let vc = StoryboardScene.Login.loginViewControllerScene.viewController() as? EmbeddedSocial.LoginViewController
      else {
        fatalError("ViewController 'LoginViewController' is not of the expected class EmbeddedSocial.LoginViewController.")
      }
      return vc
    }
  }
  enum MenuStack: String, StoryboardSceneType {
    static let storyboardName = "MenuStack"

    static func initialViewController() -> UINavigationController {
      guard let vc = storyboard().instantiateInitialViewController() as? UINavigationController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case navigationStackContainerScene = "NavigationStackContainer"
    static func instantiateNavigationStackContainer() -> EmbeddedSocial.NavigationStackContainer {
      guard let vc = StoryboardScene.MenuStack.navigationStackContainerScene.viewController() as? EmbeddedSocial.NavigationStackContainer
      else {
        fatalError("ViewController 'NavigationStackContainer' is not of the expected class EmbeddedSocial.NavigationStackContainer.")
      }
      return vc
    }

    case sideMenuViewControllerScene = "SideMenuViewController"
    static func instantiateSideMenuViewController() -> EmbeddedSocial.SideMenuViewController {
      guard let vc = StoryboardScene.MenuStack.sideMenuViewControllerScene.viewController() as? EmbeddedSocial.SideMenuViewController
      else {
        fatalError("ViewController 'SideMenuViewController' is not of the expected class EmbeddedSocial.SideMenuViewController.")
      }
      return vc
    }
  }
  enum PostDetail: String, StoryboardSceneType {
    static let storyboardName = "PostDetail"

    case postDetailViewControllerScene = "PostDetailViewController"
    static func instantiatePostDetailViewController() -> EmbeddedSocial.PostDetailViewController {
      guard let vc = StoryboardScene.PostDetail.postDetailViewControllerScene.viewController() as? EmbeddedSocial.PostDetailViewController
      else {
        fatalError("ViewController 'PostDetailViewController' is not of the expected class EmbeddedSocial.PostDetailViewController.")
      }
      return vc
    }
  }
  enum UserProfile: String, StoryboardSceneType {
    static let storyboardName = "UserProfile"

    case userProfileViewControllerScene = "UserProfileViewController"
    static func instantiateUserProfileViewController() -> EmbeddedSocial.UserProfileViewController {
      guard let vc = StoryboardScene.UserProfile.userProfileViewControllerScene.viewController() as? EmbeddedSocial.UserProfileViewController
      else {
        fatalError("ViewController 'UserProfileViewController' is not of the expected class EmbeddedSocial.UserProfileViewController.")
      }
      return vc
    }
  }
}

enum StoryboardSegue {
}

private final class BundleToken {}
