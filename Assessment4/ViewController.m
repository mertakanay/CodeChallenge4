//
//  ViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "DogOwnerDownloader.h"
#import "Owner.h"
#import "AppDelegate.h"
#import "DogsViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;
@property NSManagedObjectContext *context;
@property NSArray *owners;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dog Owners";

    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    self.context = appdelegate.managedObjectContext;

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if (![userDefaults objectForKey:@"hasSavedOwnerList"])
    {
        [DogOwnerDownloader downloadReaders:^(NSArray *array) {
            NSMutableArray *newOwners = [NSMutableArray new];
            for (NSString *name in array)
            {
                Owner *owner = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Owner class]) inManagedObjectContext:self.context];
                owner.name = name;
                [newOwners addObject:owner];
            }

            self.owners = newOwners;
            [self.context save:nil];
            [userDefaults setObject:@YES forKey:@"hasSavedOwnerList"];
            [userDefaults synchronize];
            [self.myTableView reloadData];
        }];
    }else{
        [self loadOwners];
    }
}

-(void)loadOwners
{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Owner"];
    self.owners = [self.context executeFetchRequest:request error:nil];
    NSData *theData = [[NSUserDefaults standardUserDefaults] objectForKey:@"myColor"];
    UIColor *theColor = (UIColor *)[NSKeyedUnarchiver unarchiveObjectWithData:theData];
    self.navigationController.navigationBar.tintColor = theColor;
    [self.myTableView reloadData];
    [self.navigationController reloadInputViews];
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.owners.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"myCell"];
    cell.textLabel.text = [self.owners[indexPath.row] name];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DogsViewController *dogsVC = [segue destinationViewController];
    NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
    dogsVC.owner = self.owners[indexPath.row];
    dogsVC.context = self.context;
}

#pragma mark - UIAlertView Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //TODO: SAVE USER'S DEFAULT COLOR PREFERENCE USING THE CONDITIONAL BELOW

    if (buttonIndex == 0)
    {
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
        NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor purpleColor]];
        [[NSUserDefaults standardUserDefaults] setObject:theData forKey:@"myColor"];
        [self.context save:nil];

    }
    else if (buttonIndex == 1)
    {
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
        NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor blueColor]];
        [[NSUserDefaults standardUserDefaults] setObject:theData forKey:@"myColor"];
        [self.context save:nil];
    }
    else if (buttonIndex == 2)
    {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
        NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor orangeColor]];
        [[NSUserDefaults standardUserDefaults] setObject:theData forKey:@"myColor"];
        [self.context save:nil];
    }
    else if (buttonIndex == 3)
    {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
        NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor greenColor]];
        [[NSUserDefaults standardUserDefaults] setObject:theData forKey:@"myColor"];
        [self.context save:nil];
    }

}

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    self.colorAlert.tag = 1;
    [self.colorAlert show];
}

@end
