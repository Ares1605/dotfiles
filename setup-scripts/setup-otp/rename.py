from pykeepass import PyKeePass, Entry, Group

def get_totp_group(kp: PyKeePass):
    for group in kp.groups:
        if group.name == "TOTP":
            return group
    raise RuntimeError("Could not find TOTP group in list of groups ({str(kp.groups)})")

def rename_title(e: Entry, totp_group: Group, title: str):

    kp.delete_entry(e)
    kp.add_entry(
        totp_group, title, '',
        '', e.url, e.notes,
        e.expiry_time, e.tags, e.otp,
        e.icon, force_creation=True)

def output_entries(kp: PyKeePass):
    for i in range(len(kp.entries)):
        entry = kp.entries[i]
        print(f"{i + 1}. {entry.title}")

kp = PyKeePass('/home/ares/vault.kdbx', password='1324')
totp_group = get_totp_group(kp)
while True:
    output_entries(kp)
    print()
    choice_index = int(input("Choose the number to rename: ")) - 1
    new_title = input(f"Name to rename {kp.entries[choice_index]} to: ")
    rename_title(kp.entries[choice_index], totp_group, new_title)
    kp.save()
    print()
    print()
