-----------------------------------
-- Area: Phanauet_Channel
-----------------------------------
zones = zones or {}

zones[xi.zone.PHANAUET_CHANNEL] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072, -- Tallying conquest results...
        TONBERRY_MSG                  = 7240, -- ...
        FISHING_MESSAGE_OFFSET        = 7241, -- You can't fish here.
        TRAVEL_ANY_FASTER             = 7386, -- Cannot this vessel travel any faster? At my age, every minute counts!
        ARE_WE_THERE_YET              = 7387, -- <Sigh> Are we there yet?
        DREDVODD_SPAWN                = 7417, -- O-o-o-o....
        RICHE_DAVOI_WATERFALL         = 7430, -- <item>...Davoi...waterfall...
    },
    mob =
    {
        STUBBORN_DREDVODD = GetFirstID('Stubborn_Dredvodd'),
    },
    npc =
    {
        TIMEKEEPER_OFFSET = GetFirstID('Ineuteniace'),
        TONBERRY_OFFSET   = GetFirstID('Riche'),
        RIDER_OFFSET      = GetFirstID('Laiteconce'),
    },
}

return zones[xi.zone.PHANAUET_CHANNEL]
