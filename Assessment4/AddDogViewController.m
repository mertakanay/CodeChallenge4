//
//  AddDogViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"
#import "Dog.h"

@interface AddDogViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;


@end

@implementation AddDogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.dog == nil) {
        self.title = @"Add Dog";
    }else{
        self.title = @"Edit Dog";

        [self loadDogStrings];

    }
}

-(void)loadDogStrings
{
    self.nameTextField.text = self.dog.name;
    self.breedTextField.text = self.dog.breed;
    self.colorTextField.text = self.dog.color;
}

- (IBAction)onPressedUpdateDog:(UIButton *)sender
{
    if (self.dog == nil)
    {
        Dog *newDog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:self.context];
        newDog.name = self.nameTextField.text;
        newDog.breed = self.breedTextField.text;
        newDog.color = self.colorTextField.text;
        [self.owner addDogsObject:newDog];
        [self.context save:nil];
    }
    else
    {
        self.dog.name = self.nameTextField.text;
        self.dog.breed = self.breedTextField.text;
        self.dog.color = self.colorTextField.text;
        [self.context save:nil];
    }


    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
