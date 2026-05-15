# transform.py — validate and clean data before loading


def transform_members(raw_members):
    """Validate and clean member records."""
    transformed = []
    for member in raw_members:
        transformed.append({
            "plinth_member_id": member.get("memberId"),
            "first_name": member.get("firstName", "").strip(),
            "last_name": member.get("lastName", "").strip(),
            "created_at": member.get("createdAt"),
        })
    return transformed


def transform_events(raw_events):
    """Validate and clean event records."""
    transformed = []
    for event in raw_events:
        transformed.append({
            "plinth_event_id": event.get("id"),
            "session_date": event.get("date"),
            "session_type": event.get("type"),
            "location": event.get("location"),
        })
    return transformed


def transform_bookings(raw_bookings):
    """Validate and clean booking records."""
    transformed = []
    for booking in raw_bookings:
        transformed.append({
            "plinth_booking_id": booking.get("id"),
            "plinth_member_id": booking.get("memberId"),
            "plinth_event_id": booking.get("eventId"),
            "checked_in": booking.get("checkedIn", False),
        })
    return transformed
