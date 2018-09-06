//
//  TBPreApprovalVC.h
//  CangoToB
//
//  Created by KiddieBao on 10/01/2018.
//  Copyright © 2018 Kiddie. All rights reserved.
//

#import "TBWebVC.h"

@interface TBWechatShare : NSObject
@property (nonatomic, copy) NSString * shareUrl;
@property (nonatomic, copy) NSString * secondaryTitle;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * imageUrl;
@end

@interface TBPreApprovalVC : TBWebVC
@property (nonatomic, strong)NSDictionary *params;

@end
