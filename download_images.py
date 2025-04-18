import requests
import os
import json
from dotenv import load_dotenv
import time
from pathlib import Path
import sys

# Load environment variables from .env file
load_dotenv()

# --- Configuration ---
UNSPLASH_ACCESS_KEY = os.getenv("UNSPLASH_ACCESS_KEY")
API_URL = "https://api.unsplash.com/search/photos"
HEADERS = {"Authorization": f"Client-ID {UNSPLASH_ACCESS_KEY}"} if UNSPLASH_ACCESS_KEY else {}
IMAGE_ROOT_DIR = Path("assets/images")
BATCH_SIZE = 30 # Max requests per active period
WAIT_TIME_SECONDS = 1800 # 30 minutes
INTER_REQUEST_DELAY = 2 # Seconds between requests in a batch

# --- Word Data ---
# (Keeping WORDS_DATA definition as before - omitted here for brevity,
#  but it should be included in the actual file)
WORDS_DATA = [
    # Family
    {"german": "Mutter", "english": "Mother", "path": "family/mutter.png"},
    {"german": "Vater", "english": "Father", "path": "family/vater.png"},
    {"german": "Oma", "english": "Grandma", "path": "family/oma.png"},
    {"german": "Opa", "english": "Grandpa", "path": "family/opa.png"},
    {"german": "Bruder", "english": "Brother", "path": "family/bruder.png"},
    {"german": "Schwester", "english": "Sister", "path": "family/schwester.png"},
    {"german": "Onkel", "english": "Uncle", "path": "family/onkel.png"},
    {"german": "Junge", "english": "Boy", "path": "family/junge.png"},
    # Colors
    {"german": "gelb", "english": "yellow color", "path": "colors/gelb.png"},
    {"german": "blau", "english": "blue color", "path": "colors/blau.png"},
    {"german": "rot", "english": "red color", "path": "colors/rot.png"},
    {"german": "grün", "english": "green color", "path": "colors/grun.png"},
    {"german": "schwarz", "english": "black color", "path": "colors/schwarz.png"},
    {"german": "weiß", "english": "white color", "path": "colors/weiss.png"},
    {"german": "orange", "english": "orange color", "path": "colors/orange.png"},
    {"german": "rosa", "english": "pink color", "path": "colors/rosa.png"},
    # Body Parts
    {"german": "Arm", "english": "arm", "path": "bodyparts/arm.png"},
    {"german": "Bein", "english": "leg", "path": "bodyparts/bein.png"},
    {"german": "Fuß", "english": "foot", "path": "bodyparts/fuss.png"},
    {"german": "Ohr", "english": "ear", "path": "bodyparts/ohr.png"},
    {"german": "Auge", "english": "eye", "path": "bodyparts/auge.png"},
    {"german": "Nase", "english": "nose", "path": "bodyparts/nase.png"},
    {"german": "Mund", "english": "mouth", "path": "bodyparts/mund.png"},
    {"german": "Hand", "english": "hand", "path": "bodyparts/hand.png"},
    # Fruits and Food
    {"german": "Apfel", "english": "apple", "path": "fruitsandfood/apfel.png"},
    {"german": "Birne", "english": "pear", "path": "fruitsandfood/birne.png"},
    {"german": "Pfirsich", "english": "peach", "path": "fruitsandfood/pfirsich.png"},
    {"german": "Orange", "english": "orange fruit", "path": "fruitsandfood/orange.png"},
    {"german": "Banane", "english": "banana", "path": "fruitsandfood/banane.png"},
    {"german": "Kirsche", "english": "cherry", "path": "fruitsandfood/kirsche.png"},
    {"german": "Melone", "english": "melon", "path": "fruitsandfood/melone.png"},
    {"german": "Erdbeere", "english": "strawberry", "path": "fruitsandfood/erdbeere.png"},
    {"german": "Gurke", "english": "cucumber", "path": "fruitsandfood/gurke.png"},
    {"german": "Karotte", "english": "carrot", "path": "fruitsandfood/karotte.png"},
    {"german": "Milch", "english": "milk", "path": "fruitsandfood/milch.png"},
    {"german": "Joghurt", "english": "yogurt", "path": "fruitsandfood/joghurt.png"},
    {"german": "Nudeln", "english": "pasta", "path": "fruitsandfood/nudeln.png"},
    {"german": "Tee", "english": "tea", "path": "fruitsandfood/tee.png"},
    {"german": "Saft", "english": "juice", "path": "fruitsandfood/saft.png"},
    # Animals
    {"german": "Delfin", "english": "dolphin", "path": "animals/delfin.png"},
    {"german": "Ente", "english": "duck", "path": "animals/ente.png"},
    {"german": "Elefant", "english": "elephant", "path": "animals/elefant.png"},
    {"german": "Igel", "english": "hedgehog", "path": "animals/igel.png"},
    {"german": "Hund", "english": "dog", "path": "animals/hund.png"},
    {"german": "Huhn", "english": "chicken", "path": "animals/huhn.png"},
    {"german": "Löwe", "english": "lion", "path": "animals/lowe.png"},
    {"german": "Tiger", "english": "tiger", "path": "animals/tiger.png"},
    {"german": "Affe", "english": "monkey", "path": "animals/affe.png"},
    {"german": "Maus", "english": "mouse", "path": "animals/maus.png"},
    {"german": "Bär", "english": "bear", "path": "animals/bar.png"},
    {"german": "Hase", "english": "rabbit", "path": "animals/hase.png"},
    {"german": "Vogel", "english": "bird", "path": "animals/vogel.png"},
    {"german": "Zebra", "english": "zebra", "path": "animals/zebra.png"},
    {"german": "Giraffe", "english": "giraffe", "path": "animals/giraffe.png"},
    {"german": "Kuh", "english": "cow", "path": "animals/kuh.png"},
    {"german": "Frosch", "english": "frog", "path": "animals/frosch.png"},
    {"german": "Pferd", "english": "horse", "path": "animals/pferd.png"},
    {"german": "Schwein", "english": "pig", "path": "animals/schwein.png"},
    {"german": "Taube", "english": "pigeon", "path": "animals/taube.png"},
    # Clothing
    {"german": "Rock", "english": "skirt", "path": "clothing/rock.png"},
    {"german": "Pullover", "english": "sweater", "path": "clothing/pullover.png"},
    {"german": "Hut", "english": "hat", "path": "clothing/hut.png"},
    {"german": "Hose", "english": "pants", "path": "clothing/hose.png"},
    {"german": "T-Shirt", "english": "T-shirt", "path": "clothing/tshirt.png"},
    {"german": "Kleid", "english": "dress", "path": "clothing/kleid.png"},
    {"german": "Hemd", "english": "shirt", "path": "clothing/hemd.png"},
    {"german": "Bluse", "english": "blouse", "path": "clothing/bluse.png"},
    {"german": "Shorts", "english": "shorts", "path": "clothing/shorts.png"},
    {"german": "Jacke", "english": "jacket", "path": "clothing/jacke.png"},
    {"german": "Gürtel", "english": "belt", "path": "clothing/gurtel.png"},
    # School Supplies
    {"german": "Lineal", "english": "ruler", "path": "schoolsupplies/lineal.png"},
    {"german": "Buch", "english": "book", "path": "schoolsupplies/buch.png"},
    {"german": "Bleistift", "english": "pencil", "path": "schoolsupplies/bleistift.png"},
    {"german": "Mäppchen", "english": "pencil case", "path": "schoolsupplies/mappchen.png"},
    {"german": "Radiergummi", "english": "eraser", "path": "schoolsupplies/radiergummi.png"},
    {"german": "Füller", "english": "fountain pen", "path": "schoolsupplies/fuller.png"},
    {"german": "Pinsel", "english": "paintbrush", "path": "schoolsupplies/pinsel.png"},
    {"german": "Tafel", "english": "chalkboard", "path": "schoolsupplies/tafel.png"},
    # Objects/Things
    {"german": "Auto", "english": "car", "path": "objectsthings/auto.png"},
    {"german": "Ball", "english": "ball", "path": "objectsthings/ball.png"},
    {"german": "Baum", "english": "tree", "path": "objectsthings/baum.png"},
    {"german": "Chef", "english": "boss", "path": "objectsthings/chef.png"},
    {"german": "Clown", "english": "clown", "path": "objectsthings/clown.png"},
    {"german": "Computer", "english": "computer", "path": "objectsthings/computer.png"},
    {"german": "Dose", "english": "can", "path": "objectsthings/dose.png"},
    {"german": "Instrument", "english": "musical instrument", "path": "objectsthings/instrument.png"},
    {"german": "Insel", "english": "island", "path": "objectsthings/insel.png"},
    {"german": "Glas", "english": "glass", "path": "objectsthings/glas.png"},
    {"german": "Leiter", "english": "ladder", "path": "objectsthings/leiter.png"},
    {"german": "Lampe", "english": "lamp", "path": "objectsthings/lampe.png"},
    {"german": "Motorrad", "english": "motorcycle", "path": "objectsthings/motorrad.png"},
    {"german": "Puppe", "english": "doll", "path": "objectsthings/puppe.png"},
    {"german": "Rutsche", "english": "slide", "path": "objectsthings/rutsche.png"},
    {"german": "Rasen", "english": "lawn", "path": "objectsthings/rasen.png"},
    # Days of the Week
    {"german": "Montag", "english": "Monday", "path": "daysofweek/montag.png"},
    {"german": "Dienstag", "english": "Tuesday", "path": "daysofweek/dienstag.png"},
    {"german": "Mittwoch", "english": "Wednesday", "path": "daysofweek/mittwoch.png"},
    {"german": "Donnerstag", "english": "Thursday", "path": "daysofweek/donnerstag.png"},
    {"german": "Freitag", "english": "Friday", "path": "daysofweek/freitag.png"},
    {"german": "Samstag", "english": "Saturday", "path": "daysofweek/samstag.png"},
    {"german": "Sonntag", "english": "Sunday", "path": "daysofweek/sonntag.png"},
    # Numbers
    {"german": "eins", "english": "number one", "path": "numbers/eins.png"},
    {"german": "zwei", "english": "number two", "path": "numbers/zwei.png"},
    {"german": "drei", "english": "number three", "path": "numbers/drei.png"},
    {"german": "vier", "english": "number four", "path": "numbers/vier.png"},
    {"german": "fünf", "english": "number five", "path": "numbers/funf.png"},
    {"german": "sechs", "english": "number six", "path": "numbers/sechs.png"},
    {"german": "sieben", "english": "number seven", "path": "numbers/sieben.png"},
    {"german": "acht", "english": "number eight", "path": "numbers/acht.png"},
    {"german": "neun", "english": "number nine", "path": "numbers/neun.png"},
    {"german": "zehn", "english": "number ten", "path": "numbers/zehn.png"},
]

