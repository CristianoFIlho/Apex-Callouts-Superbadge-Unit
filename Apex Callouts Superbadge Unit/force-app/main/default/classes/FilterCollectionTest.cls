@isTest
private class FilterCollectionTest {
    
    @TestSetup
    static void setupTestData() {
        List<Account> accounts = new List<Account>();
        for(Integer i = 0; i < 5; i++) {
            accounts.add(new Account(
                Name = 'Test Account ' + i,
                AnnualRevenue = i * 10000
            ));
        }
        insert accounts;
    }
    
    @isTest
    static void testFilterByName() {
        // Arrange
        List<Account> accounts = [SELECT Id, Name FROM Account];
        FilterCollection.Requests req = new FilterCollection.Requests();
        req.inputCollection = accounts;
        req.formula = '$Record.Name LIKE \'%Test Account 1%\'';
        
        // Act
        Test.startTest();
        List<FilterCollection.Results> results = FilterCollection.filter(
            new List<FilterCollection.Requests>{req}
        );
        Test.stopTest();
        
        // Assert
        System.assertEquals(1, results[0].outputCollection.size(), 
            'Should filter to single matching account');
        System.assertEquals('Test Account 1', 
            ((Account)results[0].outputCollection[0]).Name,
            'Should match specific account name');
    }
    
    @isTest
    static void testFilterByRevenue() {
        // Arrange
        List<Account> accounts = [SELECT Id, Name, AnnualRevenue FROM Account];
        FilterCollection.Requests req = new FilterCollection.Requests();
        req.inputCollection = accounts;
        req.formula = '$Record.AnnualRevenue > 20000';
        
        // Act
        Test.startTest();
        List<FilterCollection.Results> results = FilterCollection.filter(
            new List<FilterCollection.Requests>{req}
        );
        Test.stopTest();
        
        // Assert
        System.assert(results[0].outputCollection.size() > 0, 
            'Should return accounts with revenue > 20000');
    }
    
    @isTest
    static void testEmptyCollection() {
        // Arrange
        FilterCollection.Requests req = new FilterCollection.Requests();
        req.inputCollection = new List<Account>();
        req.formula = '$Record.Name != null';
        
        // Act
        Test.startTest();
        List<FilterCollection.Results> results = FilterCollection.filter(
            new List<FilterCollection.Requests>{req}
        );
        Test.stopTest();
        
        // Assert
        System.assertEquals(0, results[0].outputCollection.size(), 
            'Should handle empty collection');
    }
    
    @isTest
    static void testMultipleRequests() {
        // Arrange
        List<Account> accounts = [SELECT Id, Name, AnnualRevenue FROM Account];
        List<FilterCollection.Requests> requests = new List<FilterCollection.Requests>();
        
        FilterCollection.Requests req1 = new FilterCollection.Requests();
        req1.inputCollection = accounts;
        req1.formula = '$Record.AnnualRevenue > 0';
        requests.add(req1);
        
        FilterCollection.Requests req2 = new FilterCollection.Requests();
        req2.inputCollection = accounts;
        req2.formula = '$Record.AnnualRevenue = 0';
        requests.add(req2);
        
        // Act
        Test.startTest();
        List<FilterCollection.Results> results = FilterCollection.filter(requests);
        Test.stopTest();
        
        // Assert
        System.assertEquals(2, results.size(), 
            'Should process multiple requests');
        System.assert(results[0].outputCollection.size() > 0, 
            'First filter should return results');
        System.assertEquals(1, results[1].outputCollection.size(), 
            'Second filter should return one result');
    }
}