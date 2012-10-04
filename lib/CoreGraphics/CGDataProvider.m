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
#import <CoreGraphics/CGDataProvider.h>

CFDataRef CGDataProviderCopyData(CGDataProviderRef provider)
{
}

CGDataProviderRef CGDataProviderCreateDirect(void *info, off_t size, const CGDataProviderDirectCallbacks *callbacks)
{
	CGDataProviderRef ref;
	ref.info = info;
	ref.type = CGDataProviderTypeDirect;
	ref.getBytePointer = callbacks->getBytePointer;
	ref.releaseBytePointer = callbacks->releaseBytePointer;
	ref.getBytesAtPosition = callbacks->getBytesAtPosition;
	ref.releaseInfo = callbacks->releaseInfo;
	return ref;
}

CGDataProviderRef CGDataProviderCreateSequential(void *info, const CGDataProviderSequentialCallbacks *callbacks)
{
	CGDataProviderRef ref;
	ref.info = info;
	ref.type = CGDataProviderTypeSequential;
	ref.getBytes = callbacks->getBytes;
	ref.skipForward = callbacks->skipForward;
	ref.rewind = callbacks->rewind;
	ref.releaseInfo = callbacks->releaseInfo;
	return ref;
}

CGDataProviderRef CGDataProviderCreateWithCFData(CFDataRef data)
{
	CGDataProviderRef ref;
	ref.size = CFDataGetLength(data);
	ref.data = ((void*)CFDataGetBytePtr(data));
	ref.type = CGDataProviderTypeRaw;
	return ref;
}

CGDataProviderRef CGDataProviderCreateWithData(void *info, const void *data, size_t size, CGDataProviderReleaseInfoCallback releaseData)
{
	CGDataProviderRef ref;
	ref.type = CGDataProviderTypeRaw;
	ref.info = info;
	ref.size = size;
	ref.data = ((void*)data);
	ref.releaseInfo = releaseData;
	return ref;
}

CGDataProviderRef CGDataProviderCreateWithFilename(const char *filename)
{
	CGDataProviderRef ref;
	ref.type = CGDataProviderTypeFile;
	ref.url = ((char* )filename);
	FILE *file = fopen(ref.url, "r");

	fseek(file, 0, SEEK_END);
	long size = ftell(file);
	rewind(file);	

	char* buffer = (char*) malloc(sizeof(char)*size);
	
	fread(buffer,1,size,file);
	fclose(file);
	ref.data = buffer; 
	return ref;
}

CGDataProviderRef CGDataProviderCreateWithURL(CFURLRef url)
{
	CGDataProviderRef ref;
	CFStringRef string = CFURLCopyPath(url);
	CFRange range;
	range.length = CFStringGetLength(string);
	char* buffer = malloc(range.length);
	CFStringGetCharacters(string, range, ((UniChar *)buffer));
	ref.type = CGDataProviderTypeFile;
	ref.url = buffer;
	FILE *file = fopen(ref.url, "r");
	ref.data = (void*)file;
	return ref;
}
