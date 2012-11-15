//
//  COTOptionView.m
//  CashOut
//
//  Created by Rick on 11/7/12.
//  Copyright (c) 2012 Rick. All rights reserved.
//

#import "COTOptionView.h"

@interface COTOptionView ()

@end

@implementation COTOptionView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(NSString *) filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"data.sqlite3"];
}
//to open the database
-(void) openDB{
    if(sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK)//to check if the  database is invalid
    {
        sqlite3_close(db);
        NSAssert(0,@"Database failed to open.");
    }
}
-(Boolean) isLogged
{
    [self openDB];//to open the database
    //find a currentTeacher in the system
    NSString *sql_stmt = [NSString stringWithFormat:@"SELECT currentTeacher FROM system;"];
    sqlite3_stmt *statement;
    //check the valid expression, if not we close the database.
    if(sqlite3_prepare_v2(db, [sql_stmt UTF8String], -1, &statement,nil) != SQLITE_OK)
    {
        sqlite3_close(db);
        NSAssert(0,@"Failer to connect system table.");
        return FALSE;
    }
    else
    {
        NSString *currentTeacher;
        //read a currentTeacher
        if(sqlite3_step(statement) == SQLITE_ROW)
        {
            //the current teacher in system
            currentTeacher = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement,0)];
        }
        sqlite3_finalize(statement);//we need to exit after reading data, prevent for blocking.
        sqlite3_close(db);
        if(!currentTeacher)
        {
            return FALSE;
        }
        else//the currentTeacher is not nil, then we have a teacher logged
        {
            return TRUE;
        }
        
        
    }
}
//a function to check who is logged in the system and return the user name
-(NSString *) whoIsLogged
{
    NSString* currentTeacherName;// the teacher that is currently logged
    [self openDB];
    NSString *sql_stmt = [NSString stringWithFormat:@"SELECT currentTeacher FROM system;"];
    sqlite3_stmt *statement;
    //check the valid expression, if not we close the database.
    if(sqlite3_prepare_v2(db, [sql_stmt UTF8String], -1, &statement,nil) != SQLITE_OK)
    {
        sqlite3_close(db);
        NSAssert(0,@"Failer to connect system table.");
        return currentTeacherName;
    }
    else
    {
        //read a currentTeacher
        if(sqlite3_step(statement) == SQLITE_ROW)
        {
            //the current teacher in system
            currentTeacherName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement,0)];
        }
        sqlite3_finalize(statement);//we need to exit after reading data, prevent for blocking.
        sqlite3_close(db);
    }
    return currentTeacherName;
}
//a function to log out a teacher that is current logged
-(void) logoutCurrentTeacher:(NSString *) currentTeacherName
{
    [self openDB];
    char *err;
    NSString* sql_stmt = [NSString stringWithFormat:@"DELETE FROM system Where currentTeacher='%@';",currentTeacherName];
    NSLog(@"%@",sql_stmt);
    if(sqlite3_exec(db, [sql_stmt UTF8String], NULL, NULL, &err) != SQLITE_OK)
    {
        sqlite3_close(db);
        NSAssert(0, @"falied to log out!");
        NSLog(@"falied to log out");
        return;
    }
    sqlite3_close(db);
    
}
- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    if([self isLogged])
    {
        logoutButton.enabled = YES;
        logoutButton.alpha = 1;
        spsButton.enabled = YES;
        spsButton.alpha = 1;

    }
    else
    {
        logoutButton.enabled = NO;
        logoutButton.alpha = 0;
        spsButton.enabled = YES;
        spsButton.alpha = 0;
    }

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutAction:(id)sender
{
    [self logoutCurrentTeacher:[self whoIsLogged]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Log out" message:@"Your account has successfully logged out." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    [self viewDidLoad];//reload the screen to update the statue
}

@end
