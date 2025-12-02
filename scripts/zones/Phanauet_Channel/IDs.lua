-----------------------------------
-- Area: Phanauet_Channel
-----------------------------------
zones = zones or {}

zones[xi.zone.PHANAUET_CHANNEL] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7068, -- Tallying conquest results...
        TONBERRY_MSG                  = 7236, -- ...
        FISHING_MESSAGE_OFFSET        = 7237, -- You can't fish here.
        TRAVEL_ANY_FASTER             = 7381, -- Cannot this vessel travel any faster? At my age, every minute counts!
        ARE_WE_THERE_YET              = 7382, -- <Sigh> Are we there yet?
        RICHE_DAVOI_WATERFALL         = 7425, -- <item>...Davoi...waterfall...
    },
    mob =
    {
    },
    npc =
    {
        TIMEKEEPER_OFFSET = GetFirstID('Ineuteniace'),
        TONBERRY_OFFSET   = GetFirstID('Riche'),
        RIDER_OFFSET      = GetFirstID('Laiteconce'),
    },
}

return zones[xi.zone.PHANAUET_CHANNEL]
