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
        
        for number in 0..<14 {
            controller.arrDataTest.append("canada: \(number)")
        }
    }
    
    func testTableViewHasCells() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! listTableViewCell
        
        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'Cell'")
    }
    
    func testHasZeroSectionsWhenZeroRecord() {
        
        XCTAssertEqual(controller.numberOfSections(in: tableView), 0,
                       "TableView should have zero sections when there is no record")
    }
    
    func testDataSourceHasRecords() {
        XCTAssertEqual(controller.arrDataTest.count, 14,
                       "DataSource should have correct number of records")
    }
    
    func testCellLabelHasTitle() {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! listTableViewCell
        XCTAssertEqual(customCell.lblTitle.text, nil,
                       "No description found for title")
    }
    
    func testNavigationHasTitle() {
        //XCTAssertNotNil(controller.title, "No description found for this cell object")
        XCTAssertEqual(controller.title, nil,
                       "No description found for title")
    }
    
    func testCellForRow() {
        let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.textLabel?.text, nil,
                       "The first cell don't have value")
    }
    
    func testGettingJSON() {
        let expect = expectation(description: "Expecting a JSON data not nil")
        
       ServiceManager.sharedInstance.getallDataFromApi(contenturl:Constant.ApiUrls.baseUrl, getRequestCompleted: { (responseData, responseCode) in
        XCTAssert(responseCode == Constant.ApiResponseCode.Success, "Api request is success")
        if let responseDict = responseData[Constant.ApiKeys.rows] as? [[String : AnyObject]]{
            XCTAssertNil(nil)
            XCTAssertNotNil(responseDict)
            expect.fulfill()
        }else{
            XCTAssertNil(responseData)
        }
     })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
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
