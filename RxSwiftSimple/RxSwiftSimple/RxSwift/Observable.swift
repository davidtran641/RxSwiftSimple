//
//  Observable.swift
//  RxSwiftSimple
//
//  Created by David Tran on 17/10/19.
//  Copyright © 2019 DavidTran. All rights reserved.
//

import Foundation

public final class Observable<Element>: ObservableType {

  public typealias SubscribeHandler = (Observer<Element>) -> Disposable
  private let subscribeHandler: SubscribeHandler

  public init(subscribeHandler: @escaping SubscribeHandler) {
    self.subscribeHandler = subscribeHandler
  }

  public func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.Element == Element {
    let sink = Sink(observer: observer, subscriptionHandler: subscribeHandler)
    sink.run()
    return sink
  }
}
