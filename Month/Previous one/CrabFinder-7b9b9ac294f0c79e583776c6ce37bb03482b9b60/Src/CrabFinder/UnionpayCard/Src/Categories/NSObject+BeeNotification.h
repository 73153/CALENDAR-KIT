//
//	 ______    ______    ______    
//	/\  __ \  /\  ___\  /\  ___\   
//	\ \  __<  \ \  __\_ \ \  __\_ 
//	 \ \_____\ \ \_____\ \ \_____\ 
//	  \/_____/  \/_____/  \/_____/ 
//
//	Copyright (c) 2012 BEE creators
//	http://www.whatsbug.com
//
//	Permission is hereby granted, free of charge, to any person obtaining a
//	copy of this software and associated documentation files (the "Software"),
//	to deal in the Software without restriction, including without limitation
//	the rights to use, copy, modify, merge, publish, distribute, sublicense,
//	and/or sell copies of the Software, and to permit persons to whom the
//	Software is furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//	IN THE SOFTWARE.
//
//
//  NSObject+BeeNotification.h
//

#pragma mark -

@interface NSNotification(BeeNotification)

- (BOOL)is:(NSString *)name;
- (BOOL)isKindOf:(NSString *)prefix;

@end

#pragma mark -

@interface NSObject(BeeNotification)

+ (NSString *)NOTIFICATION;

- (void)handleNotification:(NSNotification *)notification;  // 处理通知

- (void)observeNotification:(NSString *)name;               // 注册观察者

- (void)unobserveNotification:(NSString *)name;             // 反注册观察者

- (void)unobserveAllNotifications;                          // 反注册所有通知

- (BOOL)postNotification:(NSString *)name;                                  // 发送通知
- (BOOL)postNotification:(NSString *)name withObject:(NSObject *)object;    // 发送通知 with 对象

@end

#define OTS_NOTE_LOGIN_OK               @"OTS_NOTE_LOGIN_OK"//登陆成功
#define OTS_NOTE_LOGOUT_OK              @"OTS_NOTE_LOGOUT_OK"//退出登陆成功
#define OTS_PROVINCE_CHANGED            @"OTS_PROVINCE_CHANGED"//省份改变
#define OTS_PROVINCE_POP                @"OTS_PROVINCE_POP"//弹出省份框
#define OTS_PROVINCE_POPOVER            @"OTS_PROVINCE_POPOVER"//关闭省份框
#define OTS_SEARCH_HISTORY_CHANGED      @"OTS_SEARCH_HISTORY_CHANGED"//搜索历史改变
#define OTS_SEARCH_KEYWORD_CHANGED      @"OTS_SEARCH_KEYWORD_CHANGED"//搜索关键字改变
#define OTS_REGISTE_TO_LOGIN            @"OTS_REGISTE_TO_LOGIN"//注册成功，去自动登录
#define OTS_REACHABILITYNETSTATUS_CHANGED            @"OTS_REACHABILITYNETSTATUS_CHANGED"//2G/3G图片显示切换
#define OTS_UPDATE_SHOPPING_CART        @"OTS_UPDATE_SHOPPING_CART"//刷新购物车
#define OTS_PRODUCT_PROPERTY_CHANGE      @"OTS_PRODUCT_PROPERTY_CHANGE" //商品属性发生改变
#define OTS_UPDATE_PRODUCT_DETAIL        @"OTS_UPDATE_PRODUCT_DETAIL" //商品数据需要更新

#define OTS_ADD_NEW_ORDER               @"OTS_ADD_NEW_ORDER"//添加新订单
#define OTS_DELETE_ORDER                @"OTS_DELETE_ORDER"//处理中订单数减少
#define OTS_REFRESH_COUPON              @"OTS_REFRESH_COUPON"//刷新抵用券
#define OTS_PHONE_BIND_SUCCESS          @"OTS_PHONE_BIND_SUCCESS"//手机绑定成功
#define OTS_REFESH_MY_YHD_ACCOUNT       @"OTS_REFESH_MY_YHD_ACCOUNT"//刷新我们1号店
#define OTS_SCRATCH_SUCCESS             @"OTS_SCRATCH_SUCCESS"//刮刮卡成功刮出
#define OTS_SCRATCH_BEGIN               @"OTS_SCRATCH_BEGIN"//刮刮卡开始刮

#define OTS_ALIPAY_WALLET_TOKEN_EXPIRE  @"OTS_ALIPAY_WALLET_TOKEN_EXPIRE"//支付宝钱包token过期
#define OTS_LOGIN_FROM_ALIPAY           @"OTS_LOGIN_FROM_ALIPAY" //使用支付宝登陆
#define OTS_OVER_MOST_BUY_COUNT         @"OTS_OVER_MOST_BUY_COUNT"//超过最大购买数量
#define OTS_UNPAY_ORDER_CHANGED         @"OTS_UNPAY_ORDER_CHANGED"//未支付订单数量改变

#define OTS_PAY_SUCCESS                 @"OTS_PAY_SUCCESS"//支付成功

#define OTS_WEIXIN_SHARE_SUCCESS @"OTS_WEIXIN_SHARE_SUCCESS" //微信分享成功
#define OTS_FLASH_BUY_REMAINED          @"OTS_FLASH_BUY_REMAINED"  //闪购支付提醒
#define OTS_DEL_FLASH_BUY_REMAINED      @"OTS_DEL_FLASH_BUY_REMAINED " //删除闪购支付提醒

#define OTS_MASK_REMOVED                @"OTS_MASK_REMOVED"//mask vc移除