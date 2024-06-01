-----------------------------------
-- Area: Ghelsba_Outpost
-----------------------------------
zones = zones or {}

zones[xi.zone.GHELSBA_OUTPOST] =
{
    text =
    {
        CONQUEST_BASE                    = 0,    -- Tallying conquest results...
        YOU_CANNOT_ENTER_THE_BATTLEFIELD = 161,  -- You cannot enter the battlefield at present. Please wait a little longer.
        TIME_IN_THE_BATTLEFIELD_IS_UP    = 164,  -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED        = 179,  -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        UNABLE_TO_PROTECT                = 218,  -- You were unable to protect the special character. Now leaving the battlefield.
        MEMBERS_OF_YOUR_PARTY            = 470,  -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE         = 471,  -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS    = 473,  -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                   = 474,  -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED               = 475,  -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN        = 509,  -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED        = 516,  -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ITEM_CANNOT_BE_OBTAINED          = 6916, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6922, -- Obtained: <item>.
        GIL_OBTAINED                     = 6923, -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6925, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY          = 6936, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET            = 6951, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS              = 7533, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 7534, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                     = 7535, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED    = 7555, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET           = 7596, -- You can't fish here.
        NO_BATTLEFIELD_ENTRY             = 7730, -- This looks like an Orcish dwelling. The door is firmly shut.
        ENTERING_THE_BATTLEFIELD_FOR     = 7755, -- Entering the battlefield for [Save the Children/The Holy Crest/Wings of Fury/Petrifying Pair/Toadal Recall/Mirror, Mirror]!
        LOGGING_IS_POSSIBLE_HERE         = 7757, -- Logging is possible here if you have <item>.
        YOU_CAN_NOW_BECOME_A_DRAGOON     = 7797, -- You can now become a dragoon!
    },
    mob =
    {
        CARRION_DRAGON        = GetFirstID('Carrion_Dragon'),
        COLO_COLO             = GetFirstID('Colo-colo'),
        CYRANUCE_M_CUTAULEON  = GetFirstID('Cyranuce_M_Cutauleon'),
        FODDERCHIEF_VOKDEK    = GetFirstID('Fodderchief_Vokdek'),
        KALAMAINU             = GetFirstID('Kalamainu'),
        THOUSANDARM_DESHGLESH = GetFirstID('Thousandarm_Deshglesh'),
        TOADPILLOW            = GetFirstID('Toadpillow'),
    },
    npc =
    {
        LOGGING = GetTableOfIDs('Logging_Point'),
    },
}

return zones[xi.zone.GHELSBA_OUTPOST]
