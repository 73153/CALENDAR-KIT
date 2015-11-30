//
//  ACDViewController.m
//  Calendar
//
//  Created by zhu on 23/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "ACDViewController.h"
#import "AutocompletionTableView.h"
#import "EditViewController.h"

#import <MapKit/MapKit.h>
#define currentMonth [currentMonthString integerValue]

@interface ACDViewController ()<MKMapViewDelegate>
{
    CLLocationCoordinate2D location;
}

@property (nonatomic, strong) CLGeocoder *myGeocoder;
@property MKPointAnnotation* annotation;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property CLLocationManager* cllmanager;
@property (nonatomic, strong) AutocompletionTableView *autoCompleter;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property NSDateFormatter *dateFormatters;
@property NSDate *destinationDate;


@end


@implementation ACDViewController

//NSString *dateStr;
@synthesize textField = _textField;
@synthesize autoCompleter = _autoCompleter;
@synthesize annotation;
@synthesize dateFormatters;
@synthesize destinationDate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Use the property cllmanager to grab location information
    self.cllmanager = [[CLLocationManager alloc] init];
    self.cllmanager.delegate = self;
    self.cllmanager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    [self.cllmanager startUpdatingLocation];
    
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;

    
    // set "value changed" event handler for TextField
    [self.textField addTarget:self.autoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    
}

- (NSString *)checkName {
    NSString *input, *result;
    NSArray *all = _autoCompleter.suggestionsDictionary;
    input = self.textField.text;
    
    
    for (NSString *s in all) {
        if ([s isEqualToString:input]) {
            result = s;
            break;
        }
    }
    
    return result;
}

- (NSString *)getTheSame {
    NSString *input, *result;
    NSArray *all = [NSTimeZone knownTimeZoneNames];
    input = self.textField.text;
    
    
    for (NSString *s in all) {
        if ([s containsString:input]) {
            result = s;
            break;
        }
    }
    
    return result;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EditViewController* scv = [segue destinationViewController];
    scv.location = _textField.text;
    scv.startTimeText = _startTime;
    scv.destinationTime = destinationDate;
    scv.titleStr = _titleText;
    scv.eventStr = _detailText;
}

