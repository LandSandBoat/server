-----------------------------------
-- Area: Newton_Movalpolos
-----------------------------------
zones = zones or {}

zones[xi.zone.NEWTON_MOVALPOLOS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7061, -- Tallying conquest results...
        COME_CLOSER                   = 7242, -- H0000! C0mE cL0SEr! C0mE cL0SEr! CAn'T TrAdE fr0m S0 fAr AwAy!
        MINING_IS_POSSIBLE_HERE       = 7250, -- Mining is possible here if you have <item>.
        CHEST_UNLOCKED                = 7265, -- You unlock the chest!
        COLLECTOR_SPAWN               = 7274, -- You gently place the <item> on the ground. Suddenly, you hear the clanging sound of armor approaching. It looks like someone is interested in the <item>...
        SHOWMAN_DECLINE               = 7276, -- ... Me no want that. Thing me want not here! It not being here!!!
        SHOWMAN_TRIGGER               = 7277, -- Hey, you there! Muscles nice. You want fight strong one? It cost you. Give me nice item.
        SHOWMAN_ACCEPT                = 7278, -- Fhungaaa!!! The freshyness, the flavoryness! This very nice item! Good luck, then. Try not die. One...two...four...FIIIIIIGHT!!!
        HOMEPOINT_SET                 = 7281, -- Home point set!
    },
    mob =
    {
        SWASHSTOX_BEADBLINKER_PH =
        {
            [16826507] = 16826517, -- 92.145, 15.500, 66.595
            [16826514] = 16826510, -- 88.412, 15.421, -19.950
        },
        MIMIC                    = 16826564,
        BUGBEAR_MATMAN           = 16826570,
        GOBLIN_COLLECTOR         = 16826569,
    },
    npc =
    {
        DOOR_OFFSET          = 16826582, -- _0c0 in npc_list
        FURNACE_HATCH_OFFSET = 16826607,
        TREASURE_COFFER      = 16826627,
        MINING               = GetTableOfIDs('Mining_Point'),
    },
}

return zones[xi.zone.NEWTON_MOVALPOLOS]
