//
//  YELPAPISample.m
//  GebeChat
//
//  Created by Siba Prasad Hota  on 1/5/15.
//  Copyright (c) 2015 WemakeAppz. All rights reserved.
//

//3rd part code
#import "YELPAPISample.h"

#import "OAMutableURLRequest.h"

static NSString * const kConsumerKey       = @"e9_sRYZXpHxBP3N_qwYlpw";
static NSString * const kConsumerSecret    = @"SVi7RR1IFqzS4qkgmU6VZdRuvxM";
static NSString * const kToken             = @"Um5yfXYvkN5QDVgnI-TyMlwYfBOixbfF";
static NSString * const kTokenSecret       = @"pqjuLvjKAJEJoyb00tfi4uX8HF0";


static NSString * const kAPIHost           = @"api.yelp.com";
static NSString * const kSearchPath        = @"/v2/search/";
static NSString * const kBusinessPath      = @"/v2/business/";
static NSString * const kSearchLimit       = @"20";



@implementation YELPAPISample


- (void)getServerResponseForLocation:(NSString *)location
                                term:(NSString*)term
                             iSLonglat:(BOOL)longlat
                 withSuccessionBlock:(void(^)(NSDictionary * topBusinessJSON))successBlock
                     andFailureBlock:(void(^)(NSError *error))failureBlock
{
    NSLog(@"Querying the Search API with term \'%@\' and location \'%@'", term, location);
    //Make a first request to get the search results with the passed term and location
    NSURLRequest *searchRequest = (longlat)?[self _searchRequestWithTermandLocation:term longlat:location]:[self _searchRequestWithTerm:term location:location];
    [NSURLConnection sendAsynchronousRequest:searchRequest queue:[NSOperationQueue mainQueue]completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(@"response from server = %@",newStr);
         if ([(NSHTTPURLResponse *)response statusCode]==200)
         {
             NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             successBlock(searchResponseJSON);
         }
         else
         {
             failureBlock(error);
         }
     }];
}





- (void)queryBusinessInfoForBusinessId:(NSString *)businessID completionHandler:(void (^)(NSDictionary *topBusinessJSON, NSError *error))completionHandler {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *businessInfoRequest = [self _businessInfoRequestForID:businessID];
    [[session dataTaskWithRequest:businessInfoRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (!error && httpResponse.statusCode == 200) {
            NSDictionary *businessResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            completionHandler(businessResponseJSON, error);
        } else {
            completionHandler(nil, error);
        }
    }] resume];
    
}


#pragma mark - API Request Builders

/**
 Builds a request to hit the search endpoint with the given parameters.
 
 @param term The term of the search, e.g: dinner
 @param location The location request, e.g: San Francisco, CA
 
 @return The NSURLRequest needed to perform the search
 */
- (NSURLRequest *)_searchRequestWithTerm:(NSString *)term location:(NSString *)location {
   
    
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:term,@"term",location,@"location",kSearchLimit,@"limit", nil] ;
 
    
    return [self requestWithHost:kAPIHost path:kSearchPath params:params];
}


- (NSURLRequest *)_searchRequestWithTermandLocation:(NSString *)term longlat:(NSString *)longlat {
    
     NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:term,@"term",longlat,@"ll",kSearchLimit,@"limit", nil] ;

    
    return [self requestWithHost:kAPIHost path:kSearchPath params:params];
}



/**
 Builds a request to hit the business endpoint with the given business ID.
 
 @param businessID The id of the business for which we request informations
 
 @return The NSURLRequest needed to query the business info
 */
- (NSURLRequest *)_businessInfoRequestForID:(NSString *)businessID {
    
    NSString *businessPath = [NSString stringWithFormat:@"%@%@", kBusinessPath, businessID];
    return [self requestWithHost:kAPIHost path:businessPath];
}




- (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path {
    return [self requestWithHost:host path:path params:nil];
}

-(NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)params {
    NSURL *URL = [self _URLWithHost:host path:path queryParameters:params];
    
    if ([kConsumerKey length] == 0 || [kConsumerSecret length] == 0 || [kToken length] == 0 || [kTokenSecret length] == 0) {
        NSLog(@"WARNING: Please enter your api v2 credentials before attempting any API request. You can do so in NSURLRequest+OAuth.m");
    }
    
    OAConsumer *consumer = [[OAConsumer alloc] initWithKey:kConsumerKey secret:kConsumerSecret];
    OAToken *token = [[OAToken alloc] initWithKey:kToken secret:kTokenSecret];
    
    //The signature provider is HMAC-SHA1 by default and the nonce and timestamp are generated in the method
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:URL consumer:consumer token:token realm:nil signatureProvider:nil];
    [request setHTTPMethod:@"GET"];
    [request prepare]; // Attaches our consumer and token credentials to the request
    
    return request;
}

#pragma mark - URL Builder Helper

/**
 Builds an NSURL given a host, path and a number of queryParameters
 
 @param host The domain host of the API
 @param path The path of the API after the domain
 @param params The query parameters
 @return An NSURL built with the specified parameters
 */
- (NSURL *)_URLWithHost:(NSString *)host path:(NSString *)path queryParameters:(NSDictionary *)queryParameters {
    
    NSMutableArray *queryParts = [[NSMutableArray alloc] init];
    for (NSString *key in [queryParameters allKeys]) {
        NSString *queryPart = [NSString stringWithFormat:@"%@=%@", key, queryParameters[key]];
        [queryParts addObject:queryPart];
    }
    
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"http";
    components.host = host;
    components.path = path;
    components.query = [queryParts componentsJoinedByString:@"&"];
    
    return [components URL];
}


@end
