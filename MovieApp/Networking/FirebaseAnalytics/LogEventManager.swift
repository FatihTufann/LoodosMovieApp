import Firebase

class LogEventManager {
    
    func logCurrentView(screenName: String, className: String) {
        Analytics.logEvent(AnalyticsEventScreenView,
                           parameters: [AnalyticsParameterScreenName: screenName,
                                       AnalyticsParameterScreenClass: className])
    }
    
    func logCustomEvent(title: String, parameters: [String: Any]) {
        Analytics.logEvent(title, parameters: parameters)
    }
    
    
    func logActionStatus(title: String, status: ActionStatus) {
        Analytics.logEvent(status.rawValue,
                               parameters: ["name": title,
                                            "status": status])
    }
}
