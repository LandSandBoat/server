-----------------------------------
-- Area: Chocobo_Circuit
-----------------------------------
zones = zones or {}

zones[xi.zone.CHOCOBO_CIRCUIT] =
{
    text =
    {
        ASSIST_CHANNEL                = 6380, -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        FIND_ON_COUNTER               = 9511, -- You find <keyitem> on the counter.
        ALREADY_POSSESS               = 9513, -- You already possess <keyitem>.
        WELCOME_ADVENTURER            = 9514, -- Welcome, adventurer!
    },
    mob =
    {
    },
    npc =
    {
        RUNGAGA       = GetFirstID('Rungaga'),
        GATE_OFFSET   = GetFirstID('Gate_Chocobo_Circuit'),
        QM_MAP_OFFSET = GetFirstID('qm_map'),
    },
}

return zones[xi.zone.CHOCOBO_CIRCUIT]
