//
//  SpeedTest.swift
//  TestSplee
//
//  Created by Administrator on 2015/09/10.
//  Copyright © 2015年 Little Gleam. All rights reserved.
//

import Foundation
import RealmSwift

/// 何もしない場合
struct None: SpeedTest {
	
	func main() {
	}
}

/// if let を使ったnilチェック
struct NLLet: SpeedTest {
	var str: String?
	
	init(str: String?) {
		self.str = str
	}
	
	func main() {
		if let _ = str {
		}
	}
}

/// str != nil のnilチェック
struct NLEqual: SpeedTest {
	var str: String?
	
	init(str: String?) {
		self.str = str
	}
	
	func main() {
		if str != nil {
		}
	}
}

// MARK: 存在チェック

/// countによる存在チェック
struct EXACount: SpeedTest {
	var arr: [Int]
	
	init(arr: [Int]) {
		self.arr = arr
	}
	
	func main() {
		if arr.count > 0 {
		}
	}
}

/// firstによる存在チェック
struct EXAFirst: SpeedTest {
	var arr: [Int]
	
	init(arr: [Int]) {
		self.arr = arr
	}
	
	func main() {
		if let _ = arr.first {
		}
	}
}

/// isEmptyによる存在チェック
struct EXAEmpty: SpeedTest {
	var arr: [Int]
	
	init(arr: [Int]) {
		self.arr = arr
	}
	
	func main() {
		if !arr.isEmpty {
		}
	}
}

// MARK: Stringの存在チェック

/// countによる存在チェック
struct EXSLength: SpeedTest {
	var str = NSUUID().UUIDString
	
	func main() {
		if str.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
		}
	}
}

/// isEmptyによる存在チェック
struct EXStringEmpty: SpeedTest {
	var str = NSUUID().UUIDString
	
	func main() {
		if !str.isEmpty {
		}
	}
}

// MARK: Realmの存在チェック

struct RLEmpty: SpeedTest {
	var res: Results<User>
	
	init(res: Results<User>) {
		self.res = res
	}
	
	func main() {
		if !res.isEmpty {
		}
	}
}

struct RLCount: SpeedTest {
	var res: Results<User>
	
	init(res: Results<User>) {
		self.res = res
	}
	
	func main() {
		if res.count > 0 {
		}
	}
}

// MARK: Array.append

class APAppend: SpeedTest {
	var arr = [Int]()
	
	func setup() {
		// クリアする
		arr = [Int]()
	}
	
	func main() {
		arr.append(1)
	}
}

class APInsertLast: SpeedTest {
	var arr = [Int]()
	
	func setup() {
		// クリアする
		arr = [Int]()
	}
	
	func main() {
		arr.insert(1, atIndex: arr.count)
	}
}

class APInsertFirst: SpeedTest {
	var arr = [Int]()
	
	func setup() {
		// クリアする
		arr = [Int]()
	}
	
	func main() {
		arr.insert(1, atIndex: 0)
	}
}

// MARK: Arrayの走破

struct ECForIn: SpeedTest {
	var arr = [Int]()
	
	init(arr: [Int]) {
		self.arr = arr
	}
	
	func main() {
		for _ in arr {
		}
	}
}

struct ECCount: SpeedTest {
	var arr = [Int]()
	
	init(arr: [Int]) {
		self.arr = arr
	}
	
	func main() {
		for i in 0..<arr.count {
			_ = arr[i]
		}
	}
}

struct ECEnumerate: SpeedTest {
	var arr = [Int]()
	
	init(arr: [Int]) {
		self.arr = arr
	}
	
	func main() {
		for (_, _) in arr.enumerate() {
		}
	}
}

// MARK: class, structの初期化

struct CSClass: SpeedTest {
	class Test {
	}
	
	func main() {
		let _ = Test()
	}
}

struct CSStruct: SpeedTest {
	struct Test {
	}
	
	func main() {
		let _ = Test()
	}
}

// MARK: LOG関数

struct LGFuncNormal: SpeedTest {
	func main() {
		LOG(NSUUID().UUIDString)
	}
}

let Log: Logger? = Logger()
let LogNil: Logger? = nil

struct LGFuncAutoclosure: SpeedTest {
	func main() {
		LOGAC(NSUUID().UUIDString)
	}
}

struct LGFuncAutoclosure2: SpeedTest {
	func main() {
		LOGAC2(NSUUID().UUIDString)
	}
}

struct LGLogger: SpeedTest {
	func main() {
		Log?.put(NSUUID().UUIDString)
	}
}

struct LGLoggerNil: SpeedTest {
	func main() {
		LogNil?.put(NSUUID().UUIDString)
	}
}

// よくあるLOG関数
func LOG(str: String, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) {
	
}
// よくあるLOG関数をautoclosureにして評価させない
func LOGAC(@autoclosure _: () -> String, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) {
}

func LOGAC2<T>(@autoclosure value: () -> T, @autoclosure function: () -> String = __FUNCTION__, @autoclosure file: () -> String = __FILE__, @autoclosure line: () -> Int = __LINE__) {
	//print("<\(file):\(line) \(function)> \(value)")
}

struct Logger {
	func put<T>(str: T, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) {
		
	}
}

// MARK: メソッド呼び出し

class SwiftClass {
	func method() {
	}
}

struct MTSwift: SpeedTest {
	let obj = SwiftClass()
	
	func main() {
		obj.method()
	}
}

struct MTObjC: SpeedTest {
	let obj = ObjCClass()
	
	func main() {
		obj.method()
	}
}

// MARK: SpeedTest Protocol

protocol SpeedTest {
	func setup()
	func main()
}

extension SpeedTest {
	
	func setup() {
	}
	
	func start(repeats: Int, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) {
		var total: Double = 0
		var name = _stdlib_getDemangledTypeName(self)
		if let range = name.rangeOfString(".") {
			name = name.substringFromIndex(range.endIndex)
		}
		
		print(name)
		print("-" * 20)
		
		// 5回リピート
		for _ in 0..<5 {
			setup()
			let start = NSDate()
			
			autoreleasepool {
				for _ in 0..<repeats {
					main()
				}
			}
			
			let e = NSDate().timeIntervalSinceDate(start) as Double
			print(String(format: "%.3f", e))
			total += e
		}
		
		let avg = String(format: "%.3f", total / 5)
		print("-" * 20)
		print("Avg: \(avg)")
		print("=" * 20)
		
	}
	
}

func *(lhs: String, rhs: Int) -> String {
	var res = ""
	for _ in 0..<rhs {
		res += lhs
	}
	return res
}