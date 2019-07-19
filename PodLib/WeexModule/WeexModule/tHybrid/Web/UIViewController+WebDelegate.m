//
//  UIViewController+WebDelegate.m
//  Expecta
//
//  Created by Dao on 2018/2/11.
//

#import "UIViewController+WebDelegate.h"

#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>
#import "tHybridModulesLoader.h"

#import "NSURL+tHybrid.h"
#import <objc/runtime.h>

@implementation UIViewController (WebDelegate)

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%@", request);
    self.webInstance.webView = webView;
    //获取请去URL
    NSString *url = request.URL.absoluteString;
    url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *requestURL = [NSURL URLWithString:url];
    //是否为移动端(API)业务请求
    if (![requestURL tcmAPP]) {
        return YES;
    }
    return NO;
}


/****************************************************************/
/*                                                              */
/*                      为window.top添加方法                      */
/*                                                              */
/****************************************************************/
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self loadWebModule:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self loadWebModule:webView];
}

- (void)loadWebModule:(UIWebView *)webView{
    JSContext *context  =[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.webInstance.webView = webView;

#ifdef Debug
    context[@"console"][@"log"] = ^(JSValue * msg) {
        NSObject *Object = msg.toObject;

        if ([Object isKindOfClass:NSDictionary.class]) {
            [(NSDictionary *)Object enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key1, id  _Nonnull obj1, BOOL * _Nonnull stop) {
                if ([obj1 isKindOfClass:NSDictionary.class]) {
                    JSValue *value = [msg valueForProperty:key1];
                    [(NSDictionary *)obj1 enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key2, id  _Nonnull obj2, BOOL * _Nonnull stop) {
                        NSLog(@"H5  log : <%@:%@>", key2, [value valueForProperty:key2]);
                    }];
                } else {
                    NSLog(@"H5  log : <%@:%@>", key1, [msg valueForProperty:key1]);
                }
            }];
        } else {
            NSLog(@"H5  log : %@", Object);
        }
    };

#endif


//    context[@"console"][@"warn"] = ^(JSValue * msg) {
//
//    };
//    context[@"console"][@"error"] = ^(JSValue * msg) {
//
//    };
  
    NSObject<tHybridWebModuleProtocol> *moduleInstance = [[tHybridModulesLoaderHelper alloc] init];
    moduleInstance.webInstance = self.webInstance;

    context[@"tHybrid"] = [moduleInstance webModuleFuctionMap];
    [self.webInstance.modules setValue:moduleInstance forKey:@"tHybridModulesLoaderHelper"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
}
- (NSArray *)arrayForRequiredModules{
    return @[tHybridUniversalEventAgentModuleName];
}

static void *kwebInstance = &kwebInstance;
- (tHybridWebInstance *)webInstance{
    tHybridWebInstance *obj = objc_getAssociatedObject(self, &kwebInstance);
    if (!obj) {
        obj = [[tHybridWebInstance alloc] init];
        self.webInstance = obj;
    }
    return obj;
}
- (void)setWebInstance:(tHybridWebInstance *)webInstance{
    objc_setAssociatedObject(self, &kwebInstance, webInstance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)loadRequestURL:(NSString *)url web:(UIWebView *)web{
    self.webInstance.webView = web;
    web.delegate = self;
    NSURLRequest *requestUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [web loadRequest:requestUrl];
}
@end



