-----------------------------------
-- Area: Mine_Shaft_2716
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.MINE_SHAFT_2716] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provIDed you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        PARTY_MEMBERS_HAVE_FALLEN     = 7410, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7417, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7432, -- Tallying conquest results...
    },

    mob =
    {
        [1] =
        {
            MOBLIN_IDS = { 16830465, 16830466, 16830467, 16830468 }
        },
        [2] =
        {
            MOBLIN_IDS = { 16830470, 16830471, 16830472, 16830473 }
        },
        [3] =
        {
            MOBLIN_IDS = { 16830475, 16830476, 16830477, 16830478 }
        },

        FANTOCCINI =
        {
            16830509,
            16830516,
            16830523,
        }
    },

    npc =
    {
    },

    jobTable =
    {
        [xi.job.WAR] =
        {
            modelID = 1209,
            skillList = 1182,
            ability = 1728, -- Warcry
            spellListID = 0,
            petID = 0,
        },
        [xi.job.MNK] =
        {
            modelID = 1210,
            skillList = 1183,
            ability = 1434, -- Counterstance
            spellListID = 0,
            petID = 0,
        },
        [xi.job.WHM] =
        {
            modelID = 1214,
            skillList = 1884,
            ability = 0, -- None
            spellListID = 1,
            petID = 0,
        },
        [xi.job.BLM] =
        {
            modelID = 1215,
            skillList = 1885,
            ability = 0, -- None
            spellListID = 2,
            petID = 0,
        },
        [xi.job.RDM] =
        {
            modelID = 1216,
            skillList = 1886,
            ability = 0, -- None
            spellListID = 3,
            petID = 0,
        },
        [xi.job.THF] =
        {
            modelID = 1218,
            skillList = 1887,
            ability = 0, -- None
            spellListID = 0,
            petID = 0,
        },
        [xi.job.PLD] =
        {
            modelID = 1219,
            skillList = 1886,
            ability = 1431, -- Shield Bash
            spellListID = 4,
            petID = 0,
        },
        [xi.job.DRK] =
        {
            modelID = 1220,
            skillList = 1188,
            ability = 0, -- Weapon Bash
            spellListID = 5,
            petID = 0,
        },
        [xi.job.BST] =
        {
            modelID = 1224,
            skillList = 1182,
            ability = 1433, -- Sic
            spellListID = 0,
            petID = 1,
        },
        [xi.job.BRD] =
        {
            modelID = 1227,
            skillList = 1887,
            ability = 0, -- None
            spellListID = 6,
            petID = 0,
        },
        [xi.job.RNG] =
        {
            modelID = 1228,
            skillList = 1189,
            ability = 1434, -- Barrage
            spellListID = 0,
            petID = 0,
        },
        [xi.job.SAM] =
        {
            modelID = 1229,
            skillList = 1190,
            ability = 1436, -- Meditate
            spellListID = 0,
            petID = 0,
        },
        [xi.job.NIN] =
        {
            modelID = 1232,
            skillList = 1191,
            ability = 0, -- None
            spellListID = 7,
            petID = 0,
        },
        [xi.job.DRG] =
        {
            modelID = 1234,
            skillList = 1192,
            ability = 1437, -- Jump
            spellListID = 0,
            petID = 2,
        },
        [xi.job.SMN] =
        {
            modelID = 1235,
            skillList = 1185,
            ability = 1438, -- Blood Pact
            spellListID = 0,
            petID = 3,
        },
        [xi.job.BLU] =
        {
            modelID = 1396,
            skillList = 1186,
            ability = 0, -- ???
            spellListID = 8,
            petID = 0,
        },
        [xi.job.COR] =
        {
            modelID = 1397,
            skillList = 1193,
            ability = 0, -- None
            spellListID = 0,
            petID = 0,
        },
        [xi.job.PUP] =
        {
            modelID = 1398,
            skillList = 1183,
            ability = 0, -- None
            spellListID = 0,
            petID = 4,
        },
    }
}

return zones[xi.zone.MINE_SHAFT_2716]
