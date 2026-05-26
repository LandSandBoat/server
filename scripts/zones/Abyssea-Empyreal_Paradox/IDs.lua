-----------------------------------
-- Area: Abyssea-Empyreal_Paradox
-----------------------------------
zones = zones or {}

zones[xi.zone.ABYSSEA_EMPYREAL_PARADOX] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        CRUOR_TOTAL                   = 6989, -- Obtained <number> cruor. (Total: <number>)
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        STAGGERED                     = 7236, -- <name>'s attack staggers the fiend!
        YELLOW_STAGGER                = 7237, -- The fiend is unable to cast magic.
        BLUE_STAGGER                  = 7238, -- The fiend is unable to use special attacks.
        RED_STAGGER                   = 7239, -- The fiend is frozen in its tracks.
        YELLOW_WEAKNESS               = 7240, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental magic!
        BLUE_WEAKNESS                 = 7241, -- The fiend appears vulnerable to [/hand-to-hand/dagger/sword/great sword/axe/great axe/scythe/polearm/katana/great katana/club/staff/archery/marksmanship] weapon skills!
        RED_WEAKNESS                  = 7242, -- The fiend appears vulnerable to [/fire/ice/wind/earth/lightning/water/light/darkness] elemental weapon skills!
        ABYSSEA_TIME_OFFSET           = 7243, -- Your visitant status will wear off in <number> [second/minute].
        RETURNING_TO_SEARING_IN       = 7252, -- Returning to the Searing Ward in <number> [second/seconds].
        NO_VISITANT_WARD              = 7253, -- You do not have visitant status. Returning to the Searing Ward in <number> [second/seconds].
        RETURNING_TO_WARD             = 7255, -- Returning to the Searing Ward now.
        NO_VISITANT_STATUS            = 7312, -- You do not have visitant status. Please proceed to the nearest Conflux Surveyor to have it granted.
        ATMA_INFUSED                  = 7355, -- <name> expends <number> cruor and is now infused with <keyitem>!
        ATMA_PURGED                   = 7356, -- <name> has been purged of the <keyitem>.
        ALL_ATMA_PURGED               = 7357, -- <name> has been purged of all infused atma.
        PREVIOUS_ATMA_INFUSED         = 7363, -- <name> expends <number> cruor and [his/her] previous atma configuration is restored!
        HISTORY_ATMA_INFUSED          = 7370, -- <name> expends <number> cruor and is now infused with [his/her] chosen atma set!
        CRUOR_OBTAINED                = 7415, -- <name> obtained <number> cruor.
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7720, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7735, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        MEMBERS_OF_YOUR_PARTY         = 8026, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 8027, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 8029, -- The time limit for this battle is <number> minutes.
        PARTY_MEMBERS_HAVE_FALLEN     = 8065, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 8072, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CRIMSON_STONE_DISAPPEARS      = 8080, -- The <keyitem> disappears!
        ENTERING_THE_BATTLEFIELD_FOR  = 8092, -- Entering the battlefield for [The Wyrm God/★The Wyrm God/]!
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.ABYSSEA_EMPYREAL_PARADOX]
