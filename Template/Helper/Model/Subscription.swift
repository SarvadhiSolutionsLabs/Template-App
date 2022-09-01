//
//  Subscription.swift
//  Template
//
//  Created by SARVADHI on 10/08/22.
//

import Foundation

struct Subscription {
    
    var isActive: Bool = true
    var customers: String = ""
    var price: String = ""
    var descriptions: [String] = []
    var isSelected: Bool = false
    
    init(_ isActive: Bool, _ customer: String, _ price: String, _ descriptions: [String]) {
        self.isActive = isActive
        self.customers = customer
        self.price = price
        self.descriptions = descriptions
    }

}

class SubscriptionData {
    
     static func getallSubscriptionData() -> [Subscription] {
        
        return [Subscription(true, "5 CUSTOMERS", "$ 34.99", ["Add your logo or branding",
                                                                      "promote 10 tips/tricks and promotions",
                                                                      "Create boxes and zones for clients",
                                                                      "Allow users to share your tips/tricks or promotions",
                                                                      "Unlimited spaces",
                                                                      "Unlimited zones, levels, and boxes",
                                                                      "Set tasks for your clients or staff",
                                                                      "10 boxes",
                                                                      "Up to 5 simultaneous customers",
                                                                      "Everything is synched and backed up to the cloud"]),
                Subscription(false, "15 CUSTOMERS", "$ 49.99", ["Add your logo or branding",
                                                                        "promote 10 tips/tricks and promotions",
                                                                        "Create boxes and zones for clients",
                                                                        "Allow users to share your tips/tricks or promotions",
                                                                        "Unlimited spaces",
                                                                        "Unlimited zones, levels, and boxes",
                                                                        "Set tasks for your clients or staff",
                                                                        "10 boxes",
                                                                        "Up to 15 simultaneous customers",
                                                                        "Everything is synched and backed up to the cloud"]),
                Subscription(false, "50 CUSTOMERS", "$ 149.99", ["Add your logo or branding",
                                                                        "promote 10 tips/tricks and promotions",
                                                                        "Create boxes and zones for clients",
                                                                        "Allow users to share your tips/tricks or promotions",
                                                                        "Unlimited spaces",
                                                                        "Unlimited zones, levels, and boxes",
                                                                        "Set tasks for your clients or staff",
                                                                        "10 boxes",
                                                                        "Up to 50 simultaneous customers",
                                                                        "Everything is synched and backed up to the cloud"]),
                Subscription(false, "50+ CUSTOMERS", "contact enterprise@appname.com", [])
        ]
        
    }
}
