//
//  CustomView.m
//
//  Code generated using QuartzCode 1.63.0 on 2017/12/6.
//  www.quartzcodeapp.com
//

#import "CustomView.h"
#import "QCMethod.h"

@interface CustomView ()

@property (nonatomic, strong) NSMutableDictionary * layers;
@property (nonatomic, strong) NSMapTable * completionBlocks;
@property (nonatomic, assign) BOOL  updateLayerValueForCompletedAnimation;


@end

@implementation CustomView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setupProperties];
		[self setupLayers];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		[self setupProperties];
		[self setupLayers];
	}
	return self;
}



- (void)setupProperties{
	self.completionBlocks = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsOpaqueMemory valueOptions:NSPointerFunctionsStrongMemory];;
	self.layers = [NSMutableDictionary dictionary];
	
}

- (void)setupLayers{
	self.backgroundColor = [UIColor colorWithRed:1 green: 1 blue:1 alpha:1];
	
	CAShapeLayer * star = [CAShapeLayer layer];
	star.frame = CGRectMake(195.48, 200.47, 104, 99);
	star.path = [self starPath].CGPath;
	[self.layer addSublayer:star];
	self.layers[@"star"] = star;
	
	[self resetLayerPropertiesForLayerIdentifiers:nil];
}

- (void)resetLayerPropertiesForLayerIdentifiers:(NSArray *)layerIds{
	[CATransaction begin];
	[CATransaction setDisableActions:YES];
	
	if(!layerIds || [layerIds containsObject:@"star"]){
		CAShapeLayer * star = self.layers[@"star"];
		star.fillColor   = [UIColor colorWithRed:1 green: 0.149 blue:0 alpha:1].CGColor;
		star.strokeColor = [UIColor colorWithRed:1 green: 0.149 blue:0 alpha:1].CGColor;
	}
	
	[CATransaction commit];
}

#pragma mark - Animation Setup

- (void)addUntitled1Animation{
	[self addUntitled1AnimationCompletionBlock:nil];
}

- (void)addUntitled1AnimationCompletionBlock:(void (^)(BOOL finished))completionBlock{
	if (completionBlock){
		CABasicAnimation * completionAnim = [CABasicAnimation animationWithKeyPath:@"completionAnim"];;
		completionAnim.duration = 1.63;
		completionAnim.delegate = self;
		[completionAnim setValue:@"Untitled1" forKey:@"animId"];
		[completionAnim setValue:@(NO) forKey:@"needEndAnim"];
		[self.layer addAnimation:completionAnim forKey:@"Untitled1"];
		[self.completionBlocks setObject:completionBlock forKey:[self.layer animationForKey:@"Untitled1"]];
	}
	
	NSString * fillMode = kCAFillModeForwards;
	
	////Star animation
	CAKeyframeAnimation * starPositionAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	starPositionAnim.values                = @[[NSValue valueWithCGPoint:CGPointMake(247.482, 249.975)], [NSValue valueWithCGPoint:CGPointMake(71, 73.5)]];
	starPositionAnim.keyTimes              = @[@0, @1];
	starPositionAnim.duration              = 1.63;
	
	CAKeyframeAnimation * starShadowOpacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"shadowOpacity"];
	starShadowOpacityAnim.values   = @[@0.335, @0.33];
	starShadowOpacityAnim.duration = 1.63;
	CAKeyframeAnimation * starShadowOffsetAnim = [CAKeyframeAnimation animationWithKeyPath:@"shadowOffset"];
	starShadowOffsetAnim.values    = @[[NSValue valueWithCGSize:CGSizeMake(0, 30)], 
		[NSValue valueWithCGSize:CGSizeMake(30, 3)]];
	starShadowOffsetAnim.duration  = 1.63;
	
	CAKeyframeAnimation * starFillColorAnim = [CAKeyframeAnimation animationWithKeyPath:@"fillColor"];
	starFillColorAnim.values   = @[(id)[UIColor colorWithRed:0.999 green: 0.986 blue:0 alpha:1].CGColor, 
		 (id)[UIColor colorWithRed:1 green: 0.149 blue:0 alpha:1].CGColor];
	starFillColorAnim.keyTimes = @[@0, @1];
	starFillColorAnim.duration = 1.63;
	
	CAKeyframeAnimation * starTransformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
	starTransformAnim.values   = @[@(0), 
		 @(-100 * M_PI/180)];
	starTransformAnim.keyTimes = @[@0, @1];
	starTransformAnim.duration = 1.63;
	
	CAKeyframeAnimation * starPathAnim = [CAKeyframeAnimation animationWithKeyPath:@"path"];
	starPathAnim.values                = @[(id)[QCMethod alignToBottomPath:[self starPath] layer:self.layers[@"star"]].CGPath, (id)[QCMethod alignToBottomPath:[self starPath] layer:self.layers[@"star"]].CGPath];
	starPathAnim.keyTimes              = @[@0, @1];
	starPathAnim.duration              = 1.63;
	
	CAAnimationGroup * starUntitled1Anim = [QCMethod groupAnimations:@[starPositionAnim, starShadowOpacityAnim, starShadowOffsetAnim, starFillColorAnim, starTransformAnim, starPathAnim] fillMode:fillMode];
	[self.layers[@"star"] addAnimation:starUntitled1Anim forKey:@"starUntitled1Anim"];
}

