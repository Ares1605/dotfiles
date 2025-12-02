from pykeepass import PyKeePass
from pykeepass import create_database
import sys
import os
from urllib.parse import urlparse, parse_qs

# Read OTP URIs from command line argument
password = sys.argv[1]
otpauths = sys.argv[2].split()

# Create new database
vault_path = os.path.expanduser('~/vault.kdbx')
kp = create_database(vault_path, password=password)

# Create TOTP group
totp_group = kp.add_group(kp.root_group, 'TOTP')

# Add entry for each OTP URI
for otpauth in otpauths:
    parsed = urlparse(otpauth)
    account = parsed.path.lstrip('/')
    params = parse_qs(parsed.query)
    issuer = params.get('issuer', [''])[0]
    
    # Use "Issuer - Account" or just account if no issuer
    title = f"{issuer} - {account}" if issuer else account
    
    # Check if entry exists
    existing = kp.find_entries(title=title, group=totp_group, first=True)
    if existing:
        existing.otp = otpauth
    else:
        entry = kp.add_entry(totp_group, title, username='', password='')
        entry.otp = otpauth

kp.save()
print(f"Processed {len(otpauths)} entries")
