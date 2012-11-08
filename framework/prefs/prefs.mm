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
@end

// vim:ft=objc
