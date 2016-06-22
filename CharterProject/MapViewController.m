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

@interface MapViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
@property CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
@property (weak, nonatomic) IBOutlet UIButton *getDirectionsButton;

@end


@implementation MapViewController


- (void)viewDidLoad {
    
    self.dismissButton.tintColor = [UIColor whiteColor];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    self.mapView.showsUserLocation = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.locationManager stopUpdatingLocation];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake([self.charterService.latitude doubleValue], [self.charterService.longitude doubleValue]);
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
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
    NSString *stringUrl = [NSString stringWithFormat:@"http://maps.apple.com/maps?daddr=%@,%@", self.charterService.latitude,self.charterService.longitude];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringUrl]];
}



- (IBAction)dismissView:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
