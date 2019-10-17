//
//  ObservableType.swift
//  RxSwiftSimple
//
//  Created by David Tran on 17/10/19.
//  Copyright © 2019 DavidTran. All rights reserved.
//

public enum Event<Element> {
  /// Next element is produced.
  case next(Element)

  /// Sequence terminated with an error.
  case error(Swift.Error)

  /// Sequence completed successfully.
  case completed
}

public protocol ObserverType {
  associatedtype Element

  /// Notify observer about sequence event.
  ///
  /// - parameter event: Event that occurred.
  func on(_ event: Event<Element>)
}

public extension ObserverType {
  func onNext(_ value: Element) {
    on(.next(value))
  }
}

/// Represents a disposable resource.
public protocol Disposable {
  /// Dispose resource.
  func dispose()
}

public protocol ObservableType {
  associatedtype Element

  func subscribe<Observer: ObserverType>(_ observer: Observer) -> Disposable where Observer.Element == Element
}

extension ObservableType {
  public func subscribe(onNext: ((Element) -> Void)? = nil) -> Disposable {
    let observer = Observer<Element> { (event) in
      switch event {
      case .next(let value):
        onNext?(value)
      default:
        break
      }
    }
    return subscribe(observer)
  }
}
