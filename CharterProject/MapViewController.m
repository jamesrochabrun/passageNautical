//
//  MapViewController.m
//  CharterProject
//
//  Created by James Rochabrun on 21-06-16.
//  Copyright © 2016 jamesrochabrun. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CharterService.h"
#import "LocationManager.h"

@interface MapViewController ()<MKMapViewDelegate,CLLocationManagerDelegate,LocationManagerDelegate>
//@property CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
@property (weak, nonatomic) IBOutlet UIButton *getDirectionsButton;
@property (nonatomic, strong) LocationManager *locationManager;
@end


@implementation MapViewController


- (void)viewDidLoad {

    _dismissButton.tintColor = [UIColor whiteColor];
    
    _locationManager = [LocationManager new];
    _locationManager.delegate = self;

    self.mapView.showsUserLocation = YES;
}

- (void)displayAlertInVC:(UIAlertController *)alertController {
    
    __weak MapViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    });
}

- (void)viewDidDisappear:(BOOL)animated {
    
    _locationManager = nil;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    
    NSLog(@"the latitude is %@ , and the longitude is %@", _charterService.latitude , _charterService.longitude);
    
    point.coordinate = CLLocationCoordinate2DMake([self.charterService.latitude doubleValue], [self.charterService.longitude doubleValue]);
    point.title = @"Departure point";
   // point.subtitle = @"Richmond";

    
    [self.mapView setRegion:MKCoordinateRegionMake(point.coordinate, MKCoordinateSpanMake(0.8f, 0.8f)) animated:YES];

    [self.mapView addAnnotation:point];
}


- (IBAction)switchMapTypes:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
            
        default:
            break;
    }
}

- (IBAction)getDirectionsButtonTapped:(UIButton *)sender {
    
    NSString *stringUrl = [NSString stringWithFormat:@"http://maps.apple.com/maps?daddr=%@,%@", self.charterService.latitude ,self.charterService.longitude];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringUrl]];
}



- (IBAction)dismissView:(UIButton *)sender {
    
    __weak MapViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    });
}





@end
