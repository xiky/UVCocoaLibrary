//  Copyright (c) 2014年 XXXX. All rights reserved.
// --------------------------------------------------------------------------------
// UVRecord.m
//
// Project Code: CoreData
// Module Name:
// Date Created: 14-3-7
// Author: chenjiaxin/00891
// Description:
//
// --------------------------------------------------------------------------------
// Modification History
// DATE        NAME             DESCRIPTION
// --------------------------------------------------------------------------------
// 14-3-7  c00891 create
//

#import "UVIdEntity.h"

@implementation UVIdEntity

- (instancetype)init
{
    if(self = [super init])
    {
        _id_ = @(-1);
    }
    
    return self;
}

- (NSString*)getString:(id)obj_
{
    NSString *v = [NSString uv_stringByObject:obj_ default:@"" trim:YES];
    return v;
}

- (NSNumber*)getNum:(id)obj_
{
    NSNumber *v = [NSNumber uv_numberByObject:obj_ default:@(0)];
    return v;
}

- (NSArray*)getArr:(id)obj_
{
    NSArray *v = [NSArray uv_arrayByObject:obj_ default:[NSMutableArray array] filterNull:YES trim:YES];
    return v;
}

- (NSDictionary*)getDict:(id)obj_
{
    NSDictionary *v = [NSDictionary uv_dictionaryByObject:obj_ default:@{}];
    return v;
}

//- (NSString*)description
//{
//    NSString *string = [NSString stringWithFormat:@"%@",self];
//    return string;
//}
@end
