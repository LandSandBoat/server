-----------------------------------
-- Area: Ordelles Caves (193)
-----------------------------------
zones = zones or {}

zones[xi.zone.ORDELLES_CAVES] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6543,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6549,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6550,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6552,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6563,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6564,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6578,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7160,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7161,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7162,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7171,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7182,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7226,  -- You can't fish here.
        DEVICE_NOT_WORKING            = 7340,  -- The device is not working.
        SYS_OVERLOAD                  = 7349,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 7354,  -- You lost the <item>.
        RUILLONT_INITIAL_DIALOG       = 7363,  -- Confound it! If I only had my sword, I'd cut through these fiends single-handedly...
        PLACE_HANDS_IN_POOL           = 7374,  -- You place your hands into the pool.
        DEW_SLIPS_THROUGH_FINGERS     = 7377,  -- The dew from the stalactite slips through your fingers.
        ALREADY_OBTAINED_DEW          = 7378,  -- You have already obtained the dew.
        CHEST_UNLOCKED                = 7410,  -- You unlock the chest!
        GERWITZS_AXE_DIALOG           = 7432,  -- Mine axe shall rend thy throat!
        GERWITZS_SWORD_DIALOG         = 7433,  -- Mine sword shall pierce thy tongue!
        GERWITZS_SOUL_DIALOG          = 7434,  -- Long have I waited. I will tell all...
        PLAYER_OBTAINS_ITEM           = 8395,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8396,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8397,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8398,  -- You already possess that temporary item.
        NO_COMBINATION                = 8403,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10481, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11557, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        DONGGU              = GetFirstID('Donggu'),
        AGAR_AGAR           = GetFirstID('Agar_Agar'),
        MORBOLGER           = GetFirstID('Morbolger'),
        POLEVIK             = GetFirstID('Polevik'),
        DARK_PUPPET_OFFSET  = GetFirstID('Gerwitzs_Axe'),
        NECROPLASM          = GetFirstID('Necroplasm'),
        APPARATUS_ELEMENTAL = GetTableOfIDs('Air_Elemental')[2], -- Second elemental in the list
        AROMA_LEECH         = GetFirstID('Aroma_Leech'),
    },
    npc =
    {
        TREASURE_CHEST = GetFirstID('Treasure_Chest'),
    },
}

return zones[xi.zone.ORDELLES_CAVES]
