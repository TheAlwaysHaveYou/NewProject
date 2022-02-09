//
//  ToolListView.m
//  NewProject
//
//  Created by 范魁东 on 2022/2/9.
//  Copyright © 2022 fan. All rights reserved.
//

#import "ToolListView.h"
#import "ToolFooterView.h"
#import "ToolListItem.h"
#import "ToolListViewModel.h"
#import "ToolFooterViewModel.h"
#import "ToolListItemViewModel.h"

@interface ToolListView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) UICollectionView *list;
@property (nonatomic , strong) ToolListViewModel *vm;
@end

@implementation ToolListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        ToolListViewModel *vm = [[ToolListViewModel alloc] initWithModel:[NSObject new]];
        self.vm = vm;
        
        [self.list reloadData];
    }
    return self;
}

- (UICollectionView *)list {
    if (!_list) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _list = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _list.delegate = self;
        _list.dataSource = self;
    }
    return _list;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.vm.itemCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ToolListItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:ToolListItemViewModel.identifier forIndexPath:indexPath];
    [item updateUI:[self.vm itemAtIndexPath:indexPath]];
    return item;
}

@end
