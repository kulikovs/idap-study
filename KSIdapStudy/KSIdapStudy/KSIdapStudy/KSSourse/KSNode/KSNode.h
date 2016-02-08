//
//  KSNode.h
//  KSIdapStudy
//
//  Created by KulikovS on 06.02.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#ifndef KSNode_h
#define KSNode_h

#include <stdio.h>

#include "KSObject.h"

typedef struct KSNode KSNode;

struct KSNode {
    KSObject _super;
    KSNode *_nextNode;
    void *_object;
};

extern
void *KSNodeCreateWithObject(void *object);

extern
void KSNodeSetObject(KSNode *node, void *object);

extern
void *KSNodeGetObject(KSNode *node);

extern
void KSNodeSetNextNode(KSNode *node, KSNode *nextNode);

extern
void *KSNodeGetNextNode(KSNode *node);

#endif /* KSNode_h */
