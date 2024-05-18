-----------------------------------
-- Area: Bearclaw_Pinnacle
-----------------------------------
zones = zones or {}

zones[xi.zone.BEARCLAW_PINNACLE] =
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
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7069, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7084, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        MEMBERS_OF_YOUR_PARTY         = 7375, -- Currently, <number> members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7376, -- Currently, <number> members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7378, -- The time limit for this battle is <number> minutes.
        THERE_IS_A_CRACK              = 7379, -- There is a crack in the <item>. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7380, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7414, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7421, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ZEPHYR_RIPS                   = 7429, -- The <item> rips!
        CONQUEST_BASE                 = 7438, -- Tallying conquest results...
        ENTERING_THE_BATTLEFIELD_FOR  = 7601, -- Entering the battlefield for [Flames for the Dead/Follow the White Rabbit/When Hell Freezes Over/Brothers/Holy Cow/Taurassic Park]!
        BLOWN_AWAY                    = 7624, -- The explosion has blown you out of the area!
        BEGINS_TO_MELT                = 7681, -- The Snoll Tzar has begun to melt!
        LARGE_STEAM                   = 7682, -- The Snoll Tzar is emitting a large amount of steam.
        SHOOK_SALT                    = 7683, -- The Snoll Tzar shakes off the salt!
    },
    mob =
    {
        SNOLL_TZAR_OFFSET = GetFirstID('Snoll_Tzar'),
    },
    npc =
    {
        ENTRANCE_OFFSET = GetFirstID('Wind_Pillar_1'),
    },
}

return zones[xi.zone.BEARCLAW_PINNACLE]
