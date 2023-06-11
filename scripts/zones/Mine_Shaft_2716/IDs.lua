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
        -- Moblin Fantocciniman Combat Dialogue
        TIME_FOR_GOODEBYONGO          = 7855, -- Ho-ho, ho-ho! Time for goodebyongo!
        HERE_TO_STAY                  = 7856, -- Hey-hey, hey-hey! Are you here to stay?
        ROLY_POLY                     = 7857, -- Roly-poly, roly-poly♪
        DICE_LIKE_YOU                 = 7858, -- Hoo-hoo, hoo-hoo. Maybe dice like you!
        DICE_LIKE_ME                  = 7859, -- Hee-hee, hee-hee! Today, dice like me!
        GO_GO                         = 7860, -- Go-go, go-go!
        HA_HA                         = 7861, -- Ha-ha, ha-ha!
        NOT_YOUR_LUCKY_DAY            = 7862, -- Yay-yay, yay-yay! Not your lucky day!
        NOT_HOW                       = 7864, -- No-no, no-no! Not how it's 'sposed to go!
        YOU_PLAY_TOO_ROUGH            = 7865, -- Huff-huff, huff-huff... You play too rough...
        YOU_MAKE_ME_MAD               = 7866, -- Ow-ow, ow-ow! You make me mad now!
        GOODEBYONGO                   = 7867, -- Ho-ho, ho-ho! Goodebyongo!
        BEGINS_TO_PANIC               = 7868, -- The Moblin Fantocciniman begins to panic.
        END_OF_YOU                    = 7869, -- We not go down without fight. That be promise. Just you watch. This be end of you.
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
            skillList = 4033,
            ability = 1428, -- Warcry
            twoHour = 688, -- Mighty Strikes
            spellListID = 0,
            petID = 0,
            mods = {},
        },
        [xi.job.MNK] =
        {
            modelID = 1210,
            skillList = 4034,
            ability = 1429, -- Counterstance
            twoHour = 690, -- Hundred Fists
            spellListID = 0,
            petID = 0,
            mods = {},
        },
        [xi.job.WHM] =
        {
            modelID = 1214,
            skillList = 4035,
            ability = 0, -- None
            twoHour = 689, -- Benediction
            spellListID = 1,
            petID = 0,
            mods =
            {
                { xi.mod.ATTP, -100, },
            },
        },
        [xi.job.BLM] =
        {
            modelID = 1215,
            skillList = 4035,
            ability = 0, -- None
            twoHour = 691, -- Manafont
            spellListID = 2,
            petID = 0,
            mods =
            {
                { xi.mod.ATTP, -100 },
            },
        },
        [xi.job.RDM] =
        {
            modelID = 1216,
            skillList = 4037,
            ability = 0, -- None
            twoHour = 692, -- Chainspell
            spellListID = 3,
            petID = 0,
            mods =
            {
                { xi.mod.ATTP, -50, },
            },
        },
        [xi.job.THF] =
        {
            modelID = 1218,
            skillList = 4038,
            ability = 0, -- None
            twoHour = 693, -- Perfect Dodge
            spellListID = 0,
            petID = 0,
            mods =
            {
                { xi.mod.ATTP, -50, },
            },
        },
        [xi.job.PLD] =
        {
            modelID = 1219,
            skillList = 4037,
            ability = 1431, -- Shield Bash
            twoHour = 694, -- Incincible
            spellListID = 4,
            petID = 0,
            mods = {},
        },
        [xi.job.DRK] =
        {
            modelID = 1220,
            skillList = 4039,
            ability = 1432, -- Weapon Bash
            twoHour = 695, -- Blood Weapon
            spellListID = 5,
            petID = 0,
            mods = {},
        },
        [xi.job.BST] =
        {
            modelID = 1224,
            skillList = 4033,
            petModelID =
            {
                328, -- Lizzard
                340, -- Sheep
                376, -- Funguar
                356, -- Crab
            },
            petSkillList =
            {
                174, -- Lizzard
                226, -- Sheep
                116, -- Funguar
                372, -- Crab
            },
            ability = 1433, -- Sic
            twoHour = 740, -- Familiar
            spellListID = 0,
            petID = 1,
            mods = {},
        },
        [xi.job.BRD] =
        {
            modelID = 1227,
            skillList = 4038,
            ability = 0, -- None
            twoHour = 696, -- Soul Voice
            spellListID = 6,
            petID = 0,
            mods =
            {
                { xi.mod.ATTP, -25, },
            },
        },
        [xi.job.RNG] =
        {
            modelID = 1228,
            skillList = 4040,
            ability = 1434, -- Barrage
            twoHr = 413, -- Eagle Eye Shot
            spellListID = 0,
            petID = 0,
            mods = {},
        },
        [xi.job.SAM] =
        {
            modelID = 1229,
            skillList = 4041,
            ability = 1436, -- Meditate
            twoHour = 730, -- Meikyo Shisui
            spellListID = 0,
            petID = 0,
            mods = {},
        },
        [xi.job.NIN] =
        {
            modelID = 1232,
            skillList = 4042,
            ability = 0, -- None
            twoHour = 731, -- Mjin Gakure
            spellListID = 7,
            petID = 0,
            mods = {},
        },
        [xi.job.DRG] =
        {
            modelID = 1234,
            skillList = 4043,
            ability = 1437, -- Jump
            twoHour = 732, -- Call Wyvern
            spellListID = 0,
            petID = 2,
            mods = {},
        },
        [xi.job.SMN] =
        {
            modelID = 1235,
            skillList = 4036,
            petModelID =
            {
                793, -- Ifrit
                794, -- Titan
                795, -- Leviathan
                796, -- Garuda
                797, -- Shiva
                798, -- Ramuh
                791, -- Carbuncle
            },
            petSkillList =
            {
                38, -- Ifrit
                45, -- Titan
                40, -- Leviathan
                37, -- Garuda
                44, -- Shiva
                43, -- Ramuh
                34, -- Carbuncle
            },

            ability = 1438, -- Blood Pact
            twoHour = 734, -- Astral Flow
            spellListID = 0,
            petID = 3,
            mods =
            {
                { xi.mod.ATTP, -100, },
            },
        },
        [xi.job.BLU] =
        {
            modelID = 1396,
            skillList = 4037,
            ability = 0, -- None
            spellListID = 8, -- TODO: Mimic player's set spells
            petID = 0,
            mods = {},
        },
        [xi.job.COR] =
        {
            modelID = 1397,
            skillList = 4044,
            ability = 0, -- TODO: Add rolls here
            spellListID = 0, -- ???
            petID = 0,
            mods = {},
        },
        [xi.job.PUP] =
        {
            modelID = 1398,
            skillList = 4034,
            petModelID =
            {
                { 1983, xi.job.PLD }, -- Melee Automaton
                { 1990, xi.job.RNG }, -- Ranged Automaton
                { 1994, xi.job.BLM }, -- Magic Automaton
            },
            petSkillList =
            {
                364, -- Melee Automaton
                365, -- Ranged Automaton
                366, -- Magic Automaton
            },
            petSpellListID =
            {
                0, -- Melee Automaton
                0, -- Ranged Automaton
                2, -- Magic Automaton
            },
            ability = 1995, -- Maneuvers
            spellListID = 0,
            petID = 4,
            mods = {},
        },
    }
}

return zones[xi.zone.MINE_SHAFT_2716]
