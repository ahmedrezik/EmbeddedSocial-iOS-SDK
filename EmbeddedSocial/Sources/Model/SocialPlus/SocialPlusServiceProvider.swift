//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation

protocol URLSchemeServiceType {
    func application(_ app: UIApplication, open url: URL, options: [AnyHashable: Any]) -> Bool
}

protocol SocialPlusServicesType {
    func getURLSchemeService() -> URLSchemeServiceType
    
    func getSessionStoreRepositoriesProvider() -> SessionStoreRepositoryProviderType
    
    func getCoreDataStack() -> CoreDataStack
    
    func getCache(coreDataStack: CoreDataStack) -> CacheType
    
    func getNetworkTracker() -> NetworkTrackerType
    
    func getAuthorizationMulticast() -> AuthorizationMulticastType
    
    func getDaemonsController(cache: CacheType) -> Daemon
    
    func getAppConfiguration(configFilename: String) -> AppConfigurationType
    
    func getStartupCommands(launchArgs: LaunchArguments) -> [Command]
}

final class SocialPlusServices: SocialPlusServicesType {
    lazy var networkTracker: NetworkTrackerType = {
        return NetworkTracker()
    }()
    
    lazy var authorizationMulticast: AuthorizationMulticastType = {
        return AuthorizationMulticast(authorization: Constants.API.anonymousAuthorization)
    }()
    
    func getURLSchemeService() -> URLSchemeServiceType {
        return URLSchemeService()
    }
    
    func getSessionStoreRepositoriesProvider() -> SessionStoreRepositoryProviderType {
        return SessionStoreRepositoryProvider()
    }
    
    func getCoreDataStack() -> CoreDataStack {
        let model = CoreDataModel(name: "EmbeddedSocial", bundle: Bundle(for: SocialPlus.self))
        let builder = CoreDataStackBuilder(model: model)
        let result = builder.makeStack()
        
        switch result {
        case let .success(stack):
            return stack
        case let .failure(error):
            fatalError(error.localizedDescription)
        }
    }
    
    func getCache(coreDataStack stack: CoreDataStack) -> CacheType {
        let database = TransactionsDatabaseFacade(incomingRepo: CoreDataRepository(context: stack.backgroundContext),
                                                  outgoingRepo: CoreDataRepository(context: stack.backgroundContext))
        return Cache(database: database)
    }
    
    func getNetworkTracker() -> NetworkTrackerType {
        return networkTracker
    }

    func getAuthorizationMulticast() -> AuthorizationMulticastType {
        return authorizationMulticast
    }
    
    func getDaemonsController(cache: CacheType) -> Daemon {
        return DaemonsController(networkTracker: networkTracker, cache: cache)
    }
    
    func getAppConfiguration(configFilename: String) -> AppConfigurationType {
        guard let config = PlistLoader.loadPlist(name: configFilename),
            let themeConfig = config["theme"] as? [String: Any],
            let theme = Theme(config: themeConfig) else {
                fatalError("Config file is wrong or missing.")
        }
        return AppConfiguration(theme: theme)
    }
    
    func getStartupCommands(launchArgs: LaunchArguments) -> [Command] {
        let command1 = ThirdPartiesConfigurationCommand(configurator: ThirdPartyConfigurator(), launchArgs: launchArgs)
        let command2 = APIBasePathSetupCommand()
        let command3 = AppThemeConfigurationCommand()
        return [command1, command2, command3]
    }
}
