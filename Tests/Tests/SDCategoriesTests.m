/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 * (c) Matt Galloway
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDTestCase.h"
#import <SDWebImage/NSData+ImageContentType.h>
#if SD_UIKIT
#import <MobileCoreServices/MobileCoreServices.h>
#endif
#import <SDWebImage/UIImage+MultiFormat.h>
#import <SDWebImage/UIImage+GIF.h>
#import <SDWebImage/UIImage+WebP.h>
#import <SDWebImage/UIImage+ForceDecode.h>

@interface SDCategoriesTests : SDTestCase

@end

@implementation SDCategoriesTests

- (void)test01NSDataImageContentTypeCategory {
    // Test invalid image data
    SDImageFormat format = [NSData sd_imageFormatForImageData:nil];
    expect(format == SDImageFormatUndefined);
    
    // Test invalid format
    CFStringRef type = [NSData sd_UTTypeFromSDImageFormat:SDImageFormatUndefined];
    expect(CFStringCompare(kUTTypePNG, type, 0)).equal(kCFCompareEqualTo);
}

- (void)test02UIImageMultiFormatCategory {
    // Test invalid image data
    UIImage *image = [UIImage sd_imageWithData:nil];
    expect(image).to.beNil();
    // Test image encode
    image = [[UIImage alloc] initWithContentsOfFile:[self testJPEGPath]];
    NSData *data = [image sd_imageData];
    expect(data).notTo.beNil();
    // Test image encode PNG
    data = [image sd_imageDataAsFormat:SDImageFormatPNG];
    expect(data).notTo.beNil();
}

- (void)test03UIImageGIFCategory {
    // Test invalid image data
    UIImage *image = [UIImage sd_animatedGIFWithData:nil];
    expect(image).to.beNil();
    // Test valid image data
    NSData *data = [NSData dataWithContentsOfFile:[self testGIFPath]];
    image = [UIImage sd_animatedGIFWithData:data];
    expect(image).notTo.beNil();
}

- (void)test04UIImageWebPCategory {
    // Test invalid image data
    UIImage *image = [UIImage sd_imageWithWebPData:nil];
    expect(image).to.beNil();
    // Test valid image data
    NSData *data = [NSData dataWithContentsOfFile:[self testWebPPath]];
    image = [UIImage sd_imageWithWebPData:data];
    expect(image).notTo.beNil();
}

#pragma mark - Helper

- (NSString *)testJPEGPath {
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    return [testBundle pathForResource:@"TestImage" ofType:@"jpg"];
}

- (NSString *)testGIFPath {
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    return [testBundle pathForResource:@"TestImage" ofType:@"gif"];
}

- (NSString *)testWebPPath {
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    return [testBundle pathForResource:@"TestImageStatic" ofType:@"webp"];
}

@end
