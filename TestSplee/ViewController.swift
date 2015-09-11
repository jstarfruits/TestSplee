//
//  ViewController.swift
//  TestSplee
//
//  Created by Administrator on 2015/08/21.
//  Copyright © 2015年 Little Gleam. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		let defaultCnt = 1000000
		let arrCnt = 100000
		let realmCnt = 100000
		
		var arr = [Int]()
		for i in 0..<arrCnt {
			arr.append(i)
		}
		
		None().start(defaultCnt)
		
		NLEqual(str: nil).start(defaultCnt)
		NLLet(str: nil).start(defaultCnt)
		
		// 値がある場合は
		
		NLEqual(str: NSUUID().UUIDString).start(defaultCnt)
		NLLet(str: NSUUID().UUIDString).start(defaultCnt)
		
		// 配列の存在チェック
		
		EXACount(arr: arr).start(defaultCnt)
		EXAFirst(arr: arr).start(defaultCnt)
		EXAEmpty(arr: arr).start(defaultCnt)
		
		// 文字列の存在チェック
		EXSLength().start(defaultCnt)
		EXSEmpty().start(defaultCnt)
		EXSEqual().start(defaultCnt)
		
		// Realmの存在チェック
		let realm = try! Realm()
		
		if realm.objects(User.self).first == nil {
			realm.write {
				for _ in 0..<realmCnt {
					realm.add(User())
				}
			}
		}
		
		RLEmpty(res: realm.objects(User.self)).start(defaultCnt)
		RLCount(res: realm.objects(User.self)).start(defaultCnt)

		// MARK: Array.append
		
		// 時間かかるので少なめに
		let appendCount = 100000
		
		APAppend().start(appendCount)
		APInsertLast().start(appendCount)
		
		// 超遅いので、appendしてからreverseするとかアリ
		APInsertFirst().start(appendCount)

		
		// MARK: Arrayの走破
		
		let eachCount = 10
		ECForIn(arr: arr).start(eachCount)
		ECEnumerate(arr: arr).start(eachCount)
		ECCount(arr: arr).start(eachCount)
		
		// MARK: class, structの初期化
		
		CSClass().start(defaultCnt)
		CSStruct().start(defaultCnt)
		
		// MARK: LOG関数

		LGFuncNormal().start(defaultCnt)
		LGFuncAutoclosure().start(defaultCnt)
		LGFuncAutoclosure2().start(defaultCnt)
		LGLogger().start(defaultCnt)
		LGLoggerNil().start(defaultCnt)
		
		// MARK: メソッド呼び出し
		MTSwift().start(defaultCnt)
		MTObjC().start(defaultCnt)
		
		print("end of sorrow")
	}
	
}


extension String : CollectionType {}

class User: Object {
	dynamic var id = NSUUID().UUIDString
	
	override class func primaryKey() -> String? {
		return "id"
	}
}