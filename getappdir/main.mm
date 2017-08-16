#include <objc/runtime.h>
#include <dlfcn.h>
#include <sys/stat.h>

@interface LSApplicationProxy : NSObject
@property (nonatomic,readonly) NSDictionary * groupContainerURLs; // iOS 8 - 10.2
@property (nonatomic, readonly) NSString *applicationIdentifier;
+ (id)applicationProxyForIdentifier:(id)arg1;
- (NSURL*)containerURL;
- (NSURL*)boundContainerURL;
- (NSURL*)resourcesDirectoryURL;
- (id)localizedName;
@end

@interface LSApplicationWorkspace : NSObject
+ (id)defaultWorkspace;
- (id)allInstalledApplications;
@end

int main(int argc, char* argv[], char* envp[], char* apple[])
{
	const char* pkgId = NULL;
	if ((argc > 1)) {
		pkgId = [NSString stringWithFormat:@"%s", argv[1]].UTF8String;
    }
	if(!pkgId) {
		printf("package id requerid.");
		return 1;
	}
	if(LSApplicationProxy* appNowId = [LSApplicationProxy applicationProxyForIdentifier:[NSString stringWithFormat:@"%s", pkgId]]) {
		NSURL* resourcesDirectoryURL = [appNowId resourcesDirectoryURL];
		const char* dataPath = [NSString stringWithFormat:@"%@", resourcesDirectoryURL?[resourcesDirectoryURL path]:resourcesDirectoryURL].UTF8String;
		printf("%s\n", dataPath);		
	} else {
		printf("package id not installed.");
		return 1;
	}
}