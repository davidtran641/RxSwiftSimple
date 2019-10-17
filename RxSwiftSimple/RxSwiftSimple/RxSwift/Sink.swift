//
//  Sink.swift
//  RxSwiftSimple
//
//  Created by David Tran on 17/10/19.
//  Copyright © 2019 DavidTran. All rights reserved.
//

import Foundation

public final class Sink<O: ObserverType>: Disposable {
  private var disposed = false
  private let observer: O
  private let subscriptionHandler: (Observer<O.Element>) -> Disposable
  private let composite = CompositeDisposable()

  init(observer: O, subscriptionHandler: @escaping (Observer<O.Element>) -> Disposable) {
    self.observer = observer
    self.subscriptionHandler = subscriptionHandler
  }

  func run() {
    let observer = Observer<O.Element>(handler: forward)
    composite.add(disposable: subscriptionHandler(observer))
  }

  private func forward(event: Event<O.Element>) {
    guard !disposed else { return }
    observer.on(event)
    switch event {
    case .completed, .error:
      dispose()
    default:
      break
    }
  }

  public func dispose() {
    disposed = true
    composite.dispose()
  }
}
