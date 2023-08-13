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
        CONQUEST_BASE                      = 7060, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET             = 7219, -- You can't fish here.
        THE_MACHINE_SEEMS_TO_BE_WORKING    = 7379, -- The machine seems to be working, but you cannot discern its purpose.
        SOMETHING_FALLS_OUT_OF_THE_MACHINE = 7382, -- Something falls out of the machine!
        YOU_CANT_CARRY_ANY_MORE_ITEMS      = 7385, -- There seems to be more left in the machine, but you can't carry any more items.
        MINING_IS_POSSIBLE_HERE            = 7406, -- Mining is possible here if you have <item>.
        CHEST_UNLOCKED                     = 7421, -- You unlock the chest!
        HOMEPOINT_SET                      = 7468, -- Home point set!
    },
    mob =
    {
        BU_GHI_HOWLBLADE_PH =
        {
            [17363177] = 17363181, -- 170.000 -15.000 179.000
            [17363178] = 17363181, -- 170.000 -16.000 165.000
            [17363179] = 17363181, -- 166.000 -16.000 135.000
            [17363180] = 17363181, -- 167.207 -18.027 159.374
        },
        ZI_GHI_BONEEATER_PH =
        {
            [17363205] = 17363208, -- 130.386 -32.313 73.967
        },
        BEHYA_HUNDREDWALL_PH =
        {
            [17363256] = 17363258,
            [17363257] = 17363258,
        },
        NI_GHU_NESTFENDER   = 17363318,
    },
    npc =
    {
        TREASURE_CHEST = 17363372,
        MINING         = GetTableOfIDs('Mining_Point'),
    },
}

return zones[xi.zone.PALBOROUGH_MINES]