- (AutocompletionTableView *)autoCompleter
{
    if (!_autoCompleter)
    {
        NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:2];
        [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
        [options setValue:nil forKey:ACOUseSourceFont];
        
        _autoCompleter = [[AutocompletionTableView alloc] initWithTextField:self.textField inViewController:self withOptions:options];
        _autoCompleter.autoCompleteDelegate = self;
        _autoCompleter.suggestionsDictionary = [NSArray arrayWithObjects:@"Abidjan", @"Accra", @"Addis Ababa", @"Algiers", @"Asmara", @"Bamako", @"Bangui", @"Banjul", @"Bissau", @"Blantyre", @"Brazzaville", @"Bujumbura", @"Cairo", @"Casablanca", @"Ceuta", @"Conakry", @"Dakar", @"Dar es Salaam", @"Djibouti", @"Douala", @"El Aaiun", @"Freetown", @"Gaborone", @"Harare", @"Johannesburg", @"Juba", @"Kampala", @"Khartoum", @"Kigali", @"Kinshasa", @"Lagos", @"Libreville", @"Lome", @"Luanda", @"Lubumbashi", @"Lusaka", @"Malabo", @"Maputo", @"Maseru", @"Mbabane", @"Mogadishu", @"Monrovia", @"Nairobi", @"Ndjamena", @"Niamey", @"Nouakchott", @"Ouagadougou", @"Porto Novo", @"Sao Tome", @"Tripoli", @"Tunis", @"Windhoek", @"Adak", @"Anchorage", @"Anguilla", @"Antigua", @"Araguaina", @"Argentina", @"Buenos Aires", @"Catamarca", @"Cordoba", @"Jujuy", @"La_Rioja", @"Mendoza", @"Rio Gallegos", @"Salta", @"San Juan", @"San_Luis", @"Tucuman", @"Ushuaia", @"Aruba",@"Asuncion",@"Atikokan", @"Bahia",@"Bahia Banderas", @"Barbados",@"Belem",@"Belie",@"Blanc-Sablon", @"Boa Vista",@"Bogota",@"Boise", @"Cambridge Bay",@"Campo Grande",@"Cancun",@"Caracas",@"Cayenne",@"Cayman",@"Chicago",@"Chihuahua",@"Costa Rica", @"Creston",@"Cuiaba",@"Curacao",@"Danmarkshavn", @"Dawson",@"Dawson Creek", @"Denver",@"Detroit",@"Dominica",@"Edmonton",@"Eirunepe",@"El Salvador",@"Fortaleza",@"Glace Bay",@"Godthab",@"Goose Bay",@"Grand Turk", @"Grenada",@"Guadeloupe", @"Guatemala",@"Guayaquil", @"Guyana",@"Halifax",@"Havana",@"Hermosillo",@"Indianapolis",@"Knox",@"Marengo",@"Petersburg",@"Tell City",@"Vevay",@"Vincennes",@"Winamac",@"Inuvik",@"Iqaluit",@"Jamaica",@"Juneau",@"Kentucky, Louisville",@"Kentucky, Monticello",@"Kralendijk",@"La Paz",@"Limav",@"Los Angeles",@"Lower Princes",@"Maceio",@"Managua",@"Manaus",@"Marigot",@"Martinique",@"Matamoros",@"Mazatlan",@"Menominee",@"Merida",@"Metlakatla",@"Mexico City",@"Miquelon",@"Moncton",@"Monterrey",@"Montevideo",@"Montreal",@"Montserrat",@"Nassau",@"New York",@"Nipigon",@"Nome",@"Noronha",@"North Dakota, Beulah",@"North Dakota, Center",@"North Dakota, New Salem",@"Ojinaga",@"Panama",@"Pangnirtung",@"Paramaribo",@"Phoenix",@"Port-au-Prince",@"Port of Spain",@"Porto Velho",@"Puerto Rico",@"Rainy River",@"Rankin Inlet",@"Recife",@"Regina",@"Resolute",@"Rio Branco",@"Santa Isabel",@"Santarem",@"Santiago",@"Santo Domingo",@"Sao Paulo",@"Scoresbysund",@"Shiprock",@"Sitka",@"St Barthelemy",@"St Johns",@"St Kitts",@"St Lucia",@"St Thomas",@"St Vincent",@"Swift Current",@"Tegucigalpa",@"Thule",@"Thunder Bay",@"Tijuana",@"Toronto",@"Tortola",@"Vancouver",@"Whitehorse",@"Winnipeg",@"Yakutat",@"Yellowknife",@"Casey",@"Davis",@"DumontDUrville",@"Macquarie",@"Mawson",@"McMurdo",@"Palmer",@"Rothera",@"South Pole",@"Syowa",@"Vostok",@"Arctic, Longyearbyen",@"Aden",@"Almaty",@"Amman",@"Anadyr",@"Aqtau",@"Aqtobe",@"Ashgabat",@"Baghdad",@"Bahrain",@"Baku",@"Bangkok",@"Beirut",@"Bishkek",@"Brunei",@"Choibalsan",@"Chongqing",@"Colombo",@"Damascus",@"Dhaka",@"Dili",@"Dubai",@"Dushanbe",@"Gaza",@"Harbin",@"Hebron",@"Ho Chi Minh",@"Hong Kong",@"Hovd",@"Irkutsk",@"Jakarta",@"Jayapura",@"Jerusalem",@"Kabul",@"Kamchatka",@"Karachi",@"Kashgar",@"Kathmandu",@"Katmandu",@"Kolkata",@"Krasnoyarsk",@"Kuala Lumpur",@"Kuching",@"Kuwait",@"Macau",@"Magadan",@"Makassar",@"Manila",@"Muscat",@"Nicosia",@"Novokuznetsk",@"Novosibirsk",@"Omsk",@"Oral",@"Phnom Penh",@"Pontianak",@"Pyongyang",@"Qatar",@"Qyzylorda",@"Rangoon",@"Riyadh",@"Sakhalin",@"Samarkand",@"Seoul",@"Shanghai",@"Singapore",@"Taipei",@"Tashkent",@"Tbilisi",@"Tehran",@"Thimphu",@"Tokyo",@"Ulaanbaatar",@"Urumqi",@"Vientiane",@"Vladivostok",@"Yakutsk",@"Yekaterinburg",@"Yerevan",@"Azores",@"Bermuda",@"Canary",@"Cape Verde",@"Faroe",@"Madeira",@"Reykjavik",@"South Georgia",@"St Helena",@"Stanley",@"Adelaide",@"Brisbane",@"Broken Hill",@"Currie",@"Darwin",@"Eucla",@"Hobart",@"Lindeman",@"Lord Howe",@"Melbourne",@"Perth",@"Sydney",@"Amsterdam",@"Andorra",@"Athens",@"Belgrade",@"Berlin",@"Bratislava",@"Brussels",@"Bucharest",@"Budapest",@"Chisinau",@"Copenhagen",@"Dublin",@"Gibraltar",@"Guernsey",@"Helsinki",@"Isle of Man",@"Istanbul",@"Jersey",@"Kaliningrad",@"Kiev",@"Lisbon",@"Ljubljana",@"London",@"Luxembourg",@"Madrid",@"Malta",@"Mariehamn",@"Minsk",@"Monaco",@"Moscow",@"Oslo",@"Paris",@"Podgorica",@"Prague",@"Riga",@"Rome",@"Samara",@"San Marino",@"Sarajevo",@"Simferopol",@"Skopje",@"Sofia",@"Stockholm",@"Tallinn",@"Tirane",@"Uzhgorod",@"Vaduz",@"Vatican",@"Vienna",@"Vilnius",@"Volgograd",@"Warsaw",@"Zagreb",@"Zaporohye",@"Zurich",@"Antananarivo",@"Chagos",@"Christmas",@"Cocos",@"Comoro",@"Kerguelen",@"Mahe",@"Maldives",@"Mauritius",@"Mayotte",@"Reunion",@"Apia",@"Auckland",@"Chatham",@"Chuuk",@"Easter",@"Efate",@"Enderbury",@"Fakaofo",@"Fiji",@"Funafuti",@"Galapagos",@"Gambier",@"Guadalcanal",@"Guam",@"Honolulu",@"Johnston",@"Kiritimati",@"Kosrae",@"Kwajalein",@"Majuro",@"Marquesas",@"Midway",@"Nauru",@"Niue",@"Norfolk",@"Noumea",@"Pago Pago",@"Palau",@"Pitcairn",@"Pohnpei",@"Ponape",@"Port Moresby",@"Rarotonga",@"Saipan",@"Tahiti",@"Tarawa",@"Tongatapu",@"Truk",@"Wake",@"Wallis", nil];
    }
    return _autoCompleter;
}




