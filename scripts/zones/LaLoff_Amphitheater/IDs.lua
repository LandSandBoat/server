-----------------------------------
-- Area: LaLoff_Amphitheater
-----------------------------------
zones = zones or {}

zones[xi.zone.LALOFF_AMPHITHEATER] =
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
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7236, -- Your time in the battlefield is up! Now exiting...
        NO_RESPONSE_CANNOT_ESCAPE     = 7252, -- There is no response. You cannot escape!
        MEMBERS_OF_YOUR_PARTY         = 7542, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7543, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7545, -- The time limit for this battle is <number> minutes.
        INK_HAS_FADED                 = 7546, -- The illuminink on the <item> has faded.
        PARTY_MEMBERS_HAVE_FALLEN     = 7581, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7588, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        LARGE_CRACK_RUNNING_DOWN      = 7601, -- The <item> has a large crack running straight down the side.
        ENTERING_THE_BATTLEFIELD_FOR  = 7608, -- Entering the battlefield for [Ark Angels (1)/Ark Angels (2)/Ark Angels (3)/Ark Angels (4)/Ark Angels (5)/Divine Might/★Ark Angels (1)/★Ark Angels (2)/★Ark Angels (3)/★Ark Angels (4)/★Ark Angels (5)/★Divine Might]!
        THE_SEAL_FADES                = 7619, -- The seal on the <item> flares brightly for an instant, then fades away!
    },
    mob =
    {
        ARK_ANGEL_EV = GetFirstID('Ark_Angel_EV'),
        ARK_ANGEL_GK = GetFirstID('Ark_Angel_GK'),
        ARK_ANGEL_HM = GetFirstID('Ark_Angel_HM'),
        ARK_ANGEL_MR = GetFirstID('Ark_Angel_MR'),
        ARK_ANGEL_TT = GetFirstID('Ark_Angel_TT'),
    },
    npc =
    {
    },
}

return zones[xi.zone.LALOFF_AMPHITHEATER]
