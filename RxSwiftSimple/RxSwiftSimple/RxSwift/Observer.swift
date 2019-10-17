//
//  Observer.swift
//  RxSwiftSimple
//
//  Created by David Tran on 17/10/19.
//  Copyright © 2019 DavidTran. All rights reserved.
//

import Foundation

public final class Observer<Element>: ObserverType {
  private let handler: (Event<Element>) -> Void

  public init(handler: @escaping (Event<Element>) -> Void) {
    self.handler = handler
  }

  public func on(_ event: Event<Element>) {
    handler(event)
  }
}
