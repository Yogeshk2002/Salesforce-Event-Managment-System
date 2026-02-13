public with sharing class EventRegistrationController {

    @AuraEnabled(cacheable=true)
    public static List<Event__c> getEvents() {
        return [
            SELECT Id, Name
            FROM Event__c
            WHERE Event_Date__c >= TODAY
            ORDER BY Event_Date__c
        ];
    }

    @AuraEnabled
    public static String registerAttendee(String attendeeName, String email, Id eventId) {

        if (String.isBlank(attendeeName) || String.isBlank(email) || eventId == null) {
            throw new AuraHandledException('All fields are required.');
        }

        Attendee__c att = new Attendee__c();
        att.Name = attendeeName;
        att.Email__c = email;
        att.Event__c = eventId;

        insert att;

        return 'SUCCESS';
    }
}
