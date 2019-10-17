//
//  Map.swift
//  RxSwiftSimple
//
//  Created by David Tran on 17/10/19.
//  Copyright © 2019 DavidTran. All rights reserved.
//

import Foundation

extension ObservableType {
  public func map<U>(_ transform: @escaping (Element) throws -> U) -> Observable<U> {
    return Observable<U>.init(subscribeHandler: { observer -> Disposable in
      let newObserver = Observer<Element> { (event) in
        switch event {
        case .next(let element):
          do {
            try observer.on(.next(transform(element)))
          } catch {
            observer.on(.error(error))
          }
        case .error(let error):
          observer.on(.error(error))
        case .completed:
          observer.on(.completed)
        }
      }
      return self.subscribe(newObserver)
    })
  }
}
