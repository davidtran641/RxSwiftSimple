//
//  AnonimousDisposable.swift
//  RxSwiftSimple
//
//  Created by David Tran on 17/10/19.
//  Copyright © 2019 DavidTran. All rights reserved.
//

import Foundation

public final class AnonymousDisposable: Disposable {
  public typealias DisposeAction = () -> Void

  private var disposeAction: DisposeAction?
  init(_ disposeAction: @escaping DisposeAction) {
    self.disposeAction = disposeAction
  }

  public func dispose() {
    disposeAction?()
  }
}
