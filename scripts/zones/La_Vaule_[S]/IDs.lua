-----------------------------------
-- Area: La_Vaule_[S] (85)
-----------------------------------
zones = zones or {}

zones[xi.zone.LA_VAULE_S] =
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
        FISHING_MESSAGE_OFFSET        = 7068, -- You can't fish here.
        GATE_IS_LOCKED                = 7214, -- The gate is locked.
        CAMPAIGN_RESULTS_TALLIED      = 7605, -- Campaign results tallied.
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7695, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7710, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        DOOR_IS_LOCKED                = 7735, -- The door is locked.
        MEMBERS_OF_YOUR_PARTY         = 8001, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 8002, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 8004, -- The time limit for this battle is <number> minutes.
        PARTY_MEMBERS_HAVE_FALLEN     = 8040, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 8047, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ENTERING_THE_BATTLEFIELD_FOR  = 8069, -- Entering the battlefield for [Splitting Heirs (S)/Purple, The New Black/The Blood-bathed Crown]!
        GATHERED_DAWNDROPS_LIGHT      = 8355, -- The gathered dawndrops unleash a brilliant light, melding together to form <keyitem>!
        RETRACED_ALL_JUNCTIONS        = 8356, -- You have retraced all junctions of eventualities. Hasten back to where Cait Sith and Lilisette await.
    },
    mob =
    {
        ASHMAKER_GOTBLUT = GetFirstID('Ashmaker_Gotblut'),
        HAWKEYED_DNATBAT = GetFirstID('Hawkeyed_Dnatbat'),
        GALARHIGG        = GetFirstID('Galarhigg'),
    },
    npc =
    {
        CAMPAIGN_NPC_OFFSET = GetFirstID('Framaraix_TK'), -- San, Bas, Win, Flag +4, CA
    },
}

return zones[xi.zone.LA_VAULE_S]