-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userlocation
{
    [self.mapView setCenterCoordinate:userlocation.coordinate animated:YES];
}

- (IBAction)oomToCurrentLocation: (id)sender
{
    float spanX =0.00725;
    float spanY =0.00725;
    
    MKCoordinateRegion region;
    region.center.latitude = -37.847968;
    region.center.longitude = 145.114339;
    
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    
    [self.mapView setRegion:region animated:NO];
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorLocationUnknown) {
        NSLog(@"Currently unable to retrieve location");
    }
    else if (error.code == kCLErrorNetwork)
    {
        NSLog(@"Network used to trieve location is unavailable");
    }
    else if (error.code == kCLErrorDenied)
    {
        NSLog(@"Permission to retrieve location is denied");
        //  [self.cllmanager stopUpdatingLocation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goSearched: (UIButton *)sender
{
    if ([self checkName] != nil) {
    //recall the method getTheSame
    NSString* timezone = [self getTheSame];

    //set date format
    //_dateStr = _startTime;
    NSLog(@"sdssddddddddddddddddddd %@", _startTime);

    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"dd-MM-yyyy hh:mm a"];
    NSDate *adate = [dateFormatter1 dateFromString:_startTime];

    NSLog(@"date : %@",adate);
    //get time zones
    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    NSTimeZone *TimeZone = [NSTimeZone timeZoneWithName:timezone];
    
    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:adate];
    NSInteger Offset = [TimeZone secondsFromGMTForDate:adate];
    NSTimeInterval Interval = Offset - currentGMTOffset;
    
    destinationDate = [[NSDate alloc] initWithTimeInterval:Interval sinceDate:adate];
    
    //get the address searched
    NSString* address = _textField.text;
    [self getLocation:address];
    }
    else {
        [self popAlert:@"Enter a valid location."];

    }
    
}

