//
//  UVSoap.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 14/10/20.
//  Copyright (c) 2014年 XXXX. All rights reserved.
//

#import "UVSoap.h"
#import "UVHttpClient.h"

@implementation UVSoap


+ (NSDictionary*)sendSoap:(NSURL*)url_ method:(NSString*)method_ data:(NSString*)data_
{
    //data参考
    //<pcUserID>0</pcUserID><n0:pstWiFiExternCfg><szSSID>XXXX1</szSSID><szKey>123456781</szKey><ulNetworkType>1</ulNetworkType><ulAuthMode>1</ulAuthMode><ulEncrypType>1</ulEncrypType><bEnable>1</bEnable></n0:pstWiFiExternCfg>
    
    NSString *body = [NSString stringWithFormat:@"<v:Envelope xmlns:i=\"http://www.w3.org/1999/XMLSchema-instance\" xmlns:d=\"http://www.w3.org/1999/XMLSchema\" xmlns:c=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:v=\"http://schemas.xmlsoap.org/soap/envelope/\"><v:Header /><v:Body><n0:%@ id=\"o0\" c:root=\"1\" xmlns:n0=\"urn:calc\">%@</n0:%@></v:Body></v:Envelope>",method_,data_,method_];
    UVHttpClient *http = [[UVHttpClient alloc] init];
    http.responseType = RESPONSE_TYPE_XML;
    [http setContentType:@"text/xml;charset=utf-8"];
    [http setValue:@"" forHTTPHeaderField:@"SOAPAction"];
    [http setValue:@"ksoap2-android/2.6.0+" forHTTPHeaderField:@"User-Agent"];
    NSError *error;
    NSDictionary *xmlDictionary = [http postData:url_ data:[body dataUsingEncoding:NSUTF8StringEncoding] error:&error];
    if(error)
    {
        @throw error;
    }
    
    NSLog(@"%@",xmlDictionary);
    NSDictionary *envelope = xmlDictionary[@"SOAP-ENV:Envelope"];
    if(envelope == nil)
    {
        return nil;
    }
    NSDictionary *dictBody = envelope[@"SOAP-ENV:Body"];
    if(dictBody == nil)
    {
        return nil;
    }
    return dictBody;
//    NSString *key = [NSString stringWithFormat:@"%@Response",method_];
//    NSDictionary *result = dictBody[key];
//    return result;
}
@end
