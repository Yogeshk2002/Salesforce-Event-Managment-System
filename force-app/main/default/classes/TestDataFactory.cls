@isTest
public class TestDataFactory {

    public static Sponsor__c createSponsor() {
        Sponsor__c sp = new Sponsor__c();
        sp.Name = 'Test Sponsor';
        insert sp;
        return sp;
    }

    public static Event__c createEvent(Id sponsorId) {
        Event__c ev = new Event__c();
        ev.Name = 'Test Event';
        ev.Event_Date__c = Date.today().addDays(5);
        ev.Status__c = 'Upcoming';
        ev.Sponsor__c = sponsorId;
        insert ev;
        return ev;
    }

    public static Attendee__c createAttendee(Id eventId) {
        Attendee__c att = new Attendee__c();
        att.Name = 'Test Attendee';
        att.Email__c = 'test@test.com';
        att.Event__c = eventId;
        insert att;
        return att;
    }
}
