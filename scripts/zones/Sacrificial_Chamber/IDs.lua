-----------------------------------
-- Area: Sacrificial_Chamber
-----------------------------------
zones = zones or {}

zones[xi.zone.SACRIFICIAL_CHAMBER] =
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
        CONQUEST_BASE                 = 7073, -- Tallying conquest results...
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7237, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7252, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7256, -- The old wooden door is locked tight.
        MEMBERS_OF_YOUR_PARTY         = 7543, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7544, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7546, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7547, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7548, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7582, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7589, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ENTERING_THE_BATTLEFIELD_FOR  = 7680, -- Entering the battlefield for [The Temple of Uggalepih/Jungle Boogymen/Amphibian Assault/Project: Shantottofication/Whom Wilt Thou Call/★Jungle Boogymen/★Amphibian Assault]!
    },
    mob =
    {
        GRAVITON             =   GetFirstID('Graviton'),
        QULL_THE_FALLSTOPPER   = GetFirstID('Qull_the_Fallstopper'),
        SABLE_TONGUED_GONBERRY = GetFirstID('Sable-tongued_Gonberry'),
    },
    npc =
    {
    },
}

return zones[xi.zone.SACRIFICIAL_CHAMBER]
