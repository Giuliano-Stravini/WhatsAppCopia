import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsappcopia/models/whatsapp_contact.dart';

class ContactBloc {
  Future<List<WhatsAppContact>> getAllContact(
      {List<WhatsAppContact>? contactsCache}) async {
    if (contactsCache != null && contactsCache.isNotEmpty) {
      return contactsCache;
    }

    List<WhatsAppContact> whatsAppContact = [];

    bool permission = await FlutterContacts.requestPermission();

    if (permission) {
      var contacts = await FlutterContacts.getContacts(withProperties: true);
      for (var contact in contacts) {
        whatsAppContact.add(WhatsAppContact()..contact = contact);
      }
    }

    return whatsAppContact;
  }
}
