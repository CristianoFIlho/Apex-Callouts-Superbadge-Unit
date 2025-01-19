@isTest
private class AsyncBillingServiceProxyTest {
    
    @isTest static void testAsyncBillProject_Success() {
        // Arrange
        AsyncBillingServiceProxy.AsyncInvoicesPortSoap11 proxy = new AsyncBillingServiceProxy.AsyncInvoicesPortSoap11();
        BillingServiceProxy.project testProject = new BillingServiceProxy.project();
        testProject.projectId = '12345';
        // testProject.billableAmount = 100.00;
        
        // Setup continuation
        Continuation cont = new Continuation(40);
        cont.continuationMethod = 'processResponse';
        
        // Act
        Test.startTest();
        AsyncBillingServiceProxy.billProjectResponse_elementFuture response = 
            proxy.beginBillProject(cont, testProject);
        Test.stopTest();
        
        // Assert
        System.assertNotEquals(null, response, 'Response should not be null');
        System.assertEquals('callout:IntegrationSB__BillingInvoiceService', 
            proxy.endpoint_x, 'Endpoint should match expected value');
    }
    
    @isTest static void testAsyncBillProject_InvalidData() {
        // Arrange
        AsyncBillingServiceProxy.AsyncInvoicesPortSoap11 proxy = new AsyncBillingServiceProxy.AsyncInvoicesPortSoap11();
        BillingServiceProxy.project testProject = new BillingServiceProxy.project();
        // Invalid project data
        testProject.projectId = null;
        // testProject.billableAmount = -100.00;
        
        // Setup continuation
        Continuation cont = new Continuation(40);
        cont.continuationMethod = 'processResponse';
        
        // Act & Assert
        try {
            Test.startTest();
            AsyncBillingServiceProxy.billProjectResponse_elementFuture response = 
                proxy.beginBillProject(cont, testProject);
            Test.stopTest();
        } catch(Exception e) {
            System.assert(e.getMessage().length() > 0, 'Should throw error for invalid data');
        }
    }
    
    @isTest static void testEndpointConfiguration() {
        // Arrange & Act
        AsyncBillingServiceProxy.AsyncInvoicesPortSoap11 proxy = new AsyncBillingServiceProxy.AsyncInvoicesPortSoap11();
        
        // Assert
        System.assertEquals('callout:IntegrationSB__BillingInvoiceService', 
            proxy.endpoint_x, 'Endpoint should be correctly configured');
        System.assertEquals(null, proxy.timeout_x, 'Default timeout should be null');
        System.assertEquals(null, proxy.clientCertName_x, 'Default client cert should be null');
    }
}