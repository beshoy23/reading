#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from gtts import gTTS
import os
import re

# --- Data extracted from lib/data/word_list.dart ---
word_data = [
    {'german': 'Mutter', 'category': 'family'},
    {'german': 'Vater', 'category': 'family'},
    {'german': 'Oma', 'category': 'family'},
    {'german': 'Opa', 'category': 'family'},
    {'german': 'Bruder', 'category': 'family'},
    {'german': 'Schwester', 'category': 'family'},
    {'german': 'Onkel', 'category': 'family'},
    {'german': 'Junge', 'category': 'family'},
    {'german': 'gelb', 'category': 'colors'},
    {'german': 'blau', 'category': 'colors'},
    {'german': 'rot', 'category': 'colors'},
    {'german': 'grün', 'category': 'colors'},
    {'german': 'schwarz', 'category': 'colors'},
    {'german': 'weiß', 'category': 'colors'},
    {'german': 'orange', 'category': 'colors'},
    {'german': 'rosa', 'category': 'colors'},
    {'german': 'Arm', 'category': 'bodyparts'},
    {'german': 'Bein', 'category': 'bodyparts'},
    {'german': 'Fuß', 'category': 'bodyparts'},
    {'german': 'Ohr', 'category': 'bodyparts'},
    {'german': 'Auge', 'category': 'bodyparts'},
    {'german': 'Nase', 'category': 'bodyparts'},
    {'german': 'Mund', 'category': 'bodyparts'},
    {'german': 'Hand', 'category': 'bodyparts'},
    {'german': 'Apfel', 'category': 'fruitsandfood'},
    {'german': 'Birne', 'category': 'fruitsandfood'},
    {'german': 'Pfirsich', 'category': 'fruitsandfood'},
    {'german': 'Orange', 'category': 'fruitsandfood'}, # Note: Duplicate word 'Orange' in different category
    {'german': 'Banane', 'category': 'fruitsandfood'},
    {'german': 'Kirsche', 'category': 'fruitsandfood'},
    {'german': 'Melone', 'category': 'fruitsandfood'},
    {'german': 'Erdbeere', 'category': 'fruitsandfood'},
    {'german': 'Gurke', 'category': 'fruitsandfood'},
    {'german': 'Karotte', 'category': 'fruitsandfood'},
    {'german': 'Milch', 'category': 'fruitsandfood'},
    {'german': 'Joghurt', 'category': 'fruitsandfood'},
    {'german': 'Nudeln', 'category': 'fruitsandfood'},
    {'german': 'Tee', 'category': 'fruitsandfood'},
    {'german': 'Saft', 'category': 'fruitsandfood'},
    {'german': 'Delfin', 'category': 'animals'},
    {'german': 'Ente', 'category': 'animals'},
    {'german': 'Elefant', 'category': 'animals'},
    {'german': 'Igel', 'category': 'animals'},
    {'german': 'Hund', 'category': 'animals'},
    {'german': 'Huhn', 'category': 'animals'},
    {'german': 'Löwe', 'category': 'animals'},
    {'german': 'Tiger', 'category': 'animals'},
    {'german': 'Affe', 'category': 'animals'},
    {'german': 'Maus', 'category': 'animals'},
    {'german': 'Bär', 'category': 'animals'},
    {'german': 'Hase', 'category': 'animals'},
    {'german': 'Vogel', 'category': 'animals'},
    {'german': 'Zebra', 'category': 'animals'},
    {'german': 'Giraffe', 'category': 'animals'},
    {'german': 'Kuh', 'category': 'animals'},
    {'german': 'Frosch', 'category': 'animals'},
    {'german': 'Pferd', 'category': 'animals'},
    {'german': 'Schwein', 'category': 'animals'},
    {'german': 'Taube', 'category': 'animals'},
    {'german': 'Rock', 'category': 'clothing'},
    {'german': 'Pullover', 'category': 'clothing'},
    {'german': 'Hut', 'category': 'clothing'},
    {'german': 'Hose', 'category': 'clothing'},
    {'german': 'T-Shirt', 'category': 'clothing'},
    {'german': 'Kleid', 'category': 'clothing'},
    {'german': 'Hemd', 'category': 'clothing'},
    {'german': 'Bluse', 'category': 'clothing'},
    {'german': 'Shorts', 'category': 'clothing'},
    {'german': 'Jacke', 'category': 'clothing'},
    {'german': 'Gürtel', 'category': 'clothing'},
    {'german': 'Lineal', 'category': 'schoolsupplies'},
    {'german': 'Buch', 'category': 'schoolsupplies'},
    {'german': 'Bleistift', 'category': 'schoolsupplies'},
    {'german': 'Mäppchen', 'category': 'schoolsupplies'},
    {'german': 'Radiergummi', 'category': 'schoolsupplies'},
    {'german': 'Füller', 'category': 'schoolsupplies'},
    {'german': 'Pinsel', 'category': 'schoolsupplies'},
    {'german': 'Tafel', 'category': 'schoolsupplies'},
    {'german': 'Auto', 'category': 'objectsthings'},
    {'german': 'Ball', 'category': 'objectsthings'},
    {'german': 'Baum', 'category': 'objectsthings'},
    {'german': 'Chef', 'category': 'objectsthings'},
    {'german': 'Clown', 'category': 'objectsthings'},
    {'german': 'Computer', 'category': 'objectsthings'},
    {'german': 'Dose', 'category': 'objectsthings'},
    {'german': 'Instrument', 'category': 'objectsthings'},
    {'german': 'Insel', 'category': 'objectsthings'},
    {'german': 'Glas', 'category': 'objectsthings'},
    {'german': 'Leiter', 'category': 'objectsthings'},
    {'german': 'Lampe', 'category': 'objectsthings'},
    {'german': 'Motorrad', 'category': 'objectsthings'},
    {'german': 'Puppe', 'category': 'objectsthings'},
    {'german': 'Rutsche', 'category': 'objectsthings'},
    {'german': 'Rasen', 'category': 'objectsthings'},
    {'german': 'Montag', 'category': 'daysofweek'},
    {'german': 'Dienstag', 'category': 'daysofweek'},
    {'german': 'Mittwoch', 'category': 'daysofweek'},
    {'german': 'Donnerstag', 'category': 'daysofweek'},
    {'german': 'Freitag', 'category': 'daysofweek'},
    {'german': 'Samstag', 'category': 'daysofweek'},
    {'german': 'Sonntag', 'category': 'daysofweek'},
    {'german': 'eins', 'category': 'numbers'},
    {'german': 'zwei', 'category': 'numbers'},
    {'german': 'drei', 'category': 'numbers'},
    {'german': 'vier', 'category': 'numbers'},
    {'german': 'fünf', 'category': 'numbers'},
    {'german': 'sechs', 'category': 'numbers'},
    {'german': 'sieben', 'category': 'numbers'},
    {'german': 'acht', 'category': 'numbers'},
    {'german': 'neun', 'category': 'numbers'},
    {'german': 'zehn', 'category': 'numbers'},
]
# --- End Data ---

