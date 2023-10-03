-----------------------------------
-- Area: Chamber_of_Oracles
-----------------------------------
zones = zones or {}

zones[xi.zone.CHAMBER_OF_ORACLES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED          = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6390, -- Obtained: <item>.
        GIL_OBTAINED                     = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS              = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                     = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED    = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                    = 7060, -- Tallying conquest results...
        YOU_CANNOT_ENTER_THE_BATTLEFIELD = 7221, -- You cannot enter the battlefield at present. Please wait a little longer.
        PARTY_MEMBERS_HAVE_FALLEN        = 7569, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED        = 7576, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        PLACED_INTO_THE_PEDESTAL         = 7630, -- It appears that something should be placed into this pedestal.
        YOU_PLACE_THE                    = 7631, -- You place the <item> into the pedestal.
        IS_SET_IN_THE_PEDESTAL           = 7632, -- The <item> is set in the pedestal.
        HAS_LOST_ITS_POWER               = 7633, -- The <item> has lost its power.
        DOOR_IS_FIRMLY_SHUT              = 7634, -- The door is firmly shut.
        YOU_DECIDED_TO_SHOW_UP           = 7652, -- So, you decided to show up. Now it's time to see what you're really made of, heh heh heh.
        LOOKS_LIKE_YOU_WERENT_READY      = 7653, -- Looks like you weren't ready for me, were you? Now go home, wash your face, and come back when you think you've got what it takes.
        YOUVE_COME_A_LONG_WAY            = 7654, -- Hm. That was a mighty fine display of skill there, <name>. You've come a long way...
        TEACH_YOU_TO_RESPECT_ELDERS      = 7655, -- I'll teach you to respect your elders!
        TAKE_THAT_YOU_WHIPPERSNAPPER     = 7656, -- Take that, you whippersnapper!
        NOW_THAT_IM_WARMED_UP            = 7657, -- Now that I'm warmed up...
        THAT_LL_HURT_IN_THE_MORNING      = 7658, -- Ungh... That'll hurt in the morning...
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.CHAMBER_OF_ORACLES]
