# Put research spells on vendors
spells = {
    # Necromancer
    "Voice Graft": "Restless Bones",
    "Hungry Earth": "Restless Bones",
    "Harmshield": "Animate Dead",
    "Haunting Corpse": "Rapacious Subvention",
    "Intensify Death": "Rapacious Subvention",
    "Renew Bones": "Summon Dead",
    "Vampiric Curse": "Summon Dead",
    "Call of Bones": "Venom of the Snake",
    "Invoke Shadow": "Venom of the Snake",
    "Surge of Enfeeblement": "Venom of the Snake",
    "Chilling Embrace": "Drain Spirit",
    "Malignant Dead": "Drain Spirit",
    "Cackling Bones": "Ignite Bones",
    "Dead Man Floating": "Ignite Bones",
    "Incinerate Bones": "Ignite Bones",
    "Corporeal Empathy": "Ignite Bones",
    "Bond of Death": "Cajole Undead",
    "Dead Men Floating": "Cajole Undead",
    "Invoke Death": "Cajole Undead",
    "Lich": "Cajole Undead",
    "Paralyzing Earth": "Cajole Undead",
    # Enchanter
    "Mesmerization": "Sanity Warp",
    "Berserker Strength": "Benevolence",
    "Color Shift": "Benevolence",
    "Strip Enchantment": "Rune II",
    "Tepid Deeds": "Rune II",
    "Feedback": "Augmentation",
    "Insipid Weakness": "Cast Sight",
    "Mana Sieve": "Cast Sight",
    "Radiant Visage": "Cast Sight",
    "Gravity Flux": "Celerity",
    "Mind Wipe": "Celerity",
    "Wandering Mind": "Celerity",
    "Boon of the Garou": "Discordant Mind",
    "Color Skew": "Discordant Mind",
    "Pillage Enchantment": "Discordant Mind",
    "Shiftless Deeds": "Discordant Mind",
    "Allure": "Berserker Spirit",
    "Blanket of Forgetfulness": "Berserker Spirit",
    "Reoccurring Amnesia": "Berserker Spirit",
    # Magician
    "Cornucopia": "Summoning: Earth",
    "Everfount": "Summoning: Earth",
    "Summoning: Air": "Summoning: Earth",
    "Summoning: Fire": "Summoning: Earth",
    "Summoning: Water": "Summoning: Earth",
    "Greater Summoning: Earth": "Greater Summoning: Air",
    "Greater Summoning: Water": "Greater Summoning: Air",
    "Minor Conjuration: Air": "Minor Conjuration: Earth",
    "Minor Conjuration: Fire": "Minor Conjuration: Earth",
    "Lesser Conjuration: Earth": "Lesser Conjuration: Fire",
    "Lesser Conjuration: Water": "Lesser Conjuration: Fire",
    "Conjuration: Air": "Conjuration: Fire",
    "Conjuration: Earth": "Conjuration: Fire",
    "Conjuration: Water": "Conjuration: Fire",
    "Elemental Maelstrom": "Conjuration: Fire",
    "Greater Conjuration: Air": "Greater Conjuration: Earth",
    "Greater Conjuration: Fire": "Greater Conjuration: Earth",
    "Greater Conjuration: Water": "Greater Conjuration: Earth",
    # Wizard
    "Pillar of Fire": "Lightning Bolt",
    "Fire Spiral of Al'Kabor": "Force Snap",
    "Cast Force": "Frost Shock",
    "Column of Lightning": "Frost Shock",
    "Lightning Storm": "Frost Shock",
    "Energy Storm": "Inferno Shock",
    "Shock Spiral of Al'Kabor": "Inferno Shock",
    "Circle of Force": "Ice Shock",
    "Lava Storm": "Ice Shock",
    "Thunderclap": "Ice Shock",
    "Force Spiral of Al'Kabor": "West Portal",
    "Invisibility to Undead": "West Portal",
    "Gravity Flux": "Force Strike",
    "Enticement of Flame": "Force Strike",
    "Ice Comet": "Rend",
    "Supernova": "Rend",
    "Wrath of Al'Kabor": "Rend",
}

import mysql.connector

cnx = mysql.connector.connect(
    user="username", password="password", host="127.0.0.1", database="eqemu"
)

spell_id_cache = {}


def get_spell_id(name):
    if name in spell_id_cache:
        return spell_id_cache[name]

    with cnx.cursor() as cursor:
        cursor.execute("SELECT id FROM items WHERE Name = %s", ("Spell: %s" % name,))

        rows = cursor.fetchall()
        if len(rows) == 0 or len(rows[0]) == 0:
            breakpoint()
        id = rows[0][0]

    spell_id_cache[name] = id
    return id


def get_vendors(spell):
    spell_id = get_spell_id(spell)

    with cnx.cursor() as cursor:
        cursor.execute(
            "SELECT merchantid FROM merchantlist WHERE item = %s", (spell_id,)
        )

        return [row[0] for row in cursor.fetchall()]


def get_max_slot(vendor):
    with cnx.cursor() as cursor:
        cursor.execute(
            "SELECT MAX(slot) FROM merchantlist WHERE merchantid = %s" % vendor
        )

        return int(cursor.fetchall()[0][0])


def add_spell(vendor, spell):
    next_slot = get_max_slot(vendor) + 1
    spell_id = get_spell_id(spell)

    with cnx.cursor() as cursor:
        cursor.execute("SELECT COUNT(*) FROM merchantlist WHERE merchantid = %s AND item = %s", (vendor, spell_id));
        exists = cursor.fetchall()[0][0]
        if exists:
            return

        cursor.execute(
            "INSERT INTO merchantlist(merchantid, slot, item, faction_required) VALUES (%s, %s, %s, -1100)",
            (vendor, next_slot, spell_id)
        )
    cnx.commit()


breakpoint()
for research_spell, location_spell in spells.items():
    vendors = get_vendors(location_spell)
    for vendor in vendors:
        add_spell(vendor, research_spell)

cnx.close()