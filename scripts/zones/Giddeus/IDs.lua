-----------------------------------
-- Area: Giddeus
-----------------------------------
zones = zones or {}

zones[xi.zone.GIDDEUS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6405, -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7064, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7223, -- You can't fish here.
        OFFERED_UP_KEY_ITEM           = 7348, -- Offered up key item: <keyitem>!
        SPRING_FILL_UP                = 7369, -- You fill your flask with water.
        SPRING_DEFAULT                = 7370, -- Sparkling clear water bubbles up from the ground. If you have a container, you can fill it here.
        CHEST_UNLOCKED                = 7420, -- You unlock the chest!
        HARVESTING_IS_POSSIBLE_HERE   = 7428, -- Harvesting is possible here if you have <item>.
        HOMEPOINT_SET                 = 7456, -- Home point set!
    },
    mob =
    {
        HOO_MJUU_THE_TORRENT   = GetFirstID('Hoo_Mjuu_the_Torrent'),
        JUU_DUZU_THE_WHIRLWIND = GetFirstID('Juu_Duzu_the_Whirlwind'),
        VUU_PUQU_THE_BEGUILER  = GetFirstID('Vuu_Puqu_the_Beguiler'),
        VAA_HUJA_THE_ERUDITE   = GetFirstID('Vaa_Huja_the_Erudite'),
    },
    npc =
    {
        TREASURE_CHEST = GetFirstID('Treasure_Chest'),
        HARVESTING     = GetTableOfIDs('Harvesting_Point'),
    },
}

return zones[xi.zone.GIDDEUS]
