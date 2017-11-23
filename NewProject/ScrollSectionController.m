//
//  ScrollSectionController.m
//  NewProject
//
//  Created by fan on 17/8/7.
//  Copyright © 2017年 fan. All rights reserved.
//

#import "ScrollSectionController.h"

@interface ScrollSectionController ()

@end

@implementation ScrollSectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     顶部横向标题, 下面上下滚动,  标题联动
     */
    
    
}

/*
 @interface BBYKnowledgeController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
 
 @property (nonatomic , strong) BBYKnowledgeViewModel *viewModel;
 
 @property (nonatomic , strong) UICollectionView *titleCollectionView;
 
 @property (nonatomic , strong) UICollectionView *collectionView;
 
 @property (nonatomic , strong) NSIndexPath *currentPath;
 
 @property (nonatomic , assign) BOOL isScrollDown;//collectionView的上下滑动方向
 
 @end
 
 @implementation BBYKnowledgeController
 @dynamic viewModel;
 
 static NSString * const titleIdentifier = @"title";
 static NSString * const headerIdentifier = @"headerViewIdentifier";
 static NSString * const identifier = @"item";
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 
 [self setupSubviews];
 }
 
 - (void)setupSubviews {
 //默认选择第一个
 self.currentPath = [NSIndexPath indexPathForItem:0 inSection:0];
 
 UICollectionViewFlowLayout *titleLayout = [[UICollectionViewFlowLayout alloc] init];
 titleLayout.sectionInset = UIEdgeInsetsZero;
 titleLayout.minimumLineSpacing = 0;
 titleLayout.minimumInteritemSpacing = 0;
 titleLayout.itemSize = CGSizeMake(80, 40);
 titleLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
 
 self.titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:titleLayout];
 [self.titleCollectionView registerClass:[BBYKnowledgeTitleItem class] forCellWithReuseIdentifier:titleIdentifier];
 //    [self.titleCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"unUse"];
 self.titleCollectionView.showsHorizontalScrollIndicator = NO;
 self.titleCollectionView.backgroundColor = [UIColor cyanColor];
 self.titleCollectionView.delegate = self;
 self.titleCollectionView.dataSource = self;
 [self.view addSubview:self.titleCollectionView];
 
 [self.titleCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.top.right.mas_equalTo(self.view);
 make.height.mas_equalTo(40);
 }];
 
 UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
 layout.sectionInset = UIEdgeInsetsMake(10, 30, 10, 30);
 layout.minimumLineSpacing = 30;
 layout.minimumInteritemSpacing = 30;
 layout.itemSize = CGSizeMake((SCREEN_WIDTH-90)/2, 50);
 
 self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
 [self.collectionView registerClass:[BBYChildCircleItem class] forCellWithReuseIdentifier:identifier];
 [self.collectionView registerClass:[BBYKnowledgeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
 self.collectionView.showsVerticalScrollIndicator = NO;
 self.collectionView.backgroundColor = [UIColor redColor];
 self.collectionView.delegate = self;
 self.collectionView.dataSource = self;
 [self.view addSubview:self.collectionView];
 
 [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(40, 0, 0, 0));
 }];
 }
 
 - (void)bindViewModel {
 [super bindViewModel];
 
 //    @weakify(self)
 //    [RACObserve(self.viewModel, titleArr) subscribeNext:^(id  _Nullable x) {
 //        @strongify(self)
 //        [self.collectionView reloadData];
 //    }];
 }
 
 #pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>
 
 - (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
 if (collectionView == self.titleCollectionView) {
 return 1;
 }else {
 return 10;
 }
 }
 
 - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
 if (collectionView == self.titleCollectionView) {
 return 10;
 }else {
 return arc4random()%9+1;
 }
 }
 
 - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
 if (collectionView == self.titleCollectionView) {
 BBYKnowledgeTitleItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:titleIdentifier forIndexPath:indexPath];
 NSArray *array = @[@"第1区",@"第2区",@"第3区",@"第4区",@"第5区",@"第6区",@"第7区",@"第8区",@"第9区",@"第10区"];
 item.titleLabel.text = array[indexPath.item];
 if ([indexPath modelIsEqual:@1]) {
 
 }
 item.lineView.hidden = !(indexPath.item == self.currentPath.item);
 return item;
 }else {
 BBYChildCircleItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
 NSArray *array = @[@"语文",@"数学",@"物理",@"化学",@"音乐",@"科技",@"体育",@"历史",@"政治",@"地理"];
 cell.titleLabel.text = array[indexPath.item];
 
 return cell;
 }
 }
 
 - (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
 if (collectionView == self.titleCollectionView) {
 return [UICollectionReusableView new];
 }else {
 if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
 BBYKnowledgeHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
 header.titleLabel.text = [NSString stringWithFormat:@"第--%ld--区",indexPath.section+1];
 return header;
 }
 return [UICollectionReusableView new];
 }
 }
 
 - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 if (collectionView == self.titleCollectionView) {
 NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:indexPath.item];
 [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
 
 if (self.titleCollectionView) {
 BBYKnowledgeTitleItem *item = (BBYKnowledgeTitleItem *)[collectionView cellForItemAtIndexPath:indexPath];
 CGFloat offsetX = item.center.x - self.titleCollectionView.width * 0.5;
 if (offsetX < 0) {
 offsetX = 0;
 }
 CGFloat maxOffsetX = self.titleCollectionView.contentSize.width - self.titleCollectionView.width;
 if (offsetX > maxOffsetX) {
 offsetX = maxOffsetX;
 }
 [self.titleCollectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
 
 self.currentPath = indexPath;
 [collectionView reloadData];
 }
 }else {
 BBYChildCircleItem *cell = (BBYChildCircleItem *)[collectionView cellForItemAtIndexPath:indexPath];
 NSLog(@"-------%@-------",cell.titleLabel.text);
 
 BBYKnowledgeClassViewModel *viewModel = [[BBYKnowledgeClassViewModel alloc] initWithServices:self.viewModel.services params:@{@"title":cell.titleLabel.text}];
 [self.viewModel.services pushViewModel:viewModel animated:YES];
 }
 }
 
 #pragma mark - UICollectionViewDelegateFlowLayout
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
 if (collectionView == self.titleCollectionView) {
 return CGSizeZero;
 }
 return CGSizeMake(SCREEN_WIDTH, 40);
 }
 
 //- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
 //    if (collectionView == self.titleCollectionView) {
 //        return CGSizeZero;
 //    }
 //    return CGSizeMake(SCREEN_WIDTH, 10);
 //}
 
 #pragma mark - UIScrollViewDelegate
 
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView {
 static CGFloat lastOffsetY = 0;
 if (scrollView == self.collectionView) {
 self.isScrollDown = lastOffsetY < scrollView.contentOffset.y;
 lastOffsetY = scrollView.contentOffset.y;
 }
 }
 
 - (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
 if (collectionView == self.collectionView) {
 if (!self.isScrollDown && collectionView.dragging) {
 [self scrollTitleCollectionViewWithIndexPathSection:indexPath.section];
 }
 }
 }
 
 - (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
 if (collectionView == self.collectionView) {
 if (self.isScrollDown && collectionView.dragging) {
 [self scrollTitleCollectionViewWithIndexPathSection:indexPath.section + 1];
 }
 }
 }
 
 - (void)scrollTitleCollectionViewWithIndexPathSection:(NSInteger)section {
 if (self.titleCollectionView) {
 BBYKnowledgeTitleItem *item = (BBYKnowledgeTitleItem *)[self.titleCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:section inSection:0]];
 
 CGFloat offsetX = item.center.x - self.titleCollectionView.width * 0.5;
 if (offsetX < 0) {
 offsetX = 0;
 }
 CGFloat maxOffsetX = self.titleCollectionView.contentSize.width - self.titleCollectionView.width;
 if (offsetX > maxOffsetX) {
 offsetX = maxOffsetX;
 }
 
 [self.titleCollectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
 
 self.currentPath = [NSIndexPath indexPathForItem:section inSection:0];
 [self.titleCollectionView reloadData];
 }
 }

 */


@end
