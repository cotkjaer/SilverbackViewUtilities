//
//  UIView+Hierarchy.h
//  Silverback
//
//  Created by Christian Otkjær on 11/1/13.
//  Copyright (c) 2013 Silverback IT. All rights reserved.
//

@import UIKit;

@interface UIView (Hierarchy)

- (BOOL)containsSubview:(UIView *)subView;

- (UIView *)closestSuperViewOfType:(Class)type;

- (UIView *)closestSubViewOfType:(Class)type;

- (void)enumerateSuperViewHierarchyUsingBlock:(void (^)(UIView * superView, NSUInteger distance, BOOL *stop))block;

- (void)enumerateSubViewHierarchyBreadthFirstUsingBlock:(void (^)(UIView * subView, BOOL *stopSubViewHierarchy))block;

- (void)enumerateSubViewHierarchyDepthFirstUsingBlock:(void (^)(UIView * subView, BOOL *stopSubViewHierarchy))block;

- (void)enumerateSubViewsUsingBlock:(void (^)(UIView * subView, NSUInteger index, BOOL *stopSubViews))block;



@end