# Base directory for audio assets
base_output_dir = "assets/audio"

def sanitize_filename(word):
    """Converts German word to a safe lowercase filename."""
    word = word.lower()
    word = word.replace('ä', 'ae')
    word = word.replace('ö', 'oe')
    word = word.replace('ü', 'ue')
    word = word.replace('ß', 'ss')
    # Remove any remaining non-alphanumeric characters (except hyphen)
    word = re.sub(r'[^a-z0-9\-]+', '', word)
    return word

# Keep track of generated filenames to handle duplicates like 'Orange'
generated_files = set()

print("Starting audio generation...")

# Generate and save audio
for item in word_data:
    word_text = item['german']
    category = item['category']

    # Create category subdirectory
    category_dir = os.path.join(base_output_dir, category)
    os.makedirs(category_dir, exist_ok=True)

    # Sanitize filename
    base_filename = sanitize_filename(word_text)
    filename = f"{base_filename}.mp3"
    filepath = os.path.join(category_dir, filename)

    # Handle potential duplicate filenames across categories (e.g., Orange)
    unique_filepath = filepath
    counter = 1
    while unique_filepath in generated_files:
        unique_filename = f"{base_filename}_{counter}.mp3"
        unique_filepath = os.path.join(category_dir, unique_filename)
        counter += 1
        # Safety break
        if counter > 10:
             print(f"Error: Too many duplicates for {base_filename} in {category}. Skipping.")
             break
    if unique_filepath in generated_files and counter > 10:
        continue # Skip if safety break was hit

    filepath = unique_filepath # Use the unique path
    filename = os.path.basename(filepath) # Update filename if changed

    # Check if file already exists (to avoid re-downloading)
    if os.path.exists(filepath):
        print(f"Skipping (already exists): {filepath}")
        generated_files.add(filepath)
        continue

    try:
        # Generate audio using gTTS
        tts = gTTS(text=word_text, lang='de', slow=False) # slow=False for normal speed
        tts.save(filepath)
        generated_files.add(filepath)
        print(f"Saved: {filepath}")
    except Exception as e:
        print(f"Error generating audio for '{word_text}': {e}")

print("Audio generation complete.")
