//
//	XLEPageModel.h
//
//	Create by Randy on 5/12/2015

#import "XLEModel.h"
@interface XLEPageModel : XLEModel

@property (assign, nonatomic) NSInteger count;//总数
@property (assign, nonatomic) NSInteger curPageCount;//当前页数量
@property (assign, nonatomic) NSInteger pageNum;//页号
@property (assign, nonatomic) NSInteger pageSize;//每页显示数量
@property (assign, nonatomic) NSInteger totalPageNum;//总页数

@property (assign, nonatomic) BOOL hasMore;//下页还有数据

@end