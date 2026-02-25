public with sharing class SponsorDashboardController {

    @AuraEnabled(cacheable=true)
    public static List<Event__c> getEvents(Id sponsorId) {

        return [
            SELECT Id, Name,
                   (SELECT Id FROM Attendees__r)
            FROM Event__c
            WHERE Sponsor__c = :sponsorId
        ];
    }
}






// public with sharing class SponsorDashboardController {

//     @AuraEnabled(cacheable=true)
//     public static List<Event__c> getEvents(Id sponsorId) {

    
//         List<Event__c> eventList = [
//             SELECT Id, Name,
//                    (SELECT Id FROM Attendees__r)
//             FROM Event__c
//             WHERE Sponsor__c = :sponsorId
//         ];

//         return eventList;
//     }
// }