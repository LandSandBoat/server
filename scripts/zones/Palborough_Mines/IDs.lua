-----------------------------------
-- Area: Palborough Mines (143)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.PALBOROUGH_MINES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED            = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                      = 6389, -- Obtained: <item>.
        GIL_OBTAINED                       = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED                   = 6392, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY            = 6403, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING                = 6404, -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET              = 6418, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS                = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY            = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                       = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED               = 7011, -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        CONQUEST_BASE                      = 7050, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET             = 7209, -- You can't fish here.
        THE_MACHINE_SEEMS_TO_BE_WORKING    = 7369, -- The machine seems to be working, but you cannot discern its purpose.
        SOMETHING_FALLS_OUT_OF_THE_MACHINE = 7372, -- Something falls out of the machine!
        YOU_CANT_CARRY_ANY_MORE_ITEMS      = 7375, -- There seems to be more left in the machine, but you can't carry any more items.
        MINING_IS_POSSIBLE_HERE            = 7396, -- Mining is possible here if you have <item>.
        CHEST_UNLOCKED                     = 7411, -- You unlock the chest!
        HOMEPOINT_SET                      = 7458, -- Home point set!
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
        MINING =
        {
            17363366,
            17363367,
            17363368,
            17363369,
            17363370,
            17363371,
        },
    },
}

return zones[xi.zone.PALBOROUGH_MINES]
