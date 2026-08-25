# Useful SQL Queries

## Resetting an account password

```sql
UPDATE accounts SET password = PASSWORD("NEW_PASSWORD_HERE") WHERE login = 'ACCOUNT_NAME_HERE';
```

* Note: This function is deprecated in stock MySQL*

## Mail an item to all characters on the entire server

```sql
INSERT INTO delivery_box (charid, charname, box, slot, itemid, itemsubid, quantity, extra, senderid, sender, received, sent)
  SELECT chars.charid, chars.charname, 1, 0, ItemIdHere, 0, 1, NULL, 0, 'The MHMU', 0, 0 FROM chars;
```

## Mail an item to one character

```sql
INSERT INTO delivery_box VALUES (charid, 'name here', 1, 0, itemid, 0, quantity, NULL, 0, 'The MHMU', 0, 0);
```

## Find All Mobs Without Pets

```sql
select ms.mobid, ms.mobname, pt.pet_offset 
from mob_spawn_points ms
inner join mob_groups gr on ms.groupid = gr.groupid and gr.zoneid = ((ms.mobid >> 12) & 0xFFF)
inner join mob_pools pl on gr.poolid = pl.poolid 
left join mob_pets pt on pt.mob_mobid = ms.mobid 
where pl.mJob IN (9, 14, 15, 18) and pt.pet_offset IS NULL;
```

## Expansion icons

Icons are set per-account now, in the accounts table. Change the default value in the table design to the value you want everyone to have (without having to set it every time someone creates an account).

```txt
Expansion Icons - 2 Bytes

Byte 1 - Zilart to A Shantotto Ascension
00000000 Bit0 - Not Used - Original FFXI bit
00000010 Bit1 - Enables Rise of Zilart Icon
00000100 Bit2 - Enables Chains of Promathia Icon
00001000 Bit3 - Enables Treasures of Aht Urhgan Icon
00010000 Bit4 - Enables Wings of The Goddess
00100000 Bit5 - Enables A Crystalline Prophecy Icon
01000000 Bit6 - Enables A Moogle Kupod'Etat Icon
10000000 Bit7 - Enables A Shantotto Ascension Icon

Byte 2 - Vision of Abyssea to Seekers of Adoulin
00000001 Bit0 - Enables Vision of Abyssea
00000010 Bit1 - Enables Scars of Abyssea
00000100 Bit2 - Enables Heroes of Abyssea
00001000 Bit3 - Enables Seekers of Adoulin
00010000 Bit4 - Not Used - Future expansion
00100000 Bit5 - Not Used - Future expansion
01000000 Bit6 - Not Used - Future expansion
10000000 Bit7 - Not Used - Future expansion
```

It's a decimal representation of multiple bytes. Lets look at them in binary, where it's all on/off (one and zero):

so our default value of 4094 = 0000111111111110 (everything except the "Not Used" bits). You can use almost any calculator to swap between these formats if you need to.

## Enable ZONEMISC features everywhere

In this example, we'll enable MISC_YELL everywhere. You can see these flags in zone.h.

```cpp
MISC_YELL = 0x0400, // Send and receive /yell commands
```

0x0400 is hex for 1024, so we'll use that value going forwards. The following query will add the flag 1024 to any zone misc that doesn't already have it set.

```sql
UPDATE xidb.zone_settings 
SET 
    misc = misc + 1024
WHERE
    NOT(misc & 1024);
```

## Show contents of players' bazaars

```sql
SELECT
    c.charname,
    ci.quantity,
    ci.bazaar,
    COALESCE(ite.`name`, itb.`name`, itf.`name`, itp.`name`, itw.`name`) AS itemname,
    z.`name` AS "last_seen_zone",
    acc_sess.accid IS NOT NULL AS "currently_online"
FROM char_inventory AS ci
LEFT JOIN item_equipment AS ite ON ci.itemid = ite.itemid
LEFT JOIN item_basic AS itb ON ci.itemid = itb.itemid
LEFT JOIN item_furnishing AS itf ON ci.itemid = itf.itemid
LEFT JOIN item_puppet AS itp ON ci.itemid = itp.itemid
LEFT JOIN item_weapon AS itw ON ci.itemid = itw.itemid
LEFT JOIN chars AS c on c.charid = ci.charid
LEFT JOIN zone_settings AS z on c.pos_zone = z.zoneid
LEFT JOIN accounts_sessions AS acc_sess on c.accid = acc_sess.accid
WHERE ci.bazaar > 0;
```

```txt
Testo    1    100        adventurer_coupon    Southern_San_dOria    1
Testo    1    99999999   kraken_club          Southern_San_dOria    1
```
