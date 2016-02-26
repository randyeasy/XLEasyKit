//
//  XLEBrowserView.m
//  Pods
//
//  Created by Randy on 16/1/26.
//
//

#import "XLEBrowserView.h"

@interface XLEBrowserView ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *srollView;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation XLEBrowserView

- (void)setupUI;
{
    self.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    singleTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)updateBrowserImage:(UIImage *)image;
{
    self.srollView.maximumZoomScale = 1;
    self.srollView.minimumZoomScale = 1;
    self.srollView.zoomScale = 1;
    
    self.imageView.image = image;
    CGRect imageViewFrame;
    imageViewFrame.origin = CGPointZero;
    imageViewFrame.size = image.size;
    self.imageView.frame = imageViewFrame;
    self.srollView.contentSize = imageViewFrame.size;
    // Set zoom to minimum zoom
    [self setMaxMinZoomScalesForCurrentBounds];
    [self setNeedsLayout];
}

#pragma mark - action
- (void)doubleTapAction:(UITapGestureRecognizer *)get
{
    CGPoint touchPoint = [get locationInView:self];
    // Zoom
    if (self.srollView.zoomScale != self.srollView.minimumZoomScale && self.srollView.zoomScale != [self initialZoomScaleWithMinScale]) {
        
        // Zoom out
        [self.srollView setZoomScale:self.srollView.minimumZoomScale animated:YES];
        
    } else {
        
        // Zoom in to twice the size
        //TODO 在点击区域放大
        CGFloat newZoomScale = ((self.srollView.maximumZoomScale + self.srollView.minimumZoomScale) / 2);
        CGFloat xsize = self.srollView.bounds.size.width / newZoomScale;
        CGFloat ysize = self.srollView.bounds.size.height / newZoomScale;
        [self.srollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
        
    }
}

- (void)singleTapAction:(UITapGestureRecognizer *)get
{
    if (self.singleTap) {
        self.singleTap(self);
    }
}

#pragma mark - zoom
- (CGFloat)initialZoomScaleWithMinScale {
    CGFloat zoomScale = self.srollView.minimumZoomScale;
    // Zoom image to fill if the aspect ratios are fairly similar
    CGSize boundsSize = self.srollView.bounds.size;
    CGSize imageSize = self.imageView.image.size;
    CGFloat boundsAR = boundsSize.width / boundsSize.height;
    CGFloat imageAR = imageSize.width / imageSize.height;
    CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
    // Zooms standard portrait images on a 3.5in screen but not on a 4in screen.
    if (ABS(boundsAR - imageAR) < 0.17) {
        zoomScale = MIN(xScale, yScale);
        // Ensure we don't zoom in or out too far, just in case
        zoomScale = MIN(MAX(self.srollView.minimumZoomScale, zoomScale), self.srollView.maximumZoomScale);
    }
    return zoomScale;
}

- (void)setMaxMinZoomScalesForCurrentBounds {
    // Reset
    self.srollView.maximumZoomScale = 1;
    self.srollView.minimumZoomScale = 1;
    self.srollView.zoomScale = 1;
    
    // Bail if no image
    if (_imageView.image == nil) return;
    
    // Reset position
    _imageView.frame = CGRectMake(0, 0, _imageView.frame.size.width, _imageView.frame.size.height);
    
    // Sizes
    CGSize boundsSize = self.srollView.bounds.size;
    CGSize imageSize = _imageView.image.size;
    
    // Calculate Min
    CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
    CGFloat minScale = MIN(xScale, yScale);                 // use minimum of these to allow the image to become fully visible
    
    // Calculate Max
    CGFloat maxScale = 1.5;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // Let them go a bit bigger on a bigger screen!
        maxScale = 4;
    }
    
    // Image is smaller than screen so no zooming!
    if (xScale >= 1 && yScale >= 1) {
        minScale = 1.0;
    }
    
    // Set min/max zoom
    self.srollView.maximumZoomScale = maxScale;
    self.srollView.minimumZoomScale = minScale;
    
    // Initial zoom
    self.srollView.zoomScale = [self initialZoomScaleWithMinScale];
    
    // If we're zooming to fill then centralise
    if (self.srollView.zoomScale != minScale) {
        // Centralise
        self.srollView.contentOffset = CGPointMake((imageSize.width * self.srollView.zoomScale - boundsSize.width) / 2.0,
                                                           (imageSize.height * self.srollView.zoomScale - boundsSize.height) / 2.0);
        // Disable scrolling initially until the first pinch to fix issues with swiping on an initally zoomed in photo
        self.srollView.scrollEnabled = NO;
    }
    
    // Layout
    [self setNeedsLayout];
    
}

#pragma mark - Layout

- (void)layoutSubviews {
    // Super
    [super layoutSubviews];
    
    // Center the image as it becomes smaller than the size of the screen
    CGSize boundsSize = self.srollView.bounds.size;
    CGRect frameToCenter = self.imageView.frame;
    
    // Horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
    } else {
        frameToCenter.origin.x = 0;
    }
    
    // Vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floorf((boundsSize.height - frameToCenter.size.height) / 2.0);
    } else {
        frameToCenter.origin.y = 0;
    }
    
    // Center
    if (!CGRectEqualToRect(self.imageView.frame, frameToCenter))
        self.imageView.frame = frameToCenter;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    self.srollView.scrollEnabled = YES; // reset
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - set get
- (UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor = [UIColor blackColor];
        [self.srollView addSubview:_imageView];
    }
    return _imageView;
}

- (UIScrollView *)srollView
{
    if (nil == _srollView) {
        _srollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _srollView.delegate = self;
        _srollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _srollView.showsHorizontalScrollIndicator = NO;
        _srollView.showsVerticalScrollIndicator = NO;
        _srollView.decelerationRate = UIScrollViewDecelerationRateFast;
        [self addSubview:_srollView];
    }
    return _srollView;
}

@end
