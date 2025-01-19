@isTest
public class RewardsCalloutServiceTest {
    // Test data setup method
    private static List<Wellness_Journey__c> createTestJourneys(Integer count) {
        List<Wellness_Journey__c> journeys = new List<Wellness_Journey__c>();
        User testUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        
        for (Integer i = 0; i < count; i++) {
            journeys.add(new Wellness_Journey__c(
                OwnerId = testUser.Id,
                Name = 'Test Journey ' + i
            ));
        }
        insert journeys;
        return journeys;
    }

    @isTest 
    static void testSubmitUsersForRewardCallout_Success() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());
        List<Wellness_Journey__c> journeys = createTestJourneys(5);

        // Act
        Test.startTest();
        Integer statusCode = RewardsCalloutService.submitUsersForRewardCallout(
            JSON.serialize(journeys)
        );
        Database.executeBatch(new WellnessJourneyRewardsBatch());
        Test.stopTest();

        // Assert
        System.assertEquals(200, statusCode, 'Should return success status code');
        
        // Verify journeys were processed
        List<Wellness_Journey__c> processedJourneys = [
            SELECT Id, Status__c 
            FROM Wellness_Journey__c 
            WHERE Id IN :journeys
        ];
        for(Wellness_Journey__c journey : processedJourneys) {
            System.assertNotEquals(null, journey.Status__c, 'Journey status should be updated');
        }
    }

    // @isTest 
    // static void testSubmitUsersForRewardCallout_Error() {
    //     // Arrange
    //     Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceErrorMock());
    //     String invalidData = 'Invalid JSON';

    //     // Act
    //     Test.startTest();
    //     Integer statusCode = RewardsCalloutService.submitUsersForRewardCallout(invalidData);
    //     Test.stopTest();

    //     // Assert
    //     System.assertEquals(500, statusCode, 'Should return error status code for invalid data');
    // }

    @isTest 
    static void testSubmitUsersForRewardCallout_Batch() {
        // Arrange
        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());
        List<Wellness_Journey__c> journeys = createTestJourneys(10);

        // Act
        Test.startTest();
        Database.executeBatch(new WellnessJourneyRewardsBatch());
        Test.stopTest();

        // Assert
        List<AsyncApexJob> batchJobs = [
            SELECT Id, Status, NumberOfErrors 
            FROM AsyncApexJob 
            WHERE ApexClass.Name = 'WellnessJourneyRewardsBatch'
            ORDER BY CreatedDate DESC LIMIT 1
        ];
        System.assertEquals(1, batchJobs.size(), 'Batch job should be created');
        System.assertEquals('Completed', batchJobs[0].Status, 'Batch job should complete successfully');
        System.assertEquals(0, batchJobs[0].NumberOfErrors, 'Batch job should have no errors');
    }
}