#import "ViewController.h"

@implementation ViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // preseting setup
    self.labelResultColor   = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 80, 20)];
    self.labelRed           = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 80, 20)];
    self.labelGreen         = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 80, 20)];
    self.labelBlue          = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, 80, 20)];

    self.viewResultColor    = [[UIView alloc] initWithFrame:CGRectMake(150, 70, 220, 40)];
    self.textFieldRed       = [[UITextField alloc] initWithFrame:CGRectMake(110, 120, 260, 40)];
    self.textFieldGreen     = [[UITextField alloc] initWithFrame:CGRectMake(110, 170, 260, 40)];
    self.textFieldBlue      = [[UITextField alloc] initWithFrame:CGRectMake(110, 220, 260, 40)];

    self.buttonProcess      = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 50, 300, 100, 20)];
    
    [self.labelResultColor  setText:@"Color"];
    [self.labelRed          setText:@"RED"];
    [self.labelGreen        setText:@"GREEN"];
    [self.labelBlue         setText:@"BLUE"];
    
    [self.textFieldRed      setPlaceholder:@"0..255"];
    [self.textFieldGreen    setPlaceholder:@"0..255"];
    [self.textFieldBlue     setPlaceholder:@"0..255"];
    
    [self.textFieldRed      setBorderStyle:UITextBorderStyleRoundedRect];
    [self.textFieldGreen    setBorderStyle:UITextBorderStyleRoundedRect];
    [self.textFieldBlue     setBorderStyle:UITextBorderStyleRoundedRect];
    
    [self.buttonProcess     setTitle:@"Process" forState:UIControlStateNormal];
    [self.buttonProcess     setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    
    [self.viewResultColor.layer setBorderWidth:1];
    [self.viewResultColor.layer setBorderColor:UIColor.blackColor.CGColor];
    
    [self.view addSubview:self.labelResultColor];
    [self.view addSubview:self.labelRed];
    [self.view addSubview:self.labelGreen];
    [self.view addSubview:self.labelBlue];
    [self.view addSubview:self.viewResultColor];
    [self.view addSubview:self.textFieldRed];
    [self.view addSubview:self.textFieldGreen];
    [self.view addSubview:self.textFieldBlue];
    [self.view addSubview:self.buttonProcess];
    
    // accessibility for tests
    self.view.accessibilityIdentifier               = @"mainView";
    self.textFieldRed.accessibilityIdentifier       = @"textFieldRed";
    self.textFieldGreen.accessibilityIdentifier     = @"textFieldGreen";
    self.textFieldBlue.accessibilityIdentifier      = @"textFieldBlue";
    self.buttonProcess.accessibilityIdentifier      = @"buttonProcess";
    self.labelRed.accessibilityIdentifier           = @"labelRed";
    self.labelGreen.accessibilityIdentifier         = @"labelGreen";
    self.labelBlue.accessibilityIdentifier          = @"labelBlue";
    self.labelResultColor.accessibilityIdentifier   = @"labelResultColor";
    self.viewResultColor.accessibilityIdentifier    = @"viewResultColor";
    
    // events setup
    [self.buttonProcess     addTarget:self action:@selector(didTapButton)    forControlEvents:UIControlEventTouchUpInside];
    
    [self.textFieldRed      addTarget:self action:@selector(didTapTextField) forControlEvents:UIControlEventEditingDidBegin];
    [self.textFieldGreen    addTarget:self action:@selector(didTapTextField) forControlEvents:UIControlEventEditingDidBegin];
    [self.textFieldBlue     addTarget:self action:@selector(didTapTextField) forControlEvents:UIControlEventEditingDidBegin];
}

- (void)didTapButton {
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];

    // input validation
    if (// text length
        [self.textFieldRed.text length] > 0
        && [self.textFieldGreen.text length] > 0
        && [self.textFieldBlue.text length] > 0
        // only digits
        && [self.textFieldRed.text rangeOfCharacterFromSet:notDigits].location   == NSNotFound
        && [self.textFieldGreen.text rangeOfCharacterFromSet:notDigits].location == NSNotFound
        && [self.textFieldBlue.text rangeOfCharacterFromSet:notDigits].location  == NSNotFound
        // numbers in valid range
        && (0 <= [self.textFieldRed.text intValue] && [self.textFieldRed.text intValue] <= 255)
        && (0 <= [self.textFieldGreen.text intValue] && [self.textFieldGreen.text intValue] <= 255)
        && (0 <= [self.textFieldBlue.text intValue] && [self.textFieldBlue.text intValue] <= 255)
    ) {
        UIColor *color = [UIColor
                          colorWithRed:[self.textFieldRed.text floatValue] / 255
                          green:[self.textFieldGreen.text floatValue] / 255
                          blue:[self.textFieldBlue.text floatValue] / 255
                          alpha:1];
        self.viewResultColor.backgroundColor = color;
        
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        CGFloat r = components[0];
        CGFloat g = components[1];
        CGFloat b = components[2];
        
        self.labelResultColor.text = [NSString stringWithFormat:@"0x%02lX%02lX%02lX",
                                      lroundf(r * 255),
                                      lroundf(g * 255),
                                      lroundf(b * 255)];
    } else {
        self.labelResultColor.text = @"Error";
        self.viewResultColor.backgroundColor = [UIColor clearColor];
    }

    [self.textFieldRed      setText:@""];
    [self.textFieldGreen    setText:@""];
    [self.textFieldBlue     setText:@""];
    
    [self.textFieldRed      resignFirstResponder];
    [self.textFieldGreen    resignFirstResponder];
    [self.textFieldBlue     resignFirstResponder];
}

- (void)didTapTextField {
    if ([self.labelResultColor.text isEqualToString:@"Error"]) {
        [self.viewResultColor setBackgroundColor:UIColor.clearColor];
    }
    
    [self.labelResultColor setText:@"Color"];
}

@end
