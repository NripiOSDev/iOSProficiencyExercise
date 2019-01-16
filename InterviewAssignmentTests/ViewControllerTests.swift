//
//  RootViewControllerTests.swift
//  InterviewAssignmentTests
//
//  Created by Nripendra singh on 14/01/19.
//  Copyright © 2019 Nripendra singh. All rights reserved.
//

import XCTest
@testable import InterviewAssignment

class RootViewControllerTests: XCTestCase {
    var controller: RootViewController!
    var tableView: UITableView!
    var dataSource: UITableViewDataSource!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        guard let vc = RootViewController() as? UIViewController  else {
                return XCTFail("Could not instantiate RootViewController from main storyboard")
        }
        
        controller = vc as? RootViewController
        controller.loadViewIfNeeded()
        tableView = controller.listTableview
        
        guard let ds = tableView.dataSource else {
            return XCTFail("Controller's table view should have a data source")
        }
        dataSource = ds
    }
    func testTableViewHasCells() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell")
        
        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'Cell'")
    }
    
    func testHasZeroSectionsWhenZeroRecord() {
        
        XCTAssertEqual(controller.numberOfSections(in: tableView), 0,
                       "TableView should have zero sections when there is no record")
    }
    
    func testDataSourceHasRecords() {
        XCTAssertEqual(controller.arrDataList.count, 0,
                       "DataSource should have correct number of records")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
