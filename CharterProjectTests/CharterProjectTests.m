//
//  CharterProjectTests.m
//  CharterProjectTests
//
//  Created by alexandra blumenfeld on 6/8/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CharterAPI.h"

@interface CharterProjectTests : XCTestCase
@property (nonatomic) NSDictionary *dict;

@end

@implementation CharterProjectTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _dict = nil;
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
}



@end
