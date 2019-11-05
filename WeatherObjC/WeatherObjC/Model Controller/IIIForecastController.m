//
//  IIIForecastController.m
//  WeatherObjC
//
//  Created by Mitchell Budge on 11/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import "IIIForecastController.h"
#import "IIIForecast.h"

@implementation IIIForecastController

static NSString * const baseURLString = @"https://api.openweathermap.org/data/2.5/forecast/daily";
static NSString * const apiKey = @"2198ccfbceb8bcfe318303719f948526";

- (instancetype)init {
    self = [super init];
    if (self) {
        _forecasts = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)fetchForecastsForZipCode:(int)zipCode completion:(void (^)(NSError *))completion {
    NSString *zipCodeString = [NSString stringWithFormat:@"%i", zipCode];
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:baseURL resolvingAgainstBaseURL:true];
    
    NSURLQueryItem *zipCodeItem = [[NSURLQueryItem alloc] initWithName:@"zip" value:zipCodeString];
    NSURLQueryItem *appIDItem = [[NSURLQueryItem alloc] initWithName:@"appid" value:apiKey];
    NSURLQueryItem *unitsItem = [[NSURLQueryItem alloc] initWithName:@"units" value:@"imperial"];
    
    components.queryItems = @[zipCodeItem, appIDItem, unitsItem];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:components.URL];
    
    NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithURL:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching forecasts");
            completion(error);
            return;
        }
        if (!data) {
            NSLog(@"No data returned from data task");
            completion([[NSError alloc] init]);
            return;
        }
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSMutableArray *fetchedForecasts = [[NSMutableArray alloc] init];
        NSDictionary *cityDictionary = dictionary[@"city"];
        NSString *cityName = cityDictionary[@"name"];
        NSArray *listDictionaries = dictionary[@"list"];
        for (int i = 0; i < listDictionaries.count; i++) {
            NSDictionary *forecastDictionary = listDictionaries[i];
            IIIForecast *forecast = [[IIIForecast alloc] initWithName:cityName dictionary:forecastDictionary];
            [fetchedForecasts addObject:forecast];
        }
        self.forecasts = fetchedForecasts;
        completion(nil);
    }];
    [dataTask resume];
}

@end
