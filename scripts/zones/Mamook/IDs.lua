-----------------------------------
-- Area: Mamook
-----------------------------------
zones = zones or {}

zones[xi.zone.MAMOOK] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7069, -- You can't fish here.
        GATE_IS_FIRMLY_CLOSED         = 7329, -- The gate is firmly closed...
        DOOR_IS_LOCKED                = 7479, -- The door is locked. You might be able to open it with %.
        RED_BELL_LOCKED               = 7497, -- Looking closely, you see a red bell-type symbol painted on the wood...
        DOOR_IS_LOCKED2               = 7480, -- The door is locked. You might be able to open it with % or %.
        KEY_BREAKS                    = 7481, -- The <item> breaks!
        YOU_UNLOCK_DOOR               = 7484, -- You unlock the door from the inside.
        LOCK_SUCCESS                  = 7485, -- <name> successfully opened the lock with the <item>!
        LOCK_FAIL                     = 7486, -- <name> failed to open the lock with the <item>...
        LOGGING_IS_POSSIBLE_HERE      = 7555, -- Logging is possible here if you have <item>.
        PARTY_MEMBERS_HAVE_FALLEN     = 7912, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7919, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        NOTHING_OUT_OF_ORDINARY       = 7045, -- Nothing out of the ordinary happens.
        IMPENDING_BATTLE              = 8080, -- You feel the rush of impending battle!
        PECULIAR_SENSATION            = 8138, -- <player> is overcome by a peculiar sensation.
        KEYHOLE_THREE_COLORS          = 8144, -- There is a giant keyhole in the gate here. You can see smearings of black, silver, brown, and other colors around the keyhole.
        KEYS_SHATTER                  = 8145, -- The % shatters... The % shatters... The % shatters...
        NUMEROUS_STRANDS              = 8685, -- Numerous strands of hair are scattered all over...
        SICKLY_SWEET                  = 8687, -- A sickly sweet fragrance pervades the air...
        DRAWS_NEAR                    = 8709, -- Something draws near!
        COMMON_SENSE_SURVIVAL         = 9580, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        ZIZZY_ZILLAH           = GetFirstID('Zizzy_Zillah'),
        FIREDANCE_MAGMAAL_JA   = GetFirstID('Firedance_Magmaal_Ja'),
        GULOOL_JA_JA           = GetFirstID('Gulool_Ja_Ja'),
        CHAMROSH               = GetFirstID('Chamrosh'),
        IRIRI_SAMARIRI         = GetFirstID('Iriri_Samariri'),
        POROGGO_CASANOVA       = GetFirstID('Poroggo_Casanova'),
        MAMOOL_JA              = GetFirstID('Mamool_Ja'),
        MIKILULU               = GetFirstID('Mikilulu'),
        MIKIRURU               = GetFirstID('Mikiruru'),
        NIKILULU               = GetFirstID('Nikilulu'),
        MIKILURU               = GetFirstID('Mikiluru'),
        MIKIRULU               = GetFirstID('Mikirulu'),
        HUNDRED_FACE_HAPOOL_JA = GetFirstID('Hundredfaced_Hapool_Ja'),
    },
    npc =
    {
        LOGGING      = GetTableOfIDs('Logging_Point'),
        QUEST_LIQUID = GetTableOfIDs('Viscous_Liquid')[6], -- Used in quest Two Horn the Savage
    },
}

return zones[xi.zone.MAMOOK]
