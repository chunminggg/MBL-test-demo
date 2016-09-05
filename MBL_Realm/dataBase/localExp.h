//
//  localExp.h
//  MBL_Realm
//
//  Created by neo-mac on 16/7/29.
//  Copyright © 2016年 neo-mac. All rights reserved.
//

#import <Realm/Realm.h>

@interface localExp : RLMObject
@property NSString *objectID;
@property NSString *expTitle;
@property NSString *expAuthor;
@property NSString *update;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<localExp>
RLM_ARRAY_TYPE(localExp)
