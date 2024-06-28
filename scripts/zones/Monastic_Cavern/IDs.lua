-----------------------------------
-- Area: Monastic Cavern (150)
-----------------------------------
zones = zones or {}

zones[xi.zone.MONASTIC_CAVERN] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7012, -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7064, -- Tallying conquest results...
        ALTAR                         = 7279, -- This appears to be an altar.
        THE_MAGICITE_GLOWS_OMINOUSLY  = 7282, -- The magicite glows ominously.
        CHEST_UNLOCKED                = 7301, -- You unlock the chest!
        ORCISH_OVERLORD_ENGAGE        = 7313, -- Intruders? Get outs here! We gots us some adventurers!
        ORCISH_OVERLORD_DEATH         = 7314, -- Gahahahaha... You fell for our trick. I'm not the big boss. He don't need to be troubled by runty little rarabs like you.
        ORC_KING_ENGAGE               = 7315, -- Ungh? Who are you?  So, you've come to kill big boss Bakgodek? I'll crush your scrawny bones myself!
        ORC_KING_DEATH                = 7316, -- Unghh... Foolish children of Altana. Defeating me won't change anything. There will be others from the north...
    },
    mob =
    {
        ORCISH_OVERLORD               = GetTableOfIDs('Orcish_Overlord')[1], -- NM
        UNDERSTANDING_OVERLORD_OFFSET = GetTableOfIDs('Orcish_Overlord')[2], -- Quest NM
        BUGABOO                       = GetFirstID('Bugaboo'),
        MIMIC                         = GetFirstID('Mimic'),
    },
    npc =
    {
        TREASURE_COFFER = GetFirstID('Treasure_Coffer'),
    },
}

return zones[xi.zone.MONASTIC_CAVERN]
