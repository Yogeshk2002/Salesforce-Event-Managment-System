trigger AttendeeRegistrationEmailTrigger on Attendee__c (after insert) {

    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

    for (Attendee__c att : trigger.new) {


        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        mail.setToAddresses(new String[] { att.Email__c });
        mail.setSubject('Event Registration Confirmation');

        String body = 'Hello ' + att.Name + ',\n\n' +
                      'Thank you for registering for the event.\n\n' +
                      'Event Name: ' + att.Event__r.Name + '\n\n' +
                      'We look forward to seeing you!\n\n' +
                      'Regards,\nEvent Management Team';

        mail.setPlainTextBody(body);

        emails.add(mail);
    }

    if (!emails.isEmpty()) {
        Messaging.sendEmail(emails);
    }
}