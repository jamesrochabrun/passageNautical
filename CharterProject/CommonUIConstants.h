//
//  CommonUIConstants.h
//  ooApp
//
//  Created by James Rochabrun on 7/31/16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>

// Convenience Macros
#define UIColorRGB(rgbValue) [UIColor colorWithRed:(255&(rgbValue>> 16))/255.0f \
green:(255&(rgbValue >> 8))/255.0 \
blue:(255&rgbValue)/255.0 alpha:1.0]

#define UIColorRGBA(rgbValue) [UIColor colorWithRed:(255&(rgbValue>> 16))/255.0f \
green:(255&(rgbValue >> 8))/255.0f \
blue:(255&rgbValue)/255.0f \
alpha:(rgbValue >> 24)/255.0f]

#define UIColorRGBOverlay(rgbValue, alphaValue) [UIColor colorWithRed:(255&(rgbValue>> 16))/255.0f \
green:(255&(rgbValue >> 8))/255.0f \
blue:(255&rgbValue)/255.0f \
alpha:alphaValue]

static NSUInteger kColorOffBlack = 0xFF272727;


// Geometry and metrics

static CGFloat kGeomHeightStatusBar = 20.0;
static CGFloat kGeomWidthBigButton = 210.0;
static CGFloat kGeomHeightBigbutton = 40.0;
static CGFloat kGeomBottomPadding = 100.0;
static CGFloat kGeomMarginMedium = 20.0;
static CGFloat kGeomHeightToolBar = 70.0;
static CGFloat kGeomMarginBig = 40.0;
static CGFloat kGeomHeaderHeightInSection = 40.0;
static CGFloat kGeomWidthToolBarButton = 85.0;
static CGFloat kGeomTopViewHeight = 75.0;
static CGFloat kGeomDismmissButton = 44.0;
static CGFloat kGeomMarginDismissButton = 26.0;
static CGFloat kGeomHeightTextField = 35.0;
static CGFloat kGeomSpaceEdge = 4.0;
static CGFloat kGeomMinSpace = 1.0;
static CGFloat kGeomMinimunInterItemSpacing = 5;
static CGFloat kGeomSpaceCellPadding = 3;
static CGFloat kGeomContactButton = 45;



extern NSString *const kcontactNumber;
extern NSString *const kcontactEmail;
extern NSString *const kemailSubject;
extern NSString *const kcompanyDescription;
extern NSString *const khalfDayCategoryID;
extern NSString *const kfullDayCategoryID;
extern NSString *const knauticalOvernightCategoryId;
extern NSString *const kbedAndBoatCategoryID;

