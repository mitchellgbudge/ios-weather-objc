//
//  IIIForecastController.h
//  WeatherObjC
//
//  Created by Mitchell Budge on 11/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IIIForecastController : NSObject

@property NSArray *forecasts;

- (void)fetchForecastsForZipCode:(int)zipCode completion:(void (^)(NSError *))completion;

@end

