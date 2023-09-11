-----------------------------------
-- Area: Ghelsba_Outpost
-----------------------------------
zones = zones or {}

zones[xi.zone.GHELSBA_OUTPOST] =
{
    text =
    {
        CONQUEST_BASE                    = 0,    -- Tallying conquest results...
        YOU_CANNOT_ENTER_THE_BATTLEFIELD = 161,  -- You cannot enter the battlefield at present. Please wait a little longer.
        UNABLE_TO_PROTECT                = 218,  -- You were unable to protect the special character. Now leaving the battlefield.
        PARTY_MEMBERS_HAVE_FALLEN        = 509,  -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED        = 516,  -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ITEM_CANNOT_BE_OBTAINED          = 6915, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6921, -- Obtained: <item>.
        GIL_OBTAINED                     = 6922, -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6924, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY          = 6935, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET            = 6950, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS              = 7532, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 7533, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                     = 7534, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED    = 7554, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET           = 7591, -- You can't fish here.
        HUT_DOOR                         = 7725, -- This looks like an Orcish dwelling. The door is firmly shut.
        LOGGING_IS_POSSIBLE_HERE         = 7752, -- Logging is possible here if you have <item>.
        YOU_CAN_NOW_BECOME_A_DRAGOON     = 7792, -- You can now become a dragoon!
    },
    mob =
    {
        THOUSANDARM_DESHGLESH_PH =
        {
            [17350825] = 17350826, -- 123.357 -0.102 332.706
            [17350818] = 17350826, -- 94.576 -1.274 333.168
            [17350819] = 17350826, -- 98.658 -0.319 328.269
            [17350820] = 17350826, -- 96.763 -0.047 319.781
            [17350821] = 17350826, -- 85.215 -0.739 344.257
            [17350817] = 17350826, -- 80.000 -0.249 328.000
            [17350806] = 17350826, -- 75.988 -0.084 382.437
            [17350824] = 17350826, -- 82.000 -0.500 366.000
        },
        CARRION_DRAGON = 17350941,
    },
    npc =
    {
        LOGGING = GetTableOfIDs('Logging_Point'),
    },
}

return zones[xi.zone.GHELSBA_OUTPOST]
