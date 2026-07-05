-----------------------------------
-- Area: Monastic Cavern (150)
-----------------------------------
zones = zones or {}

zones[xi.zone.MONASTIC_CAVERN] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6408, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7016, -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072, -- Tallying conquest results...
        REGION_POINTS_SANDORIA        = 7137, -- San d'Oria's region points have increased!
        ALTAR                         = 7287, -- This appears to be an altar.
        THE_MAGICITE_GLOWS_OMINOUSLY  = 7290, -- The magicite glows ominously.
        CHEST_UNLOCKED                = 7309, -- You unlock the chest!
        ORCISH_OVERLORD_ENGAGE        = 7321, -- Intruders? Get outs here! We gots us some adventurers!
        ORCISH_OVERLORD_DEATH         = 7322, -- Gahahahaha... You fell for our trick. I'm not the big boss. He don't need to be troubled by runty little rarabs like you.
        ORC_KING_ENGAGE               = 7323, -- Ungh? Who are you? So, you've come to kill big boss Bakgodek? I'll crush your scrawny bones myself!
        ORC_KING_DEATH                = 7324, -- Unghh... Foolish children of Altana. Defeating me won't change anything. There will be others from the north...
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
