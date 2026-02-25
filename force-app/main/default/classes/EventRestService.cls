@RestResource(urlMapping='/Events/*')
global with sharing class EventRestService {

    @HttpGet
    global static List<EventWrapper> getUpcomingEvents() {

        List<Event__c> events = [
            SELECT Id, Name, Event_Date__c, Event_Status__c
            FROM Event__c
            WHERE Event_Status__c = 'Upcoming'
            ORDER BY Event_Date__c ASC
        ];

        List<EventWrapper> result = new List<EventWrapper>();

        for(Event__c ev : events) {
            EventWrapper wrap = new EventWrapper();
            wrap.id = ev.Id;
            wrap.name = ev.Name;
            wrap.eventDate = ev.Event_Date__c;
            result.add(wrap);
        }

        return result;
    }

    global class EventWrapper {
        public String id;
        public String name;
        public Date eventDate;
    }
}