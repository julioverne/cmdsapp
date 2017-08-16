#include <objc/runtime.h>
#include <dlfcn.h>
#include <sys/stat.h>

@interface LSApplicationProxy : NSObject
@property (nonatomic,readonly) NSDictionary * groupContainerURLs; // iOS 8 - 10.2
@property (nonatomic, readonly) NSString *applicationIdentifier;
+ (id)applicationProxyForIdentifier:(id)arg1;
- (NSURL*)containerURL;
- (NSURL*)boundContainerURL;
- (id)localizedName;
@end

@interface LSApplicationWorkspace : NSObject
+ (id)defaultWorkspace;
- (id)allInstalledApplications;
@end

int main(int argc, char* argv[], char* envp[], char* apple[])
{
	BOOL onlyID = NO;
	if ((argc > 1)) {
        if (strcmp(argv[1], "-id") == 0) {
			onlyID = YES;
        }
    }
	LSApplicationWorkspace* lsWk = [LSApplicationWorkspace defaultWorkspace];
	for(LSApplicationProxy* appNow in [lsWk allInstalledApplications]) {
		const char* appId = [NSString stringWithFormat:@"%@", appNow.applicationIdentifier].UTF8String;
		if(onlyID) {
			printf("%s\n", appId);
		} else {
			const char* appName = [NSString stringWithFormat:@"%@", [appNow localizedName]].UTF8String;
			printf("%s: %s\n", appId, appName);
		}	
	}
}