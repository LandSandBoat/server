-----------------------------------
-- Area: Chocobo_Circuit
-----------------------------------
zones = zones or {}

zones[xi.zone.CHOCOBO_CIRCUIT] =
{
    text =
    {
        ASSIST_CHANNEL                = 6380, -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        PROCEED_TO_GRANDSTAND         = 9216, -- All spectators wishing to view the race, please proceed to the grandstand.
        LATEST_TEAM_STANDINGS         = 9220, -- And now the latest team standings:
        SIGNUPS_OPEN                  = 9317, -- Attention, racers. Signups for the following race are now open:
        SIGNUPS_ATTENDANT             = 9318, -- Please speak with the attendant wearing [an orange/a green/a red/a blue] uniform and a red beret for details. ----------
        SIGNUPS_CLOSED                = 9319, -- Attention, racers. Signups for the following race are now closed:
        SIGNUPS_CLOSED_END            = 9320, -- ----------
        BETS_OPEN                     = 9321, -- Attention, race fans. Chocobets for the following race are now being accepted at all betting centers:
        BETS_ATTENDANT                = 9322, -- Please speak with the attendant wearing [an orange/a green/a red/a blue] uniform and a green beret for details. ----------
        BETS_CLOSING                  = 9323, -- Attention, race fans. Chocobetting for the following race will now be closing:
        BETS_CLOSING_END              = 9324, -- ----------
        RACE_STARTING                 = 9325, -- Attention please. The following race will be starting momentarily:
        RACE_STARTING_END             = 9326, -- ----------
        CURRENT_STANDINGS             = 9335, -- Current Standings Team San d'Oria: [Dominant/Major/Minor/Minimal/???] Team Bastok: [Dominant/Major/Minor/Minimal/???] Team Windurst: [Dominant/Major/Minor/Minimal/???]
        FIND_ON_COUNTER               = 9511, -- You find <keyitem> on the counter.
        ALREADY_POSSESS               = 9513, -- You already possess <keyitem>.
        WELCOME_ADVENTURER            = 9514, -- Welcome, adventurer!
        RACE_NAME_OFFSET              = 9515, -- ★CS Event Race (No. <number>)
    },
    mob =
    {
    },
    npc =
    {
        GATE_OFFSET   = GetFirstID('Gate_Chocobo_Circuit'),
        MASTER_OFFSET = GetFirstID('Master1'),
        QM_MAP_OFFSET = GetFirstID('qm_map'),
        RUNGAGA       = GetFirstID('Rungaga'),
        TIMEKEEPER    = GetFirstID('TimeKeeper'),
    },
}

return zones[xi.zone.CHOCOBO_CIRCUIT]
