//
//  UIView+Hierarchy.m
//  Silverback
//
//  Created by Christian Otkjær on 11/1/13.
//  Copyright (c) 2013 Silverback IT. All rights reserved.
//

#import "UIView+Hierarchy.h"

@implementation UIView (Hierarchy)

- (BOOL)containsSubview:(UIView *)subView
{
    BOOL containsSubview = NO;
    
    if (subView)
    {
        if ([self isEqual:subView])
        {
            containsSubview = YES;
        }
        else
        {
            for (UIView * view in self.subviews)
            {
                if ([view containsSubview:subView])
                {
                    containsSubview = YES;
                    break;
                }
            }
        }
    }
    
    return containsSubview;
}

- (UIView *)closestSuperViewOfType:(Class)type
{
    UIView * view = self;
    
    if (![view isKindOfClass:type])
    {
        view = [self.superview closestSuperViewOfType:type];
    }
    
    return view;
}

- (void)enumerateSuperViewHierarchyUsingBlock:(void (^)(UIView *, NSUInteger, BOOL *))block
{
    NSMutableArray * superViews = [NSMutableArray new];
    
    UIView * view = self.superview;
    
    while (view != nil)
    {
        [superViews addObject:view];
        view = view.superview;
    }
    
    [superViews enumerateObjectsUsingBlock:block];
}

- (void)enumerateSubViewsUsingBlock:(void (^)(UIView *, NSUInteger, BOOL *))block
{
    [self.subviews enumerateObjectsUsingBlock:block];
}

- (void)enumerateSubViewHierarchyBreadthFirstUsingBlock:(void (^)(UIView *, BOOL *))block
{
    NSMutableArray * queue = [[NSMutableArray alloc] initWithArray:self.subviews];

    BOOL stop = NO;
    
    for (NSUInteger index = 0; index < [queue count]; index ++)
    {
        UIView * view = queue[index];
        
        block(view, &stop);

        if (stop)
        {
            break;
        }
        
        [queue addObjectsFromArray:view.subviews];
    }
}


- (void)enumerateSubViewHierarchyDepthFirstUsingBlock:(void (^)(UIView *, BOOL *))block
{
    [self enumerateSubViewsUsingBlock:^(UIView * subView, NSUInteger index, BOOL *stopSubViews)
    {
        block(subView, stopSubViews);
        
        if (!*stopSubViews)
        {
            [subView enumerateSubViewHierarchyDepthFirstUsingBlock:^(UIView * subView, BOOL *stopSubViewHierarchy)
            {
                block(subView, stopSubViewHierarchy);
                
                if (*stopSubViewHierarchy)
                {
                    *stopSubViews = YES;
                }
            }];
        }
    }];
}


- (UIView *)closestSubViewOfType:(Class)type
{
    __block UIView * view = nil;
    
    [self enumerateSubViewHierarchyBreadthFirstUsingBlock:^(UIView * subView, BOOL *stopSubViewHierarchy)
    {
        if ([subView isKindOfClass:type])
        {
            view = subView;
            *stopSubViewHierarchy = YES;
        }
    }];
    
    return view;
    
    /*
     1  procedure BFS(G,v) is
     2      create a queue Q
     3      create a set V
     4      add v to V
     5      enqueue v onto Q
     6      while Q is not empty loop
     7         t ← Q.dequeue()
     8         if t is what we are looking for then
     9            return t
     10        end if
     11        for all edges e in G.adjacentEdges(t) loop
     12           u ← G.adjacentVertex(t,e)
     13           if u is not in V then
     14               add u to V
     15               enqueue u onto Q
     16           end if
     17        end loop
     18     end loop
     19     return none
     20 end BFS
     */
//    
//    UIView * view = nil;
//    
//    NSMutableArray * queue = [NSMutableArray new];
//    //    NSMutableSet * set = [NSMutableSet new];
//    
//    //    [set addObject:self];
//    [queue addObject:self];
//    
//    while ([queue count] > 0)
//    {
//        UIView * viewToTest = [queue firstObject]; [queue removeObjectAtIndex:0];
//        
//        if ([viewToTest isKindOfClass:type])
//        {
//            return viewToTest;
//        }
//        
//        [viewToTest.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
//         {
//             //            if (![set containsObject:obj])
//             //            {
//             //                [set addObject:obj];
//             [queue addObject:obj];
//             //            }
//         }];
//    }
//    
//    return view;
}


@end