#pragma mark - Animation Cleanup

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
	void (^completionBlock)(BOOL) = [self.completionBlocks objectForKey:anim];;
	if (completionBlock){
		[self.completionBlocks removeObjectForKey:anim];
		if ((flag && self.updateLayerValueForCompletedAnimation) || [[anim valueForKey:@"needEndAnim"] boolValue]){
			[self updateLayerValuesForAnimationId:[anim valueForKey:@"animId"]];
			[self removeAnimationsForAnimationId:[anim valueForKey:@"animId"]];
		}
		completionBlock(flag);
	}
}

- (void)updateLayerValuesForAnimationId:(NSString *)identifier{
	if([identifier isEqualToString:@"Untitled1"]){
		[QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"star"] animationForKey:@"starUntitled1Anim"] theLayer:self.layers[@"star"]];
	}
}

- (void)removeAnimationsForAnimationId:(NSString *)identifier{
	if([identifier isEqualToString:@"Untitled1"]){
		[self.layers[@"star"] removeAnimationForKey:@"starUntitled1Anim"];
	}
}

- (void)removeAllAnimations{
	[self.layers enumerateKeysAndObjectsUsingBlock:^(id key, CALayer *layer, BOOL *stop) {
		[layer removeAllAnimations];
	}];
}

#pragma mark - Bezier Path

- (UIBezierPath*)starPath{
	UIBezierPath *starPath = [UIBezierPath bezierPath];
	[starPath moveToPoint:CGPointMake(30.453, 24.605)];
	[starPath addCurveToPoint:CGPointMake(17.286, 64.61) controlPoint1:CGPointMake(6.633, 28.021) controlPoint2:CGPointMake(-17.187, 31.438)];
	[starPath addCurveToPoint:CGPointMake(51.759, 89.336) controlPoint1:CGPointMake(13.217, 88.03) controlPoint2:CGPointMake(9.148, 111.45)];
	[starPath addCurveToPoint:CGPointMake(86.231, 64.61) controlPoint1:CGPointMake(73.064, 100.393) controlPoint2:CGPointMake(94.369, 111.45)];
	[starPath addCurveToPoint:CGPointMake(73.064, 24.605) controlPoint1:CGPointMake(103.468, 48.024) controlPoint2:CGPointMake(120.704, 31.438)];
	[starPath addCurveToPoint:CGPointMake(30.453, 24.605) controlPoint1:CGPointMake(62.411, 3.296) controlPoint2:CGPointMake(51.759, -18.012)];
	[starPath closePath];
	[starPath moveToPoint:CGPointMake(30.453, 24.605)];
	
	return starPath;
}


@end
