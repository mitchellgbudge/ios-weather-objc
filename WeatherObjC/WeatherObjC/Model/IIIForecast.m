//
//  IIIForecast.m
//  WeatherObjC
//
//  Created by Mitchell Budge on 11/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import "IIIForecast.h"

@implementation IIIForecast

-(instancetype)initWithName:(NSString *)name temperature:(double)temperature iconName:(NSString *)iconName {
    self = [super init];
    if (self) {
        _name = name;
        _temperature = temperature;
        _image = [UIImage imageNamed:iconName];
    }
    return self;
}

-(instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    NSDictionary *temperatureDictionary = dictionary[@"temp"];
    double temperature = [temperatureDictionary[@"day"] doubleValue];
    NSArray *weatherDictionary = dictionary[@"weather"];
    NSDictionary *weatherForecast = [weatherDictionary firstObject];
    NSString *iconName = weatherForecast[@"icon"];
    return [self initWithName:name temperature:temperature iconName:iconName];
}

@end
