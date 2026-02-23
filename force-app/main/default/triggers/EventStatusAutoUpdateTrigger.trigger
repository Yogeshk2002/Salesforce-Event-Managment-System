trigger EventStatusAutoUpdateTrigger on Event__c (before insert) {
    for(Event__c ev : Trigger.new) {
        
        if(ev.Event_Date__c != null && ev.Event_Date__c < Date.today() && ev.Event_Status__c != 'Completed'){
			System.debug('inside the ');
            ev.Event_Status__c = 'Completed';

        }
    }
}