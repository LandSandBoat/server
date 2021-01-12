-----------------------------------
-- Area: Newton_Movalpolos
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.NEWTON_MOVALPOLOS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET   = 6418, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7050, -- Tallying conquest results...
        COME_CLOSER             = 7231, -- H0000! C0mE cL0SEr! C0mE cL0SEr! CAn'T TrAdE fr0m S0 fAr AwAy!
        MINING_IS_POSSIBLE_HERE = 7239, -- Mining is possible here if you have <item>.
        CHEST_UNLOCKED          = 7254, -- You unlock the chest!
        SHOWMAN_DECLINE         = 7265, -- ... Me no want that. Thing me want not here! It not being here!!!
        SHOWMAN_TRIGGER         = 7266, -- Hey, you there! Muscles nice. You want fight strong one? It cost you. Give me nice item.
        SHOWMAN_ACCEPT          = 7267, -- Fhungaaa!!! The freshyness, the flavoryness! This very nice item! Good luck, then. Try not die. One...two...four...FIIIIIIGHT!!!
        HOMEPOINT_SET           = 7270, -- Home point set!
    },
    mob =
    {
        MIMIC                = 16826564,
        BUGBEAR_MATMAN       = 16826570,
    },
    npc =
    {
        DOOR_OFFSET          = 16826582, -- _0c0 in npc_list
        FURNACE_HATCH_OFFSET = 16826607,
        TREASURE_COFFER      = 16826627,
        MINING               =
        {
            16826621,
            16826622,
            16826623,
            16826624,
            16826625,
            16826626,
        },
    },
}

return zones[tpz.zone.NEWTON_MOVALPOLOS]
