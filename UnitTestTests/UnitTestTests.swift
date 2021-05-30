//
//  UnitTestTests.swift
//  UnitTestTests
//
//  Created by yleaf on 2021/5/30.
//

import XCTest

@testable import UnitTest

class DownloadHandler: NSObject {
    let session: URLSession = URLSession(configuration: .default)
    public func download(_ request: URLRequest, completionHandler: @escaping (_ success: Bool, URL?, URLResponse?, Error?) -> Void) {
        let task = session.downloadTask(with: request) { url, response, error in
            let success = true
            completionHandler(success, url, response, error)
            print(response ?? "no response")
        }
        task.resume()
    }
}

class UnitTestTests: XCTestCase {

    let downloader = DownloadHandler()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDownload() {
        let expectation = self.expectation(description: "\(#function)")
        
        let request = URLRequest(url: URL(string: "https://api.github.com/users")!)
        
        downloader.download(request) { success, url, res, err in
            print("url: \(String(describing: url?.absoluteString)), res: \(String(describing: res)), err: \(String(describing: err))")
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { error in
            if let e = error {
                print("\(e)")
            }
        }
    }

    func testRemovePreviousDownload() throws {
    
        let expectation = self.expectation(description: "\(#function)")
        
        let request = URLRequest(url: URL(string: "https://api.github.com/users")!)
        
        downloader.download(request) { success, url, res, err in
            print("url: \(String(describing: url?.absoluteString)), res: \(String(describing: res)), err: \(String(describing: err))")
            XCTFail()
        }
        
        
        downloader.download(request) { success, url, res, err in
            print("url: \(String(describing: url?.absoluteString)), res: \(String(describing: res)), err: \(String(describing: err))")
            expectation.fulfill()
        }
        
        
        self.waitForExpectations(timeout: 10) { error in
            if let e = error {
                print("\(e)")
            }
        }
        
    }
    
    func testFailDownload() throws {
        let expectation = self.expectation(description: "\(#function)")
        
        let request = URLRequest(url: URL(string: "https://api.github.com/users11111")!)
        
        downloader.download(request) { success, url, res, err in
            print("url: \(String(describing: url?.absoluteString)), res: \(String(describing: res)), err: \(String(describing: err))")
            if success {
                XCTFail()
            } else {
                expectation.fulfill()
            }
        }
        
        
        self.waitForExpectations(timeout: 10) { error in
            if let e = error {
                print("\(e)")
            }
        }

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
