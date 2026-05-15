# extract.py — fetch data from Plinth API
import requests
import os


def fetch_members(offset=0, limit=250):
    """Fetch members from Plinth API with pagination."""
    response = requests.get(
        "https://app.plinth.org.uk/api/v1/members",
        headers={"x-api-key": os.getenv("PLINTH_API_KEY")},
        params={"limit": limit, "offset": offset}
    )
    response.raise_for_status()
    return response.json()


def fetch_events(offset=0, limit=250):
    """Fetch events from Plinth API with pagination."""
    response = requests.get(
        "https://app.plinth.org.uk/api/v1/events",
        headers={"x-api-key": os.getenv("PLINTH_API_KEY")},
        params={"limit": limit, "offset": offset}
    )
    response.raise_for_status()
    return response.json()


def fetch_bookings(offset=0, limit=250):
    """Fetch bookings from Plinth API with pagination."""
    response = requests.get(
        "https://app.plinth.org.uk/api/v1/bookings",
        headers={"x-api-key": os.getenv("PLINTH_API_KEY")},
        params={"limit": limit, "offset": offset}
    )
    response.raise_for_status()
    return response.json()
