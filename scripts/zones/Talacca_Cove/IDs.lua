-----------------------------------
-- Area: Talacca_Cove
-----------------------------------
zones = zones or {}

zones[xi.zone.TALACCA_COVE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7069, -- You can't fish here.
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7333, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7348, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7371, -- It appears as if something had been thrust into the rockface here...
        TESTIMONY_IS_TORN             = 7391, -- Your <item> is torn...
        TESTIMONY_WEARS               = 7392, -- Your <item> [/rips into shreds!/is on the verge of tearing apart.../is showing signs of wear...] (# [use remains/uses remain].)
        MEMBERS_OF_YOUR_PARTY         = 7639, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7640, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7642, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7643, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7644, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7678, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7685, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        IMPERIAL_ORDER_BREAKS         = 7693, -- The <item> breaks!
        ENTERING_THE_BATTLEFIELD_FOR  = 7706, -- Entering the battlefield for [Call to Arms/Compliments to the Chef/Puppetmaster Blues/Breaking the Bonds of Fate/Legacy of the Lost/Legacy of the Lost/An Imperial Heist]!
        YOU_CAN_NOW_BECOME_A_CORSAIR  = 7804, -- You can now become a corsair!
        NOBODY_COMES_TO_HELP          = 7855, -- Nobody comes to help. The Imp Bandsman looks dejected.
        HELP_HAS_ARRIVED              = 7856, -- Help has arrived!
        YOUR_LEVEL_LIMIT_IS_NOW_75    = 7874, -- Your level limit is now 75.
    },
    mob =
    {
        GESSHO  = GetFirstID('Gessho'),
        QULTADA = GetFirstID('Qultada'),
        VALKENG = GetFirstID('Valkeng'),
    },
    npc =
    {
    },
}

return zones[xi.zone.TALACCA_COVE]
