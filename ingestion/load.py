# load.py — insert transformed data into Supabase
from supabase import create_client
import os


def get_client():
    """Initialise Supabase client."""
    return create_client(
        os.getenv("SUPABASE_URL"),
        os.getenv("SUPABASE_KEY")
    )


def upsert_members(members):
    """Upsert member records into Supabase."""
    client = get_client()
    return client.table("client").upsert(
        members,
        on_conflict="plinth_member_id"
    ).execute()


def upsert_events(events):
    """Upsert event records into Supabase."""
    client = get_client()
    return client.table("session").upsert(
        events,
        on_conflict="plinth_event_id"
    ).execute()


def upsert_bookings(bookings):
    """Upsert booking records into Supabase."""
    client = get_client()
    return client.table("session_attendance").upsert(
        bookings,
        on_conflict="plinth_booking_id"
    ).execute()
