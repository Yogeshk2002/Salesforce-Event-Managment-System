trigger NewAttendeeRegistrationEmailTrigger on Attendee__c (after insert) {
	System.debug('TRIGGER STARTED');

    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

    for (Attendee__c att : Trigger.new) {

        System.debug('Processing Attendee: ' + att.Name);
        System.debug('Email value: ' + att.Email__c);
        System.debug('Event Id: ' + att.Event__c);

        // Safety check
        if (att.Email__c == null) {
            System.debug('ERROR: Email is NULL, skipping record');
            continue;
        }

        if (att.Event__c == null) {
            System.debug('ERROR: Event is NULL, skipping record');
            continue;
        }

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { att.Email__c });
        mail.setSubject('Event Registration Confirmation');

        // This will likely be NULL (important for learning)
        System.debug('Event Name (via relationship): ' + att.Event__r);

        String body = 'Hello ' + att.Name + ',\n\n' +
                      'Thank you for registering for the event.\n\n' +
                      'Event Name: ' + att.Event__r + '\n\n' +
                      'Regards,\nEvent Management Team';

        mail.setPlainTextBody(body);
        emails.add(mail);

        System.debug('Email prepared for: ' + att.Email__c);
    }

    System.debug('Total emails to send: ' + emails.size());

    if (!emails.isEmpty()) {
        Messaging.sendEmail(emails);
        System.debug('SUCCESS: sendEmail() executed');
    } else {
        System.debug('No emails sent');
    }

    System.debug('TRIGGER FINISHED');
}