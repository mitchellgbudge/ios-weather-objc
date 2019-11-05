//
//  IIIWeatherViewController.m
//  WeatherObjC
//
//  Created by Ilgar Ilyasov on 3/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import "IIIWeatherViewController.h"
#import "IIIForecastController.h"
#import "IIIWeatherCollectionViewCell.h"

@interface IIIWeatherViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property IIIForecastController *forecastController;

@end

@implementation IIIWeatherViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _forecastController = [[IIIForecastController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.collectionView.dataSource = self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.forecastController.forecasts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IIIWeatherCollectionViewCell *cell = (IIIWeatherCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ForecastCell" forIndexPath:indexPath];
    cell.forecast = self.forecastController.forecasts[indexPath.row];
    [cell updateViews];
    return cell;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    int zipCode = [searchBar.text intValue];
    if (zipCode) {
        [self.forecastController fetchForecastsForZipCode:zipCode completion:^(NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }];
    }
}

@end
