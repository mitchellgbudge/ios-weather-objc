//
//  IIIForecast.h
//  WeatherObjC
//
//  Created by Mitchell Budge on 11/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IIIForecast : NSObject

@property NSString *name;
@property double *temperature;
@property UIImage *image;

- (instancetype)initWithName:(NSString *)name temperature:(double)temperature imageName:(NSString *)dictionary;

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary;

@end

