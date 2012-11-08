#import <Preferences/PSListController.h>

@interface GRPreferencesListController: PSListController {
}
@end

@implementation GRPreferencesListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"GRPreferences" target:self] retain];
	}
	return _specifiers;
}

- (void)openVendorTwitter:(id)sender
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/CocoaNutApps"]];
}

- (void)openPersonalTwitter:(id)sender
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/yfrancis"]];
}

@end

// vim:ft=objc
