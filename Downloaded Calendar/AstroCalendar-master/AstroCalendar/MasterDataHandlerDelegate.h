//
//  MasterDataHandlerDelegate.h
//  AstroCalendar
//
//  Created by Paul Moore on 11-11-09.
//  University of British Columbia.
//  https://github.com/paulmoore/AstroCalendar
/*
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */

#import <Foundation/Foundation.h>

/**
 * Delegate protocol for the MasterDataHandler.
 * Reciever for any data that was requested from the MasterDataHandler.
 */
@protocol MasterDataHandlerDelegate <NSObject>

@required

/**
 * Invoked when the MasterDataHandler has data ready for the reciever.
 *
 * @param data An array of DayContainer objects.
 */
- (void)didRecieveData:(NSArray *)data;

@end
