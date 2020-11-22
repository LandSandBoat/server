-----------------------------------
-- Area: The_Colosseum
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.THE_COLOSSEUM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED     = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6388, -- Obtained: <item>.
        GIL_OBTAINED                = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS         = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        THANKS_FOR_STOPPING_BY      = 11498, -- Thanks for stopping by. I'll be seeing you around, <name>!
        I_CAN_GIVE_YOU              = 11499, -- Let me see... I can give you <number> [jetton/jettons] for this amount.
        EXCEED_THE_LIMIT_OF_JETTONS = 11501, -- By exchanging for this amount, you will exceed the limit of jettons that you can carry.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.THE_COLOSSEUM]