- (void) popAlert:(NSString*)message
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:message message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: @"Cancel", nil];
    [alertView show];
    
}

- (NSString *)timestamp {
    return [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970] * 1000];
}

-(void) getLocation:(NSString*)address
{
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    //__block long lat, lng = 0;
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (placemarks.count > 0 && error == nil){
            
            NSLog(@"Found %lu placemark(s).",
                  (unsigned long)[placemarks count]);
            
            CLPlacemark *firstPlacemark = placemarks[0];
            
            annotation = [MKPointAnnotation new];
            annotation.coordinate = firstPlacemark.location.coordinate;
            //lat = firstPlacemark.location.coordinate.latitude;
            //lng = firstPlacemark.location.coordinate.longitude;
            annotation.title = address;
                NSLog(@"Lat:%f Long:%f", annotation.coordinate.latitude, annotation.coordinate.longitude);

            [self.mapView addAnnotation:annotation];
            [self zoomToCurrentLocationelse:firstPlacemark.location.coordinate andSpanX:0.0075 andSpanY:0.0075];
            
            
        }
        else if (placemarks.count == 0 &&
                 error == nil){
            [self popAlert:@"Found no placemarks."];
        }
        else if (error != nil){
            [self popAlert:@"error"];
        }
    }];
    

}



-(void)zoomToCurrentLocationelse: (CLLocationCoordinate2D)pinLocation andSpanX:(float)spanX andSpanY:(float)spanY
{
    MKCoordinateRegion region;
    region.center = pinLocation;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [self.mapView setRegion:region animated:NO];
}


#pragma mark - AutoCompleteTableViewDelegate

