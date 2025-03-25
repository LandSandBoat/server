-----------------------------------
-- Area: The_Colosseum
-----------------------------------
zones = zones or {}

zones[xi.zone.THE_COLOSSEUM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6392,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394,  -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7002,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024,  -- Your party is unable to participate because certain members' levels are restricted.
        THANKS_FOR_STOPPING_BY        = 11517, -- Thanks for stopping by. I'll be seeing you around, <name>!
        I_CAN_GIVE_YOU                = 11518, -- Let me see... I can give you <number> [jetton/jettons] for this amount.
        EXCEED_THE_LIMIT_OF_JETTONS   = 11520, -- By exchanging for this amount, you will exceed the limit of jettons that you can carry.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.THE_COLOSSEUM]
