# ingest.py — main entry point, orchestrates the ETL pipeline
import os
from dotenv import load_dotenv
from extract import fetch_members, fetch_events, fetch_bookings
from transform import transform_members, transform_events, transform_bookings
from load import upsert_members, upsert_events, upsert_bookings

load_dotenv()


def run():
    print("Starting Brookhill ingestion...")

    # Members
    raw_members = fetch_members()
    members = transform_members(raw_members)
    upsert_members(members)
    print(f"Members: {len(members)} records loaded")

    # Events
    raw_events = fetch_events()
    events = transform_events(raw_events)
    upsert_events(events)
    print(f"Events: {len(events)} records loaded")

    # Bookings
    raw_bookings = fetch_bookings()
    bookings = transform_bookings(raw_bookings)
    upsert_bookings(bookings)
    print(f"Bookings: {len(bookings)} records loaded")

    print("Ingestion complete.")


if __name__ == "__main__":
    run()
