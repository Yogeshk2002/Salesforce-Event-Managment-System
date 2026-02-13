import { LightningElement, track, wire } from 'lwc';
import getEvents from '@salesforce/apex/EventRegistrationController.getEvents';
import registerAttendee from '@salesforce/apex/EventRegistrationController.registerAttendee';

export default class EventRegistrationForm extends LightningElement {

    @track attendeeName = '';
    @track email = '';
    @track eventId = '';

    @track eventOptions = [];
    @track successMessage;
    @track errorMessage;

    @wire(getEvents)
    wiredEvents({ error, data }) {
        if (data) {
            this.eventOptions = data.map(event => {
                return { label: event.Name, value: event.Id };
            });
        } else if (error) {
            this.errorMessage = 'Error loading events';
        }
    }

    handleNameChange(event) {
        this.attendeeName = event.target.value;
    }

    handleEmailChange(event) {
        this.email = event.target.value;
    }

    handleEventChange(event) {
        this.eventId = event.detail.value;
    }

    handleRegister() {
        this.successMessage = null;
        this.errorMessage = null;

        registerAttendee({
            attendeeName: this.attendeeName,
            email: this.email,
            eventId: this.eventId
        })
        .then(() => {
            this.successMessage = 'Registration successful!';
            this.attendeeName = '';
            this.email = '';
            this.eventId = '';
        })
        .catch(error => {
            this.errorMessage = error.body.message;
        });
    }
}
