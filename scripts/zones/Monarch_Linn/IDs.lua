-----------------------------------
-- Area: Monarch_Linn
-----------------------------------
zones = zones or {}

zones[xi.zone.MONARCH_LINN] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7119, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7134, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        GLOWING_MIST                  = 7150, -- A glowing mist of ever-changing proportions floats before you...
        MEMBERS_OF_YOUR_PARTY         = 7425, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7426, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7428, -- The time limit for this battle is <number> minutes.
        PARTY_MEMBERS_HAVE_FALLEN     = 7464, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7471, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        TORN_FROM_YOUR_HANDS          = 7479, -- The <keyitem> is torn from your hands and sucked into the spatial displacement!
        CONQUEST_BASE                 = 7488, -- Tallying conquest results...
        ENTERING_THE_BATTLEFIELD_FOR  = 7651, -- Entering the battlefield for [Ancient Vows/The Savage/Fire in the Sky/Bad Seed/Bugard in the Clouds/Beloved of the Atlantes/Uninvited Guests/Nest of Nightmares/★The Savage]!
        KNOCKED_OUT_OF_BATTLEFIELD    = 7658, -- The blast wave from Razon's Self-Destruct knocks you out of the battlefield!
    },
    mob =
    {
        HOTUPUKU          = GetFirstID('Hotupuku'),
        MAMMET_19_EPSILON = GetFirstID('Mammet-19_Epsilon'),
        MAMMET_800        = GetFirstID('Mammet-800'),
        OURYU             = GetFirstID('Ouryu'),
        RAZON             = GetFirstID('Razon'),
        WATCH_HIPPOGRYPH  = GetFirstID('Watch_Hippogryph'),
    },
    npc =
    {
    },
}

return zones[xi.zone.MONARCH_LINN]