# --- Status Constants ---
SUCCESS = 0
FAILURE = 1
RATE_LIMIT = 2

# --- Functions ---
def download_image(url, filepath):
    """Downloads an image from a URL and saves it to a filepath."""
    try:
        response = requests.get(url, stream=True, timeout=20) # Slightly longer timeout for download
        response.raise_for_status()
        filepath.parent.mkdir(parents=True, exist_ok=True)
        with open(filepath, 'wb') as f:
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)
        # print(f"   ✅ Saved: {filepath}") # Keep console cleaner during long runs
        return True
    except requests.exceptions.RequestException as e:
        print(f"   ❌ Error downloading {url}: {e}")
    except IOError as e:
        print(f"   ❌ Error saving file {filepath}: {e}")
    return False

def attempt_download(word_info):
    """Attempts to download a single image, returning status."""
    search_term = word_info["english"]
    german_word = word_info["german"] # For logging
    relative_path = word_info["path"]
    output_path = IMAGE_ROOT_DIR / relative_path

    print(f"🔍 Attempting download for '{search_term}' ({german_word}) -> {output_path}...")
    params = {
        "query": search_term,
        "per_page": 1,
        "orientation": "squarish"
    }
    try:
        response = requests.get(API_URL, headers=HEADERS, params=params, timeout=15)
        response.raise_for_status() # Raises HTTPError for bad responses (4xx or 5xx)
        data = response.json()

        # Log remaining requests
        remaining_str = response.headers.get('X-Ratelimit-Remaining')
        if remaining_str:
             try:
                 print(f"   (API Requests Remaining: {int(remaining_str)})")
             except ValueError: pass # Ignore if header is weird

        if data["results"]:
            image_url = data["results"][0]["urls"]["regular"]
            if download_image(image_url, output_path):
                 print(f"   ✅ Download successful for '{search_term}'")
                 return SUCCESS
            else:
                 print(f"   ❌ Failed to save image file for '{search_term}'")
                 return FAILURE
        else:
            print(f"   ❓ No results found on Unsplash for '{search_term}'")
            return FAILURE # Treat no results as failure for this attempt

    except requests.exceptions.Timeout:
         print(f"   ❌ Timeout connecting to Unsplash API for '{search_term}'")
         return FAILURE
    except requests.exceptions.HTTPError as e:
        if e.response.status_code == 403:
             print(f"   🚫 Rate limit hit for '{search_term}' (403 Forbidden).")
             return RATE_LIMIT
        else:
             print(f"   ❌ HTTP Error for '{search_term}': {e}")
             return FAILURE
    except requests.exceptions.RequestException as e: # Other network errors
        print(f"   ❌ Unsplash API Request Error for '{search_term}': {e}")
        return FAILURE
    except Exception as e: # Catch other potential errors (JSON parsing, etc.)
        print(f"   ❌ Unexpected error during download attempt for '{search_term}': {e}")
        return FAILURE

