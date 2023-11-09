-----------------------------------
-- Area: La_Vaule_[S] (85)
-----------------------------------
zones = zones or {}

zones[xi.zone.LA_VAULE_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7061, -- You can't fish here.
        GATE_IS_LOCKED                = 7207, -- The gate is locked.
        DOOR_IS_LOCKED                = 7728, -- The door is locked.
        PARTY_MEMBERS_HAVE_FALLEN     = 8033, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 8040, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        GATHERED_DAWNDROPS_LIGHT      = 8348, -- The gathered dawndrops unleash a brilliant light, melding together to form <keyitem>!
        RETRACED_ALL_JUNCTIONS        = 8349, -- You have retraced all junctions of eventualities. Hasten back to where Cait Sith and Lilisette await.
    },
    mob =
    {
        HAWKEYED_DNATBAT_PH =
        {
            [17125431] = 17125433, -- 375.737 0.272 -174.487
        },
        ASHMAKER_GOTBLUT_PH =
        {
            [17125450] = 17125452, -- 234.481 3.424 -241.751
        },
    },
    npc =
    {
    },
}

return zones[xi.zone.LA_VAULE_S]
