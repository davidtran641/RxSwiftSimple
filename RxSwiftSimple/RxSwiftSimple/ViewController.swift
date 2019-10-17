//
//  ViewController.swift
//  RxSwiftSimple
//
//  Created by David Tran on 17/10/19.
//  Copyright © 2019 DavidTran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  private var disposable: Disposable?

  override func viewDidLoad() {
    super.viewDidLoad()

    startEvent()
    clearDisposable()
  }

  func startEvent() {
    let observable = Observable<Int>.init { (observer) -> Disposable in
      observer.onNext(1)
      observer.onNext(2)
      observer.onNext(3)
      return AnonymousDisposable({
        print("Disposed")
      })
    }

    disposable = observable
//      .map { $0 * 2 } 
      .subscribe { value in
        print("OnNext \(value)")
      }

    print("== End startEvent\n")
  }

  func clearDisposable() {
    print("== Start startEvent\n")
    disposable?.dispose()
    disposable = nil
  }


}

