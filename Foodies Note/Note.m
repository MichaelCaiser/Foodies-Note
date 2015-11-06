//
//  Note.m
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/8.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

//the class to encode,decode the note's property
#import "Note.h"

@implementation Note

// delegate method
//decoder
- (id) initWithCoder:(NSCoder *) decoder{
    self=[super init];
    self.title = [decoder decodeObjectForKey:@"title"];
    self.content = [decoder decodeObjectForKey:@"content"];
    self.link = [decoder decodeObjectForKey:@"link"];
    self.year = [decoder decodeObjectForKey:@"year"];
    self.month = [decoder decodeObjectForKey:@"month"];
    self.date = [decoder decodeObjectForKey:@"date"];
    self.week = [decoder decodeObjectForKey:@"week"];
    self.imagepath = [decoder decodeObjectForKey:@"imagepath"];
    self.imagepaths = [decoder decodeObjectForKey:@"imagepaths"];
    self.location = [decoder decodeObjectForKey:@"location"];
    self.restimageurl = [decoder decodeObjectForKey:@"restimageurl"];
    
    return self;
}

//encoder
- (void) encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.content forKey:@"content"];
    [encoder encodeObject:self.link forKey:@"link"];
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.year forKey:@"year"];
    [encoder encodeObject:self.month forKey:@"month"];
    [encoder encodeObject:self.week forKey:@"week"];
    [encoder encodeObject:self.imagepath forKey:@"imagepath"];
    [encoder encodeObject:self.imagepaths forKey:@"imagepaths"];
    [encoder encodeObject:self.location forKey:@"location"];
    [encoder encodeObject:self.restimageurl forKey:@"restimageurl"];
}

@end
