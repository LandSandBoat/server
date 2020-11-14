-----------------------------------
-- Area: Palborough Mines (143)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.PALBOROUGH_MINES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED            = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                      = 6388, -- Obtained: <item>.
        GIL_OBTAINED                       = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED                   = 6391, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY            = 6402, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING                = 6403, -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET              = 6417, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS                = 6999, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY            = 7000, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER                       = 7001, -- In celebration of your most recent login no. <number>...
        GEOMAGNETRON_ATTUNED               = 7010, -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        CONQUEST_BASE                      = 7049, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET             = 7208, -- You can't fish here.
        THE_MACHINE_SEEMS_TO_BE_WORKING    = 7368, -- The machine seems to be working, but you cannot discern its purpose.
        SOMETHING_FALLS_OUT_OF_THE_MACHINE = 7371, -- Something falls out of the machine!
        YOU_CANT_CARRY_ANY_MORE_ITEMS      = 7374, -- There seems to be more left in the machine, but you can't carry any more items.
        MINING_IS_POSSIBLE_HERE            = 7395, -- Mining is possible here if you have <item>.
        CHEST_UNLOCKED                     = 7410, -- You unlock the chest!
        HOMEPOINT_SET                      = 7457, -- Home point set!
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
        TREASURE_CHEST = 17363371,
        MINING =
        {
            17363365,
            17363366,
            17363367,
            17363368,
            17363369,
            17363370,
        },
    },
}

return zones[tpz.zone.PALBOROUGH_MINES]
