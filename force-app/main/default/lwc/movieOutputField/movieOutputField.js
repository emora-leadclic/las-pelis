import { LightningElement, api } from 'lwc';

export default class MovieOutputField extends LightningElement {

    @api fieldName;
    @api fieldValue
}