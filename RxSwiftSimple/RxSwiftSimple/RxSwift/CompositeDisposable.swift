//
//  CompositeDisposable.swift
//  RxSwiftSimple
//
//  Created by David Tran on 17/10/19.
//  Copyright © 2019 DavidTran. All rights reserved.
//

import Foundation

public final class CompositeDisposable: Disposable {
  private var isDisposed: Bool = false

  public func dispose() {
    guard !isDisposed else { return }
    isDisposed = true
    disposables.forEach { $0.dispose() }
  }

  private var disposables: [Disposable] = []

  public init() { }

  public func add(disposable: Disposable) {
    if isDisposed {
      disposable.dispose()
      return
    }
    disposables.append(disposable)
  }

}
