-----------------------------------
-- Area: Walk_of_Echoes
-----------------------------------
zones = zones or {}

zones[xi.zone.WALK_OF_ECHOES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CANNOT_PROGRESS_MISSION       = 7047, -- ou are unable to make further progress in Rhapsodies of Vana'diel due to an event occurring in the [Chains of Promathia/Treasures of Aht Urhgan/Wings of the Goddess/Seekers of Adoulin/Rise of the Zilart] missions.
        CANNOT_PROGRESS_QUEST         = 7048, -- ou are unable to make further progress in Rhapsodies of Vana'diel due to an event occurring in the quest [Champion of the Dawn/A Forbidden Reunion].
        PARTY_MEMBERS_HAVE_FALLEN     = 7650, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7657, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        GATHERED_DAWNDROPS_LIGHT      = 7969, -- The gathered dawndrops unleash a brilliant light, melding together to form <keyitem>!
        RETRACED_ALL_JUNCTIONS        = 7970, -- You have retraced all junctions of eventualities. Hasten back to where Cait Sith and Lilisette await.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.WALK_OF_ECHOES]
