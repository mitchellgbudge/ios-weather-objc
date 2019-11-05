//
//  IIIWeatherCollectionViewCell.m
//  WeatherObjC
//
//  Created by Ilgar Ilyasov on 3/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import "IIIWeatherCollectionViewCell.h"

@interface IIIWeatherCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;


@end

@implementation IIIWeatherCollectionViewCell

- (void) updateViews {
    if (self.forecast != nil) {
        self.weatherImageView.image = self.forecast.image;
        self.temperatureLabel.text = [NSString stringWithFormat:@"%.f", self.forecast.temperature];
    }
}

@end
