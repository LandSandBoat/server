-----------------------------------
-- Area: Palborough Mines (143)
-----------------------------------
zones = zones or {}

zones[xi.zone.PALBOROUGH_MINES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED            = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                      = 6390, -- Obtained: <item>.
        GIL_OBTAINED                       = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED                   = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY            = 6404, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING                = 6405, -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET              = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS                = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY            = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                       = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED               = 7012, -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED      = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                      = 7064, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET             = 7223, -- You can't fish here.
        THE_MACHINE_SEEMS_TO_BE_WORKING    = 7383, -- The machine seems to be working, but you cannot discern its purpose.
        SOMETHING_FALLS_OUT_OF_THE_MACHINE = 7386, -- Something falls out of the machine!
        YOU_CANT_CARRY_ANY_MORE_ITEMS      = 7389, -- There seems to be more left in the machine, but you can't carry any more items.
        MINING_IS_POSSIBLE_HERE            = 7410, -- Mining is possible here if you have <item>.
        CHEST_UNLOCKED                     = 7425, -- You unlock the chest!
        HOMEPOINT_SET                      = 7472, -- Home point set!
    },
    mob =
    {
        BU_GHI_HOWLBLADE  = GetFirstID('BuGhi_Howlblade'),
        ZI_GHI_BONEEATER  = GetFirstID('ZiGhi_Boneeater'),
        BEHYA_HUNDREDWALL = GetFirstID('BeHya_Hundredwall'),
        NI_GHU_NESTFENDER = GetFirstID('NiGhu_Nestfender'),
    },
    npc =
    {
        TREASURE_CHEST = GetFirstID('Treasure_Chest'),
        MINING         = GetTableOfIDs('Mining_Point'),
    },
}

return zones[xi.zone.PALBOROUGH_MINES]
