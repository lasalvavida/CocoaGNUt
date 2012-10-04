/*CocoaGNUt, an open-source implementation of iPhone's UIKit and CoreGraphics
    Copyright (C) 2012  Rob Taglang

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
#import <CoreFoundation/CFData.h>
#import <CoreFoundation/CFURL.h>
#import <stdlib.h>
#import <stdio.h>

enum CGDataProviderType
{
	CGDataProviderTypeDirect,
	CGDataProviderTypeSequential,
	CGDataProviderTypeFile,
	CGDataProviderTypeRaw
};
typedef enum CGDataProviderType CGDataProviderType;

typedef void (*CGDataProviderReleaseInfoCallback)(void* info);

typedef const void* (*CGDataProviderGetBytePointerCallback)(void* info);
typedef void (*CGDataProviderReleaseBytePointerCallback)(void* info, const void* pointer);
typedef size_t (*CGDataProviderGetBytesAtPositionCallback)(void* info, void* buffer, off_t position, size_t count);

struct CGDataProviderDirectCallbacks
{
	unsigned int version;
	CGDataProviderGetBytePointerCallback getBytePointer;
	CGDataProviderReleaseBytePointerCallback releaseBytePointer;
	CGDataProviderGetBytesAtPositionCallback getBytesAtPosition;
	CGDataProviderReleaseInfoCallback releaseInfo;
};
typedef struct CGDataProviderDirectCallbacks CGDataProviderDirectCallbacks;

typedef size_t (*CGDataProviderGetBytesCallback)(void *info, void *buffer, size_t count);
typedef off_t (*CGDataProviderSkipForwardCallback)(void *info, off_t count);
typedef void (*CGDataProviderRewindCallback)(void *info);

struct CGDataProviderSequentialCallbacks
{
	unsigned int version;
	CGDataProviderGetBytesCallback getBytes;
	CGDataProviderSkipForwardCallback skipForward;
	CGDataProviderRewindCallback rewind;
	CGDataProviderReleaseInfoCallback releaseInfo;
};
typedef struct CGDataProviderSequentialCallbacks CGDataProviderSequentialCallbacks;

struct CGDataProviderRef
{
	void *info;
	void *data;
	size_t size;
	char *url;
	CGDataProviderType type;

	CGDataProviderGetBytePointerCallback getBytePointer;
	CGDataProviderReleaseBytePointerCallback releaseBytePointer;
	CGDataProviderGetBytesAtPositionCallback getBytesAtPosition;

	CGDataProviderGetBytesCallback getBytes;
	CGDataProviderSkipForwardCallback skipForward;
	CGDataProviderRewindCallback rewind;

	CGDataProviderReleaseInfoCallback releaseInfo;
};
typedef struct CGDataProviderRef CGDataProviderRef;

CFDataRef CGDataProviderCopyData(CGDataProviderRef provider);

CGDataProviderRef CGDataProviderCreateDirect(void *info, off_t size, const CGDataProviderDirectCallbacks *callbacks);

CGDataProviderRef CGDataProviderCreateSequential(void *info, const CGDataProviderSequentialCallbacks *callbacks);

CGDataProviderRef CGDataProviderCreateWithCFData(CFDataRef data);

CGDataProviderRef CGDataProviderCreateWithData(void *info, const void *data, size_t size, CGDataProviderReleaseInfoCallback releaseData);

CGDataProviderRef CGDataProviderCreateWithFilename(const char *filename);

CGDataProviderRef CGDataProviderCreateWithURL(CFURLRef url);

