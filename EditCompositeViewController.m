//
//  EditCompositeViewController.m
//  Filer
//
//  Created by ohashi tosikazu on 11/07/15.
//  Copyright 2011 nagoya-bunri. All rights reserved.
//

#import "EditCompositeViewController.h"

#import "FileTypeSelectorViewController.h"

#import "Composite.h"
#import "Folder.h"
#import "File.h"

@implementation EditCompositeViewController

@synthesize parentComposite, editComposite;
@synthesize managedObjectContext;
@synthesize nameInput;

- (void)dealloc
{
    [parentComposite release];
    [editComposite release];
    [nameInput release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"新規作成";
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.navigationItem.leftBarButtonItem = saveButton;
    [saveButton release];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = cancelButton;
    [cancelButton release];
    
    // タイトル入力のビューを作成して親のビューに追加
	UITextField *aNameInput = [[UITextField alloc] init];
	aNameInput.font = [UIFont systemFontOfSize:20.0f];
    aNameInput.placeholder = @"ファイル名を入力";
	self.nameInput = aNameInput;
	[aNameInput release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
        
    [self.tableView reloadData];
}



#pragma mark -
#pragma mark TableViewDataSourceDelegate

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (indexPath.row == 0) {
        // セルに最適なサイズを取得してタイトル入力フィールドに設定
        CGRect frame = CGRectInset(cell.contentView.bounds, 16, 8);
        nameInput.frame = frame;
        // タイトル入力フィールドをセルに追加
        [cell.contentView addSubview:nameInput];
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"ファイルの種類";
    }
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 1) {
        FileTypeSelectorViewController *fileTypeSelectorViewController = [[FileTypeSelectorViewController alloc] init];
        [self.navigationController pushViewController:fileTypeSelectorViewController animated:YES];
        [fileTypeSelectorViewController release];
    }
}

- (IBAction)cancel:(id)sender {
    // 削除
    //[[composite managedObjectContext] deleteObject:composite];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender {
    
    Composite *newComposite = [NSEntityDescription insertNewObjectForEntityForName:@"File" inManagedObjectContext:managedObjectContext];
    
    self.editComposite = newComposite;
    
    // 保存
    if (nameInput.text.length == 0) {
        editComposite.name = @"新規ファイル";
    } else {
        editComposite.name = nameInput.text;
    }
    
    [parentComposite addChildrenObject:editComposite];
    editComposite.parent = parentComposite;
        
    // Save the context.
    NSError *error = nil;
    if (![managedObjectContext save:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
