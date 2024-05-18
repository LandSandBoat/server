-----------------------------------
-- Area: Castle_Zvahl_Baileys
-----------------------------------
zones = zones or {}

zones[xi.zone.CASTLE_ZVAHL_BAILEYS] =
{
    text =
    {
        CONQUEST_BASE                 = 0,    -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6543, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6549, -- Obtained: <item>.
        GIL_OBTAINED                  = 6550, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6552, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6563, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6564, -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6578, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7160, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7161, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7162, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7182, -- Your party is unable to participate because certain members' levels are restricted.
        CHEST_UNLOCKED                = 7238, -- You unlock the chest!
        MOBLIN_EARPLUG                = 7564, -- You see a moblin earplug on the ground. Could Zeelok have met his end here?
        MINIONS_ATTACK                = 7565, -- Marquis Andrealphus and his minions attack!
        YOU_FIND_NOTHING              = 7566, -- You find nothing.
        BEGONE                        = 7567, -- Insolent adventurer! Begone from these halls!
        COMMON_SENSE_SURVIVAL         = 7613, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        MARQUIS_SABNOCK       = GetFirstID('Marquis_Sabnock'),
        LIKHO                 = GetFirstID('Likho'),
        MARQUIS_ALLOCEN       = GetFirstID('Marquis_Allocen'),
        MARQUIS_AMON          = GetFirstID('Marquis_Amon'),
        DUKE_HABORYM          = GetFirstID('Duke_Haborym'),
        GRAND_DUKE_BATYM      = GetFirstID('Grand_Duke_Batym'),
        DARK_SPARK            = GetFirstID('Dark_Spark'),
        MIMIC                 = GetFirstID('Mimic'),
        DEMON_YOU_KNOW_OFFSET = GetFirstID('Marquis_Andrealphus'),
    },
    npc =
    {
        TORCH_OFFSET    = GetFirstID('Torch'),
        TREASURE_CHEST  = GetFirstID('Treasure_Chest'),
        TREASURE_COFFER = GetFirstID('Treasure_Coffer'),
    },
}

return zones[xi.zone.CASTLE_ZVAHL_BAILEYS]
