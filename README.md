## **Apex Callouts Superbadge Unit**

**What You'll Be Doing to Earn This Superbadge**
1. Make a secure callout from an Apex batch class.
2. Write a test class to test HTTP callouts.
3. Make a web service callout from an Apex class.
4. Write a test class to test web service callouts.

1. 1. Make a secure callout from an Apex batch class.
2. 2. Write a test class to test HTTP callouts.
3. 3. Make a web service callout from an Apex class.
4. 4. Write a test class to test web service callouts.

### **Concepts Tested in This Superbadge**

- Making an Apex REST callout
- Consuming a WSDL and generating an Apex proxy class to make a SOAP callout
- Apex testing with mock service calls

### **Prework and Notes**

### **Sign Up for a Developer Edition Org with Special Configuration**

To complete this superbadge unit, you need a special Developer Edition org that contains special configuration and sample data. Note that this Developer Edition org is designed to work with the challenges in the superbadge unit.

1. Sign up for a free [Developer Edition org with special configuration](https://trailhead.salesforce.com/promo/orgs/earn-the-outbound-integration-specialist-superbadge).
2. Fill out the form. For Email address, enter an active email address.
3. After you fill out the form, click **Sign me up**.
4. When you receive the activation email (this might take a few minutes), open it and click **Verify Account**.
5. Complete your registration by setting your password and challenge question. Tip: Save your username, password, and login URL in a secure place—such as a password manager—for easy access later.
6. You are logged in to your superbadge Developer Edition org.

### **Additional Configuration**

1. Go to the homepage of the **Balanced Living** app.
2. Click the **Setup** button within the Lightning web component provided.
3. If this is the first time setting up, you will see a success message. If the credentials are already set, it will indicate that no further action is needed.

Now, connect your new Developer Edition org to Trailhead.

1. Make sure you’re logged in to your Trailhead account.
2. In the Challenge section at the bottom of this page, select **Connect Org** from the picklist.
3. On the login screen, enter the username and password for the Developer Edition org you just set up.
4. On the Allow Access? page, click **Allow**.
5. On the Want to connect this org for hands-on challenges? page, click **Yes! Save it**. You are redirected back to the Challenge page and ready to use your new Developer Edition org to earn this superbadge.
6. Now that you have a Salesforce org with special configuration for this superbadge unit, you’re good to go.

!https://res.cloudinary.com/hy4kyit2a/image/upload/doc/trailhead/en-usb473bb5ea1b7e61dfb07e6a7e547de6b.gif

### **Note**

Before you begin the challenges, review [Outbound Integration Specialist Superbadge: Trailhead Challenge Help](https://trailhead.salesforce.com/en/help?article=Outbound-Integration-Specialist-Superbadge-Trailhead-Challenge-Help).

If you’ve completed any of the superbadge units in the **Outbound Integration Specialist Superbadge**, you can use the Developer Edition org to complete the challenges in this superbadge unit. If not, make sure you’re using a new Developer Edition org from [this signup link](https://trailhead.salesforce.com/promo/orgs/earn-the-outbound-integration-specialist-superbadge). If you use an org that’s been used for other work, you won’t pass the challenges in this superbadge unit.

This superbadge unit is part of the [Outbound Integration Specialist Superbadge](https://trailhead.salesforce.com/content/learn/superbadges/superbadge-outbound-integration-specialist). Complete the capstone assessment and related superbadge units to receive the **Outbound Integration Specialist Superbadge**.

Review [Superbadge Challenge Help](https://trailhead.salesforce.com/help?article=Superbadge-Challenge-Help) for information about the Salesforce Certification Program and Superbadge Code of Conduct.

### **Tips**

- Enter all labels exactly as described in the instructions. Labels are case-sensitive and spelling counts.
- When possible, copy and paste the label names from the instructions instead of typing them.
- Build your solution according to the requirements; adding more configurations can cause challenge checks to fail.
- Use system logging to help diagnose issues during the development and testing phases.

### **Use Case**

Welcome to Alignment Accounting, a company that is committed to the well-being of its employees. Alignment Accounting understands that the demands of a career in accounting can take a toll on both physical and mental health, and it actively seeks new ways to support its staff. The Balanced Living wellness app is Alignment Accounting’s latest initiative to promote a balanced lifestyle among its employees.

In this unit, we explore the development of systems designed to encourage and recognize employee participation in wellness activities via the app. We will work to automate and refine processes that track, reward, and ultimately elevate the wellness program's impact.

!https://res.cloudinary.com/hy4kyit2a/image/upload/doc/trailhead/en-usb473bb5ea1b7e61dfb07e6a7e547de6b.gif

### **Note**

This unit requires additional setup. Make sure to complete the [additional configuration](https://trailhead.salesforce.com/content/learn/superbadges/superbadge-apex-callouts-sbu#setup-credentials) in the Prework and Notes section.

### **Business Requirements**

### **Rewards Management**

The introduction of the Balanced Living initiative has helped to promote wellness and active lifestyles among employees at Alignment Accounting. To keep up the momentum, the company wants to recognize and reward consistent participation in these activities. Employees who meet certain participation goals will be given rewards, which are managed by an external company. You need to get a list of eligible employees ready to send to the **UserRewards** operation (POST) defined in the [BalancedLiving API specification](https://developer.salesforce.com/files/sb-files/superbadge-external-services-sbu/BalancedLivingAPI.json).

An Apex batch class named **WellnessJourneyRewardsBatch** identifies employees who have consistently participated in wellness activities and are eligible for rewards. This class should handle data from the Wellness Journey (API Name Wellness_Journey__c) object, compile eligible employee data, serialize this data into JSON format, and make a secure HTTP callout to an external rewards management service.

The batch class queries the completed Wellness Journey records of users as eligible for rewards who have completed at least 12 wellness activities within a quarter. The batch class aggregates the data of eligible employees, including their ID, name, username, and contact email. Update the **execute** method in the **WellnessJourneyRewardsBatch** class to convert the compiled data into a JSON format suitable for transmission to the external system.

Update the **submitUsersForRewardCallout(String jsonBody)** method within the **RewardsCalloutService** Apex class where `jsonBody` is the serialized user data from the **WellnessJourneyRewardsBatch** class. This method should perform an HTTP callout to the `/rewards` path of the endpoint stored in the **BalancedLiving** (Name `IntegrationSB__BalancedLiving`) named credential. The related external credential makes sure the callout is made securely.

For this challenge, use system logging to debug the response code returned from the **submitUsersForRewardCallout** method in the WellnessJourneyRewardsBatch class.

!https://res.cloudinary.com/hy4kyit2a/image/upload/doc/trailhead/en-us50b669ab18cf8a5692a5d53ad05604bd.png

### **Tip**

Run the batch class to identify eligible employees and compile their data appropriately to test the HTTP callout for correct data formatting, secure data transmission, and proper handling of responses from the external system.

### **Test Rewards Callout Service**

Now it’s time to ensure the integrity and reliability of the system that communicates with Alignment Accounting’s external rewards management service. Test the HTTP callouts to ensure they are secure and reliable, and that they correctly handle data exchanges with the external service. This is particularly important as these callouts transmit sensitive user data.

Develop a testing environment using Apex to validate the functionality of the RewardsCalloutService. This includes creating a mock version of the HTTP callout to simulate interactions with the external rewards management service, ensuring that the callouts are secure and that the application can handle errors.

Note: Do not use a static resource to complete this challenge.

Implement the `RewardsCalloutServiceMock` class to simulate responses from the external service. This class will return predefined JSON responses that mimic both successful and erroneous interactions. Create the `RewardsCalloutServiceTest` class to systematically test the callout logic under various scenarios, such as successful data submission and response handling, as well as failure modes like API outages or bad data.

Verify that the RewardsCalloutServiceMock accurately mimics the external service’s responses, to ensure the system can handle all scenarios. Create test data for at least 12 wellness journey records within a quarter for a user. Use system logging to confirm the `startDate` and `endDate` for executing the batch class. Conduct tests to confirm that the HTTP callout processes and sends data correctly, using the mock to provide controlled response scenarios. Write unit tests for at least 90% code coverage for **WellnessJourneyRewardsBatch** and **RewardsCalloutService** Apex classes to ensure comprehensive testing of the callout functionality.

### **Accessibility Project Billing**

Alignment Accounting’s commitment to inclusivity extends to ensuring that wellness programs are accessible to all employees, including those in the Deaf and Hard of Hearing (DHH) community. To support participation in onsite wellness workshops like guided meditation and yoga, Alignment Accounting provides American Sign Language (ASL) interpreters, funded initially by the company and later reimbursed by employee insurance plans.

The Apex trigger, **WorkshopTrigger**, generates an **Accessibility Project** (API Name: `Accessibility_Project__c`) record with the calculated amount whenever a workshop record is created with the DHH_Accessible__c field marked true. Your task is to complete the **callBillingService** method within the **AccessibilityProjectBilling** class.

You will interface with a SOAP service provided by the insurance company to submit claims for these services. The goal is to ensure accurate and timely reimbursements.

To achieve this, you need to develop and configure a SOAP client that will communicate with the insurance company’s service. The client will submit billing claims including the project ID and billing amount for the ASL interpreting services.

The Billing Service is exposed through a SOAP API. So, consume [the WSDL provided by the billing system’s IT team](https://developer.salesforce.com/files/sb-files/superbadge-apex-callouts-sbu/IntegrationSB__billingInvoice.wsdl), and generate a proxy class (named `BillingServiceProxy`) to use for your callout. There is only one service method definition. It requires you to pass the following arguments.

| **Field** | **Value** |
| --- | --- |
| projectid | Accessibility Project ID |
| billAmount | Accessibility Project Amount |
| username | `{!$Credential.BillingServiceCredential.username}` |
| password | `{!$Credential.BillingServiceCredential.password}` |

Prepare the data for submission so that it meets the format and standards required by the insurance company’s SOAP service. If the outbound call is successful, set the Accessibility Project record's status to **Complete** (but we won't check for this requirement).

### **Test Billing Callout Service**

With the SOAP service integration for ASL interpreter billing now in place, you need to ensure that the system operates reliably and accurately under all conditions. This includes validating the SOAP callouts, handling responses, and ensuring that data integrity and security are maintained. Develop a comprehensive test class that simulates interactions with the SOAP service. Ensure that the system can handle various scenarios effectively.

Validate the functionality of the SOAP client used for ASL interpreter billing. This involves developing a mock service, `BillingCalloutServiceMock`, to simulate responses from the insurance company's service. Implement the mock class to simulate SOAP responses from the insurance company’s service. This mock class will provide predefined responses for both successful and erroneous scenarios. Ensure that the system processes these responses correctly and can handle any potential errors effectively.

Create an Apex test class called `BillingCalloutServiceTest` to systematically validate the SOAP callout logic. Ensure that the system can handle data correctly, process responses, and manage errors efficiently. Write unit tests for at least 90% code coverage for **AccessibilityProjectBilling** and **BillingServiceProxy** Apex classes to ensure comprehensive testing of the SOAP callout functionality.
