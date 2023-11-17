-----------------------------------
-- Area: Empyreal_Paradox
-----------------------------------
zones = zones or {}

zones[xi.zone.EMPYREAL_PARADOX] =
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
        PARTY_MEMBERS_HAVE_FALLEN     = 7411, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7418, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7434, -- Tallying conquest results...
        PRISHE_TEXT                   = 7699, -- You're about to learn how strong the will to live makes us!
        SELHTEUS_TEXT                 = 7712, -- The...Emptiness... Is this...how it was meant...to be...?
        PROMATHIA_TEXT                = 7715, -- Give thyself to the apathy within...
        QM_TEXT                       = 7813, -- The air before you appears warped and distorted...
    },
    mob =
    {
        PROMATHIA_OFFSET = 16924673,
    },
    npc =
    {
    },
}

return zones[xi.zone.EMPYREAL_PARADOX]
