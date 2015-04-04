//
//  DogsViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "AddDogViewController.h"

@interface DogsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dogsTableView;
@property NSMutableArray *dogs;

@end

@implementation DogsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dogs";

    [self loadDogs];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self loadDogs];
}

- (void)loadDogs;
{
    self.dogs = [[self.owner.dogs allObjects]mutableCopy];
    [self.dogsTableView reloadData];
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dogs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"dogCell"];
    cell.textLabel.text = [self.dogs[indexPath.row] name];
    Dog *aDog = self.dogs[indexPath.row];
    NSString *dogBreed = aDog.breed;
    NSString *dogColor = aDog.color;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Breed: %@ Color: %@", dogBreed, dogColor];

    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSManagedObject *deletedObject = [self.dogs objectAtIndex:indexPath.row];
        [self.context deleteObject:deletedObject];
        [self.dogs removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        [self.context save:nil];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"AddDogSegue"])
    {
        AddDogViewController *addDogVC = [segue destinationViewController];
        addDogVC.owner = self.owner;
        addDogVC.context = self.context;
    }
    else
    {
        AddDogViewController *addDogVC = [segue destinationViewController];
        NSIndexPath *indexPath = [self.dogsTableView indexPathForSelectedRow];
        addDogVC.dog = self.dogs[indexPath.row];
        addDogVC.context = self.context;
    }
}

@end
