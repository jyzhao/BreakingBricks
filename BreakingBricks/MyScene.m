//
//  MyScene.m
//  BreakingBricks
//
//  Created by 赵骥远 on 14-4-16.
//  Copyright (c) 2014年 Jiyuan Zhao. All rights reserved.
//

#import "MyScene.h"

@interface MyScene ()

@property (nonatomic) SKSpriteNode *paddle;

@end

@implementation MyScene

- (void)addBall:(CGSize)size {
	SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
	[self addChild:ball];
	
	CGPoint ballPoint = CGPointMake(size.width/2, size.height/2);
	ball.position = ballPoint;
	
	ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.frame.size.width/2];
	
	ball.physicsBody.linearDamping = 0;
	ball.physicsBody.friction = 0;
	ball.physicsBody.restitution = 1;
	
	
	CGVector myVector = CGVectorMake(5, 5);
	
	[ball.physicsBody applyImpulse:myVector];
}

-(void)addPlayer:(CGSize)size {
	
	self.paddle = [SKSpriteNode spriteNodeWithImageNamed:@"paddle"];
	self.paddle.position = CGPointMake(size.width/2, self.paddle.frame.size.height/2);
	self.paddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.paddle.frame.size];
	self.paddle.physicsBody.dynamic = NO;
	
	[self addChild:self.paddle];
	
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	
	for (UITouch *touch in touches) {
		CGPoint location = [touch locationInNode:self];
		CGPoint newPosition = CGPointMake(location.x, self.paddle.frame.size.height/2);
		
		newPosition.x = (newPosition.x < self.paddle.frame.size.width/2) ? self.paddle.frame.size.width/2 : newPosition.x;
		newPosition.x = (newPosition.x > 320 - self.paddle.frame.size.width/2) ? 320 - self.paddle.frame.size.width/2 : newPosition.x;
		
		self.paddle.position = newPosition;
		
	}
	
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
		self.backgroundColor = [SKColor whiteColor];
		
		self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
		self.physicsWorld.gravity = CGVectorMake(0, 0);
		
		
		[self addBall:size];
		[self addPlayer:size];
		
		
		
    }
    return self;
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
