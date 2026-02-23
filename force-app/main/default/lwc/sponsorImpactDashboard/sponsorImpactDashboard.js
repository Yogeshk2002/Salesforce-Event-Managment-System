import { LightningElement, api, wire } from 'lwc';
import getEvents from '@salesforce/apex/SponsorDashboardController.getEvents';

export default class SponsorImpactDashboard extends LightningElement {

    @api recordId;

    eventData = [];
    totalImpact = 0;

    columns = [
        { label: 'Event Name', fieldName: 'Name' },
        { label: 'Attendee Count', fieldName: 'attendeeCount', type: 'number' }
    ];

    @wire(getEvents, { sponsorId: '$recordId' })
    wiredEvents({ error, data }) {
        if (data) {

            this.eventData = data.map(event => {
                let count = event.Attendees__r ? event.Attendees__r.length : 0;
                return {
                    Id: event.Id,
                    Name: event.Name,
                    attendeeCount: count
                };
            });

            this.calculateTotal();
        }
    }

    calculateTotal() {
        this.totalImpact = this.eventData.reduce(
            (sum, event) => sum + event.attendeeCount,
            0
        );
    }
}
