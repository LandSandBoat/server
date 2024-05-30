-----------------------------------
-- Area: Monarch_Linn
-----------------------------------
zones = zones or {}

zones[xi.zone.MONARCH_LINN] =
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
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7110, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7125, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        GLOWING_MIST                  = 7141, -- A glowing mist of ever-changing proportions floats before you...
        MEMBERS_OF_YOUR_PARTY         = 7416, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7417, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7419, -- The time limit for this battle is <number> minutes.
        PARTY_MEMBERS_HAVE_FALLEN     = 7455, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7462, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7479, -- Tallying conquest results...
        ENTERING_THE_BATTLEFIELD_FOR  = 7642, -- Entering the battlefield for [Ancient Vows/The Savage/Fire in the Sky/Bad Seed/Bugard in the Clouds/Beloved of the Atlantes/Uninvited Guests/Nest of Nightmares/The Savage]!
    },
    mob =
    {
        MAMMET_19_EPSILON = GetFirstID('Mammet-19_Epsilon'),
        OURYU             = GetFirstID('Ouryu'),
    },
    npc =
    {
    },
}

return zones[xi.zone.MONARCH_LINN]