- (NSArray*) autoCompletion:(AutocompletionTableView*) completer suggestionsFor:(NSString*) string{
    // with the prodided string, build a new array with suggestions
    return [NSArray arrayWithObjects:@"Abidjan", @"Accra", @"Addis Ababa", @"Algiers", @"Asmara", @"Bamako", @"Bangui", @"Banjul", @"Bissau", @"Blantyre", @"Brazzaville", @"Bujumbura", @"Cairo", @"Casablanca", @"Ceuta", @"Conakry", @"Dakar", @"Dar es Salaam", @"Djibouti", @"Douala", @"El Aaiun", @"Freetown", @"Gaborone", @"Harare", @"Johannesburg", @"Juba", @"Kampala", @"Khartoum", @"Kigali", @"Kinshasa", @"Lagos", @"Libreville", @"Lome", @"Luanda", @"Lubumbashi", @"Lusaka", @"Malabo", @"Maputo", @"Maseru", @"Mbabane", @"Mogadishu", @"Monrovia", @"Nairobi", @"Ndjamena", @"Niamey", @"Nouakchott", @"Ouagadougou", @"Porto Novo", @"Sao Tome", @"Tripoli", @"Tunis", @"Windhoek", @"Adak", @"Anchorage", @"Anguilla", @"Antigua", @"Araguaina", @"Argentina", @"Buenos Aires", @"Catamarca", @"Cordoba", @"Jujuy", @"La_Rioja", @"Mendoza", @"Rio Gallegos", @"Salta", @"San Juan", @"San_Luis", @"Tucuman", @"Ushuaia", @"Aruba",@"Asuncion",@"Atikokan", @"Bahia",@"Bahia Banderas", @"Barbados",@"Belem",@"Belie",@"Blanc-Sablon", @"Boa Vista",@"Bogota",@"Boise", @"Cambridge Bay",@"Campo Grande",@"Cancun",@"Caracas",@"Cayenne",@"Cayman",@"Chicago",@"Chihuahua",@"Costa Rica", @"Creston",@"Cuiaba",@"Curacao",@"Danmarkshavn", @"Dawson",@"Dawson Creek", @"Denver",@"Detroit",@"Dominica",@"Edmonton",@"Eirunepe",@"El Salvador",@"Fortaleza",@"Glace Bay",@"Godthab",@"Goose Bay",@"Grand Turk", @"Grenada",@"Guadeloupe", @"Guatemala",@"Guayaquil", @"Guyana",@"Halifax",@"Havana",@"Hermosillo",@"Indianapolis",@"Knox",@"Marengo",@"Petersburg",@"Tell City",@"Vevay",@"Vincennes",@"Winamac",@"Inuvik",@"Iqaluit",@"Jamaica",@"Juneau",@"Kentucky, Louisville",@"Kentucky, Monticello",@"Kralendijk",@"La Paz",@"Limav",@"Los Angeles",@"Lower Princes",@"Maceio",@"Managua",@"Manaus",@"Marigot",@"Martinique",@"Matamoros",@"Mazatlan",@"Menominee",@"Merida",@"Metlakatla",@"Mexico City",@"Miquelon",@"Moncton",@"Monterrey",@"Montevideo",@"Montreal",@"Montserrat",@"Nassau",@"New York",@"Nipigon",@"Nome",@"Noronha",@"North Dakota, Beulah",@"North Dakota, Center",@"North Dakota, New Salem",@"Ojinaga",@"Panama",@"Pangnirtung",@"Paramaribo",@"Phoenix",@"Port-au-Prince",@"Port of Spain",@"Porto Velho",@"Puerto Rico",@"Rainy River",@"Rankin Inlet",@"Recife",@"Regina",@"Resolute",@"Rio Branco",@"Santa Isabel",@"Santarem",@"Santiago",@"Santo Domingo",@"Sao Paulo",@"Scoresbysund",@"Shiprock",@"Sitka",@"St Barthelemy",@"St Johns",@"St Kitts",@"St Lucia",@"St Thomas",@"St Vincent",@"Swift Current",@"Tegucigalpa",@"Thule",@"Thunder Bay",@"Tijuana",@"Toronto",@"Tortola",@"Vancouver",@"Whitehorse",@"Winnipeg",@"Yakutat",@"Yellowknife",@"Casey",@"Davis",@"DumontDUrville",@"Macquarie",@"Mawson",@"McMurdo",@"Palmer",@"Rothera",@"South Pole",@"Syowa",@"Vostok",@"Arctic, Longyearbyen",@"Aden",@"Almaty",@"Amman",@"Anadyr",@"Aqtau",@"Aqtobe",@"Ashgabat",@"Baghdad",@"Bahrain",@"Baku",@"Bangkok",@"Beirut",@"Bishkek",@"Brunei",@"Choibalsan",@"Chongqing",@"Colombo",@"Damascus",@"Dhaka",@"Dili",@"Dubai",@"Dushanbe",@"Gaza",@"Harbin",@"Hebron",@"Ho Chi Minh",@"Hong Kong",@"Hovd",@"Irkutsk",@"Jakarta",@"Jayapura",@"Jerusalem",@"Kabul",@"Kamchatka",@"Karachi",@"Kashgar",@"Kathmandu",@"Katmandu",@"Kolkata",@"Krasnoyarsk",@"Kuala Lumpur",@"Kuching",@"Kuwait",@"Macau",@"Magadan",@"Makassar",@"Manila",@"Muscat",@"Nicosia",@"Novokuznetsk",@"Novosibirsk",@"Omsk",@"Oral",@"Phnom Penh",@"Pontianak",@"Pyongyang",@"Qatar",@"Qyzylorda",@"Rangoon",@"Riyadh",@"Sakhalin",@"Samarkand",@"Seoul",@"Shanghai",@"Singapore",@"Taipei",@"Tashkent",@"Tbilisi",@"Tehran",@"Thimphu",@"Tokyo",@"Ulaanbaatar",@"Urumqi",@"Vientiane",@"Vladivostok",@"Yakutsk",@"Yekaterinburg",@"Yerevan",@"Azores",@"Bermuda",@"Canary",@"Cape Verde",@"Faroe",@"Madeira",@"Reykjavik",@"South Georgia",@"St Helena",@"Stanley",@"Adelaide",@"Brisbane",@"Broken Hill",@"Currie",@"Darwin",@"Eucla",@"Hobart",@"Lindeman",@"Lord Howe",@"Melbourne",@"Perth",@"Sydney",@"Amsterdam",@"Andorra",@"Athens",@"Belgrade",@"Berlin",@"Bratislava",@"Brussels",@"Bucharest",@"Budapest",@"Chisinau",@"Copenhagen",@"Dublin",@"Gibraltar",@"Guernsey",@"Helsinki",@"Isle of Man",@"Istanbul",@"Jersey",@"Kaliningrad",@"Kiev",@"Lisbon",@"Ljubljana",@"London",@"Luxembourg",@"Madrid",@"Malta",@"Mariehamn",@"Minsk",@"Monaco",@"Moscow",@"Oslo",@"Paris",@"Podgorica",@"Prague",@"Riga",@"Rome",@"Samara",@"San Marino",@"Sarajevo",@"Simferopol",@"Skopje",@"Sofia",@"Stockholm",@"Tallinn",@"Tirane",@"Uzhgorod",@"Vaduz",@"Vatican",@"Vienna",@"Vilnius",@"Volgograd",@"Warsaw",@"Zagreb",@"Zaporohye",@"Zurich",@"Antananarivo",@"Chagos",@"Christmas",@"Cocos",@"Comoro",@"Kerguelen",@"Mahe",@"Maldives",@"Mauritius",@"Mayotte",@"Reunion",@"Apia",@"Auckland",@"Chatham",@"Chuuk",@"Easter",@"Efate",@"Enderbury",@"Fakaofo",@"Fiji",@"Funafuti",@"Galapagos",@"Gambier",@"Guadalcanal",@"Guam",@"Honolulu",@"Johnston",@"Kiritimati",@"Kosrae",@"Kwajalein",@"Majuro",@"Marquesas",@"Midway",@"Nauru",@"Niue",@"Norfolk",@"Noumea",@"Pago Pago",@"Palau",@"Pitcairn",@"Pohnpei",@"Ponape",@"Port Moresby",@"Rarotonga",@"Saipan",@"Tahiti",@"Tarawa",@"Tongatapu",@"Truk",@"Wake",@"Wallis", nil];
}

- (void) autoCompletion:(AutocompletionTableView*) completer didSelectAutoCompleteSuggestionWithIndex:(NSInteger) index{
    // invoked when an available suggestion is selected
    NSLog(@"%@ - Suggestion chosen: %ld", completer, (long)index);
}

- (IBAction)goBack:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Rex" bundle:nil];
    EditViewController *scv = [story instantiateViewControllerWithIdentifier:@"rex.storyboard"];
    if([self checkName] != nil) {
    scv.location = _textField.text;
    scv.startTimeText = _startTime;
    scv.destinationTime = destinationDate;
    scv.titleStr = _titleText;
    scv.eventStr = _detailText;
        
        [self presentViewController:scv animated:YES completion:nil];
    }
    else {
        scv.location = nil;
        scv.startTimeText = _startTime;
        scv.destinationTime = nil;
        scv.titleStr = _titleText;
        scv.eventStr = _detailText;
        
        [self presentViewController:scv animated:YES completion:nil];
    }

 
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
