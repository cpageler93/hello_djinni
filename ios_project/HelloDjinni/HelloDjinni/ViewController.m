//
//  ViewController.m
//  HelloDjinni
//
//  Created by Christoph Pageler on 24.01.16.
//  Copyright © 2016 Christoph Pageler. All rights reserved.
//

#import "ViewController.h"
#import "HDHelloDjinni.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	HDHelloDjinni *helloDjinniInterface = [HDHelloDjinni create];
	NSString *helloDjinni = [helloDjinniInterface getHelloDjinni];
	NSLog(@"%@", helloDjinni);
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

@end