# --- Main Execution ---
if __name__ == "__main__":
    print("--- Unsplash Image Download Script ---")
    if not UNSPLASH_ACCESS_KEY:
        print("\n🛑 Error: UNSPLASH_ACCESS_KEY not found in environment variables.")
        print("   Please ensure you have a .env file with the key defined.")
        sys.exit(1)

    print(f"Using Access Key: ...{UNSPLASH_ACCESS_KEY[-4:]}")
    print(f"Saving images to: {IMAGE_ROOT_DIR.resolve()}")
    print(f"Batch size: {BATCH_SIZE}, Wait time: {WAIT_TIME_SECONDS / 60:.0f} minutes")

    # Ensure the root image directory exists
    IMAGE_ROOT_DIR.mkdir(parents=True, exist_ok=True)

    # 1. Initialization: Identify missing images
    missing_images = []
    for word in WORDS_DATA:
        output_path = IMAGE_ROOT_DIR / word["path"]
        # Also check if the path points to the placeholder, treat as missing if so
        if not output_path.exists() or output_path.name == 'placeholder.svg':
             # Check actual existence again in case placeholder was manually replaced
             actual_path_str = word['path'].replace('placeholder.svg', word['german'].lower() + '.png') # Approximate original name
             actual_path = IMAGE_ROOT_DIR / Path(actual_path_str)
             if not actual_path.exists():
                missing_images.append(word)


    if not missing_images:
        print("\n✅ All images seem to be downloaded.")
        sys.exit(0)
    else:
        print(f"\nℹ️ Found {len(missing_images)} missing or placeholder images. Starting download loop...")

    # 2. Main Loop
    while missing_images:
        print(f"\n--- Starting new batch attempt ({len(missing_images)} images remaining) ---")
        requests_this_batch = 0
        rate_limit_hit_in_batch = False

        # Create a copy for iteration to allow safe removal from original list
        # Only take up to BATCH_SIZE for this attempt's list
        current_batch_list = missing_images[:BATCH_SIZE]

        for word_info in current_batch_list:
            # Check if the word is still in the main missing list
            if word_info not in missing_images:
                continue # Already processed or removed

            status = attempt_download(word_info)

            if status == RATE_LIMIT:
                rate_limit_hit_in_batch = True
                break # Exit the inner for loop immediately

            elif status == FAILURE:
                print(f"   -> Skipping download for {word_info['english']} after error.")
                # Decide whether to remove or keep for retry later. For simplicity, remove.
                missing_images.remove(word_info)

            elif status == SUCCESS:
                # Update path in original WORDS_DATA if it was a placeholder? No, user does that.
                missing_images.remove(word_info) # Remove from original list
                requests_this_batch += 1

            # Short delay between requests within the batch
            print(f"   ...waiting {INTER_REQUEST_DELAY} seconds...")
            time.sleep(INTER_REQUEST_DELAY)

        # --- After finishing batch attempt (or breaking due to rate limit) ---
        if rate_limit_hit_in_batch:
            print(f"\n⏳ Rate limit hit. Waiting for {WAIT_TIME_SECONDS / 60:.0f} minutes...")
            time.sleep(WAIT_TIME_SECONDS)
        elif missing_images: # If batch finished normally AND images still missing
             print(f"\n--- Batch attempt finished ({requests_this_batch} successful). Waiting {WAIT_TIME_SECONDS / 60:.0f} minutes before next attempt... ---")
             time.sleep(WAIT_TIME_SECONDS)
        # If missing_images is now empty, the outer while loop will terminate on the next check

    print("\n✅ Download loop finished. All images processed or skipped due to errors.")
    sys.exit(0)
