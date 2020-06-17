#import <Cephei/HBPreferences.h>
HBPreferences *preferences;
BOOL enabled;

@interface SBBacklightController
@property (nonatomic,retain) UIView *attention; //makes UIView a property
-(void)attentionShowBlur;
@end

@interface SBIdleTimerPolicyAggregator : NSObject
-(void)idleTimerDidWarn:(id)arg1;
@end

%hook SBBacklightController
%property (nonatomic,retain) UIView *attention;

%new
-(void)attentionShowBlur { 

//blur view      
    self.attention = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds]; //creates a UIView with the size of the screen
    [[UIApplication sharedApplication].keyWindow addSubview:self.attention];

//blur effect
    UIVisualEffect *blurEffect; 
    if (@available(iOS 13, *)) { //check if the device is iOS 13+ becayse UIBlurEffectStyleSystemUltraThinMaterial is only available on iOS13+
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterial];
    } else { //will probably need to change this once iOS 14 is jailbroken 
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]; // any other iOS version gets a light blur :D
    }
    UIVisualEffectView *Blur;
    Blur = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
   Blur.frame = self.attention.bounds; 
    [self.attention addSubview:Blur]; //adds blur effect into the scene with the same size of the UIView created above

//blur animation
   self.attention.alpha = 0.00; //start at an alpha of 0.0
    [UIView animateWithDuration:1.0f animations:^{ //animation time
        self.attention.alpha = 1.00; //end with an alpha of 0.0
    } completion:nil];
}

//if a user does any action on the phone which shows activity, this removes the blur
-(void)_undimFromSource:(long long)arg1 { 
     %orig; 
     [UIView animateWithDuration:0.25f animations:^{  //same thing as before, except it removes the blur with an animation
        [self.attention setAlpha:0.0f];
    } completion:^(BOOL finished) {
        self.attention = nil;
    }];
}

-(id)init { //using notifications bc its easy 
    if ((self = %orig)) {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(attentionShowBlur) name:@"com.woofy.attention/showBlur" object:nil];
    }
    return self;
}

%end

%hook SBIdleTimerPolicyAggregator
-(void)idleTimerDidWarn:(id)arg1 { //actually makes the tweak work. using notification method to show blur
if (enabled) {
[NSNotificationCenter.defaultCenter postNotificationName:@"com.woofy.attention/showBlur" object:nil]; 
}
    %orig; //removing the original code breaks a lot... so we're keeping it for now
}
%end

//preferences
#pragma mark - Constructor
%ctor {
preferences = [[HBPreferences alloc] initWithIdentifier:@"com.woofy.attentionprefs"]; 
[preferences registerBool:&enabled default:YES forKey:@"enabled"];
%init;
}