-----------------------------------
-- Colonization Reive Data
-----------------------------------
xi = xi or {}
xi.reives = xi.reives or {}

local ceizakBattlegroundsID = zones[xi.zone.CEIZAK_BATTLEGROUNDS]
local cirdasCavernsID       = zones[xi.zone.CIRDAS_CAVERNS]
local dhoGatesID            = zones[xi.zone.DHO_GATES]
local foretDeHennetielID    = zones[xi.zone.FORET_DE_HENNETIEL]
local kamihrDriftsID        = zones[xi.zone.KAMIHR_DRIFTS]
local marjamiRavineID       = zones[xi.zone.MARJAMI_RAVINE]
local mohGatesID            = zones[xi.zone.MOH_GATES]
local morimarBasaltFieldsID = zones[xi.zone.MORIMAR_BASALT_FIELDS]
local outerRakaznarID       = zones[xi.zone.OUTER_RAKAZNAR]
local rakaznarInnerCourtID  = zones[xi.zone.RAKAZNAR_INNER_COURT]
local sihGatesID            = zones[xi.zone.SIH_GATES]
local wohGatesID            = zones[xi.zone.WOH_GATES]
local yahseHuntingGroundsID = zones[xi.zone.YAHSE_HUNTING_GROUNDS]
local yorciaWealdID         = zones[xi.zone.YORCIA_WEALD]

--Zone Data
xi.reives.zoneData =
{
    [xi.zone.CEIZAK_BATTLEGROUNDS] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {
            -- !pos 120 0.184 -54 261
            [1] =
            {
                mob =
                {
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 3,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 4,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 5,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 6,
                },
                obstacles =
                {
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 1,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 2,
                },
                collision =
                {
                    ceizakBattlegroundsID.npc.REIVE_COLLISION_OFFSET,
                    ceizakBattlegroundsID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos -134 0.184 39 261
            [2] =
            {
                mob =
                {
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 19,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 20,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 21,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 22,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 23,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 24,
                },
                obstacles =
                {
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 16,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 17,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 18,
                },
                collision =
                {
                    ceizakBattlegroundsID.npc.REIVE_COLLISION_OFFSET + 2,
                    ceizakBattlegroundsID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },

            -- !pos -239 0.184 174 261
            [3] =
            {
                mob =
                {
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 10,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 11,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 12,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 13,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 14,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 15,
                },
                obstacles =
                {
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 7,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 8,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 9,
                },
                collision =
                {
                    ceizakBattlegroundsID.npc.REIVE_COLLISION_OFFSET + 4,
                    ceizakBattlegroundsID.npc.REIVE_COLLISION_OFFSET + 5,
                },
            },

            -- !pos -280.499 0.409 182 261
            [4] =
            {
                mob =
                {
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 28,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 29,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 30,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 31,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 32,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 33,
                },
                obstacles =
                {
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 25,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 26,
                    ceizakBattlegroundsID.mob.REIVE_MOB_OFFSET + 27,
                },
                collision =
                {
                    ceizakBattlegroundsID.npc.REIVE_COLLISION_OFFSET + 6,
                    ceizakBattlegroundsID.npc.REIVE_COLLISION_OFFSET + 7,
                },
            },
        },
    },

    [xi.zone.CIRDAS_CAVERNS] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {

            -- !pos -120 19.972 22 270
            [1] =
            {
                mob =
                {
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 2,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 3,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 4,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 5,
                },
                obstacles =
                {
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 1,
                },
                collision =
                {
                    cirdasCavernsID.npc.REIVE_COLLISION_OFFSET + 12,
                    cirdasCavernsID.npc.REIVE_COLLISION_OFFSET + 13,
                },
            },

            -- !pos 439 19.972 142 270
            [2] =
            {
                mob =
                {
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 8,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 9,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 10,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 11,
                },
                obstacles =
                {
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 6,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 7,
                },
                collision =
                {
                    cirdasCavernsID.npc.REIVE_COLLISION_OFFSET,
                    cirdasCavernsID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos 98 19.972 -40 270
            [3] =
            {
                mob =
                {
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 14,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 15,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 16,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 17,
                },
                obstacles =
                {
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 12,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 13,
                },
                collision =
                {
                    cirdasCavernsID.npc.REIVE_COLLISION_OFFSET + 8,
                    cirdasCavernsID.npc.REIVE_COLLISION_OFFSET + 9,
                },
            },

            -- !pos -62 19.972 160 270
            [4] =
            {
                mob =
                {
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 20,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 21,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 22,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 23,
                },
                obstacles =
                {
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 18,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 19,
                },
                collision =
                {
                    cirdasCavernsID.npc.REIVE_COLLISION_OFFSET + 10,
                    cirdasCavernsID.npc.REIVE_COLLISION_OFFSET + 11,
                },
            },

            -- !pos 160 19.972 301 270
            [5] =
            {
                mob =
                {
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 26,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 27,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 28,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 29,
                },
                obstacles =
                {
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 24,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 25,
                },
                collision =
                {
                    cirdasCavernsID.npc.REIVE_COLLISION_OFFSET + 4,
                    cirdasCavernsID.npc.REIVE_COLLISION_OFFSET + 5,
                },
            },

            -- !pos 220.215 20 40.89 270
            [6] =
            {
                mob =
                {
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 32,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 33,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 34,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 35,
                },
                obstacles =
                {
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 30,
                    cirdasCavernsID.mob.REIVE_MOB_OFFSET + 31,
                },
                collision =
                {
                    cirdasCavernsID.npc.REIVE_COLLISION_OFFSET + 2,
                    cirdasCavernsID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },
        },
    },

    [xi.zone.DHO_GATES] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {
            -- !pos -60 -9.9 73.8 272
            [1] =
            {
                mob =
                {
                    dhoGatesID.mob.REIVE_MOB_OFFSET + 2,
                    dhoGatesID.mob.REIVE_MOB_OFFSET + 3,
                    dhoGatesID.mob.REIVE_MOB_OFFSET + 4,
                    dhoGatesID.mob.REIVE_MOB_OFFSET + 5,
                },
                obstacles =
                {
                    dhoGatesID.mob.REIVE_MOB_OFFSET,
                    dhoGatesID.mob.REIVE_MOB_OFFSET + 1,
                },
                collision =
                {
                    dhoGatesID.npc.REIVE_COLLISION_OFFSET,
                    dhoGatesID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos -154 -20 300.9 272
            [2] =
            {
                mob =
                {
                    dhoGatesID.mob.REIVE_MOB_OFFSET + 8,
                    dhoGatesID.mob.REIVE_MOB_OFFSET + 9,
                    dhoGatesID.mob.REIVE_MOB_OFFSET + 10,
                    dhoGatesID.mob.REIVE_MOB_OFFSET + 11,
                },
                obstacles =
                {
                    dhoGatesID.mob.REIVE_MOB_OFFSET + 6,
                    dhoGatesID.mob.REIVE_MOB_OFFSET + 7,
                },
                collision =
                {
                    dhoGatesID.npc.REIVE_COLLISION_OFFSET + 2,
                    dhoGatesID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },
        },
    },

    [xi.zone.FORET_DE_HENNETIEL] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {
            -- !pos 183.4 -1.9 220 262
            [1] =
            {
                mob =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 1,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 2,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 3,
                },
                obstacles =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET,
                },
                collision =
                {
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 10,
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 11,
                },
            },
            -- !pos 136.5 -2.1 258 262
            [2] =
            {
                mob =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 5,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 6,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 7,
                },
                obstacles =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 4,
                },
                collision =
                {
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 8,
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 9,
                },
            },

            -- !pos -16.6 -1.8 380 262
            [3] =
            {
                mob =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 9,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 10,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 11,
                },
                obstacles =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 8,
                },
                collision =
                {
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 6,
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 7,
                },
            },

            -- !pos -63 -2.1 418 262
            [4] =
            {
                mob =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 13,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 14,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 15,
                },
                obstacles =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 12,
                },
                collision =
                {
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 4,
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 5,
                },
            },

            -- !pos 343 -1.8 -299.4 262
            [5] =
            {
                mob =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 17,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 18,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 19,
                },
                obstacles =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 16,
                },
                collision =
                {
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 18,
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 19,
                },
            },

            -- !pos 296 -2.0 -261 262
            [6] =
            {
                mob =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 21,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 22,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 23,
                },
                obstacles =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 20,
                },
                collision =
                {
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 16,
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 17,
                },
            },

            -- !pos -16.5 -1.93 -219 262
            [7] =
            {
                mob =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 25,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 26,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 27,
                },
                obstacles =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 24,
                },
                collision =
                {
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 14,
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 15,
                },
            },

            -- !pos -63.4 -2.1 -181 262
            [8] =
            {
                mob =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 29,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 30,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 31,
                },
                obstacles =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 28,
                },
                collision =
                {
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 12,
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 13,
                },
            },

            -- !pos -380.9 -1.9 23 262
            [9] =
            {
                mob =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 33,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 34,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 35,
                },
                obstacles =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 32,
                },
                collision =
                {
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 2,
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },

            -- !pos -418.8 -2 -23.3 262
            [10] =
            {
                mob =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 37,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 38,
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 39,
                },
                obstacles =
                {
                    foretDeHennetielID.mob.REIVE_MOB_OFFSET + 36,
                },
                collision =
                {
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET,
                    foretDeHennetielID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },
        },
    },

    [xi.zone.KAMIHR_DRIFTS] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {
            -- !pos 114.7 40 -269.3 267
            [1] =
            {
                mob =
                {
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 2,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 3,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 4,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 5,
                },
                obstacles =
                {
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 1,
                },
                collision =
                {
                    kamihrDriftsID.npc.REIVE_COLLISION_OFFSET,
                },
            },

            -- !pos 246 40 -110 267
            [2] =
            {
                mob =
                {
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 8,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 9,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 10,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 11,
                },
                obstacles =
                {
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 6,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 7,
                },
                collision =
                {
                    kamihrDriftsID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos -34 20 11 267
            [3] =
            {
                mob =
                {
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 14,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 15,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 16,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 17,
                },
                obstacles =
                {
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 12,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 13,
                },
                collision =
                {
                    kamihrDriftsID.npc.REIVE_COLLISION_OFFSET + 2,
                },
            },

            -- !pos -354 0.2 269.4 267
            [4] =
            {
                mob =
                {
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 20,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 21,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 22,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 23,
                },
                obstacles =
                {
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 18,
                    kamihrDriftsID.mob.REIVE_MOB_OFFSET + 19,
                },
                collision =
                {
                    kamihrDriftsID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },
        },
    },

    [xi.zone.MARJAMI_RAVINE] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {

            -- !pos 339 -41.6 -18 266
            [1] =
            {
                mob =
                {
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 2,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 3,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 4,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 5,
                },
                obstacles =
                {
                    marjamiRavineID.mob.REIVE_MOB_OFFSET,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 1,
                },
                collision =
                {
                    marjamiRavineID.npc.REIVE_COLLISION_OFFSET,
                },
            },

            -- !pos 218 -21.6 60 266
            [2] =
            {
                mob =
                {
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 8,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 9,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 10,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 11,
                },
                obstacles =
                {
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 6,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 7,
                },
                collision =
                {
                    marjamiRavineID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos 180 -1.6 -138 266
            [3] =
            {
                mob =
                {
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 14,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 15,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 16,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 17,
                },
                obstacles =
                {
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 12,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 13,
                },
                collision =
                {
                    marjamiRavineID.npc.REIVE_COLLISION_OFFSET + 2,
                },
            },

            -- !pos 102 38 -180 266
            [4] =
            {
                mob =
                {
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 20,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 21,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 22,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 23,
                },
                obstacles =
                {
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 18,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 19,
                },
                collision =
                {
                    marjamiRavineID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },

            -- !pos -98 38 -140 266
            [5] =
            {
                mob =
                {
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 26,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 27,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 28,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 29,
                },
                obstacles =
                {
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 24,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 25,
                },
                collision =
                {
                    marjamiRavineID.npc.REIVE_COLLISION_OFFSET + 4,
                },
            },

            -- !pos -178 -2.4 -60 266
            [6] =
            {
                mob =
                {
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 32,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 33,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 34,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 35,
                },
                obstacles =
                {
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 30,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 31,
                },
                collision =
                {
                    marjamiRavineID.npc.REIVE_COLLISION_OFFSET + 5,
                },
            },

            -- !pos -298 -22.4 100 266
            [7] =
            {
                mob =
                {
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 38,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 39,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 40,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 41,
                },
                obstacles =
                {
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 36,
                    marjamiRavineID.mob.REIVE_MOB_OFFSET + 37,
                },
                collision =
                {
                    marjamiRavineID.npc.REIVE_COLLISION_OFFSET + 6,
                },
            },
        },
    },

    [xi.zone.MOH_GATES] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {
            -- !pos 240 19 -57.5 269
            [1] =
            {
                mob =
                {
                    mohGatesID.mob.REIVE_MOB_OFFSET + 3,
                    mohGatesID.mob.REIVE_MOB_OFFSET + 4,
                    mohGatesID.mob.REIVE_MOB_OFFSET + 5,
                    mohGatesID.mob.REIVE_MOB_OFFSET + 6,
                    mohGatesID.mob.REIVE_MOB_OFFSET + 7,
                    mohGatesID.mob.REIVE_MOB_OFFSET + 8,
                },
                obstacles =
                {
                    mohGatesID.mob.REIVE_MOB_OFFSET,
                    mohGatesID.mob.REIVE_MOB_OFFSET + 1,
                    mohGatesID.mob.REIVE_MOB_OFFSET + 2,
                },
                collision =
                {
                    mohGatesID.npc.REIVE_COLLISION_OFFSET + 2,
                    mohGatesID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },

            -- !pos 102 29.8 -160 269
            [2] =
            {
                mob =
                {
                    mohGatesID.mob.REIVE_MOB_OFFSET + 12,
                    mohGatesID.mob.REIVE_MOB_OFFSET + 13,
                    mohGatesID.mob.REIVE_MOB_OFFSET + 14,
                    mohGatesID.mob.REIVE_MOB_OFFSET + 15,
                    mohGatesID.mob.REIVE_MOB_OFFSET + 16,
                    mohGatesID.mob.REIVE_MOB_OFFSET + 17,
                },
                obstacles =
                {
                    mohGatesID.mob.REIVE_MOB_OFFSET + 9,
                    mohGatesID.mob.REIVE_MOB_OFFSET + 10,
                    mohGatesID.mob.REIVE_MOB_OFFSET + 11,
                },
                collision =
                {
                    mohGatesID.npc.REIVE_COLLISION_OFFSET,
                    mohGatesID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },
        },
    },

    [xi.zone.MORIMAR_BASALT_FIELDS] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {

            -- !pos 119.7 -0.08 -54.9 265
            [1] =
            {
                mob =
                {
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 3,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 4,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 5,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 6,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 7,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 8,
                },
                obstacles =
                {
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 0,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 1,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 2,
                },
                collision =
                {
                    morimarBasaltFieldsID.npc.REIVE_COLLISION_OFFSET + 4,
                    morimarBasaltFieldsID.npc.REIVE_COLLISION_OFFSET + 5,
                },
            },

            -- !pos -3.5 0.106 60 265
            [2] =
            {
                mob =
                {
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 12,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 13,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 14,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 15,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 16,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 17,
                },
                obstacles =
                {
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 9,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 10,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 11,
                },
                collision =
                {
                    morimarBasaltFieldsID.npc.REIVE_COLLISION_OFFSET + 2,
                    morimarBasaltFieldsID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },

            -- !pos -60 -15.89 -276.5 265
            [3] =
            {
                mob =
                {
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 21,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 22,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 23,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 24,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 25,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 26,
                },
                obstacles =
                {
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 18,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 19,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 20,
                },
                collision =
                {
                    morimarBasaltFieldsID.npc.REIVE_COLLISION_OFFSET + 10,
                    morimarBasaltFieldsID.npc.REIVE_COLLISION_OFFSET + 11,
                },
            },

            -- !pos -123 -15.89 -419.9 265
            [4] =
            {
                mob =
                {
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 30,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 31,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 32,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 33,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 34,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 35,
                },
                obstacles =
                {
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 27,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 28,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 29,
                },
                collision =
                {
                    morimarBasaltFieldsID.npc.REIVE_COLLISION_OFFSET + 12,
                    morimarBasaltFieldsID.npc.REIVE_COLLISION_OFFSET + 13,
                },
            },

            -- !pos -363 -31.89 -140 265
            [5] =
            {
                mob =
                {
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 48,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 49,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 50,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 51,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 52,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 53,
                },
                obstacles =
                {
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 45,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 46,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 47,
                },
                collision =
                {
                    morimarBasaltFieldsID.npc.REIVE_COLLISION_OFFSET + 6,
                    morimarBasaltFieldsID.npc.REIVE_COLLISION_OFFSET + 7,
                },
            },

            -- !pos -243 -47.89 399.9 265
            [6] =
            {
                mob =
                {
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 57,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 58,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 59,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 60,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 61,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 62,
                },
                obstacles =
                {
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 54,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 55,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 56,
                },
                collision =
                {
                    morimarBasaltFieldsID.npc.REIVE_COLLISION_OFFSET,
                    morimarBasaltFieldsID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos -240.7 -32.45 -219.4 265
            [7] =
            {
                mob =
                {
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 39,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 40,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 41,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 42,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 43,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 44,
                },
                obstacles =
                {
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 36,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 37,
                    morimarBasaltFieldsID.mob.REIVE_MOB_OFFSET + 38,
                },
                collision =
                {
                    morimarBasaltFieldsID.npc.REIVE_COLLISION_OFFSET + 8,
                    morimarBasaltFieldsID.npc.REIVE_COLLISION_OFFSET + 9,
                },
            },
        },
    },

    [xi.zone.OUTER_RAKAZNAR] =
    {
        reiveObjRespawnTime = 900, -- 15 minutes
        reiveMobRespawnTime = 60,  -- 1 minute
        reive =
        {

            -- !pos 743.4 100 120.1 274
            [1] =
            {
                mob =
                {
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 3,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 4,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 5,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 6,
                },
                obstacles =
                {
                    outerRakaznarID.mob.REIVE_MOB_OFFSET,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 1,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 2,
                },
                collision =
                {
                    outerRakaznarID.npc.REIVE_COLLISION_OFFSET,
                },
            },

            -- !pos 720 100 -175.4 274
            [2] =
            {
                mob =
                {
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 10,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 11,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 12,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 13,
                },
                obstacles =
                {
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 7,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 8,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 9,
                },
                collision =
                {
                    outerRakaznarID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos 424 100 -159.9 274
            [3] =
            {
                mob =
                {
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 17,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 18,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 19,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 20,
                },
                obstacles =
                {
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 14,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 15,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 16,
                },
                collision =
                {
                    outerRakaznarID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },

            -- !pos 440 100 135.2 274
            [4] =
            {
                mob =
                {
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 24,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 25,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 26,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 27,
                },
                obstacles =
                {
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 21,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 22,
                    outerRakaznarID.mob.REIVE_MOB_OFFSET + 23,
                },
                collision =
                {
                    outerRakaznarID.npc.REIVE_COLLISION_OFFSET + 2,
                },
            },
        },
    },

    [xi.zone.RAKAZNAR_INNER_COURT] =
    {
        reiveObjRespawnTime = 900, -- 15 minutes
        reiveMobRespawnTime = 60,  -- 1 minute
        reive =
        {
            -- !pos 894.2 100 199.8 276
            [1] =
            {
                mob =
                {
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 3,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 4,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 5,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 6,
                },
                obstacles =
                {
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 1,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 2,
                },
                collision =
                {
                    rakaznarInnerCourtID.npc.REIVE_COLLISION_OFFSET,
                },
            },

            -- !pos 519.9 100 228.6 276
            [2] =
            {
                mob =
                {
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 10,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 11,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 12,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 13,
                },
                obstacles =
                {
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 7,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 8,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 9,
                },
                collision =
                {
                    rakaznarInnerCourtID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos 506 90 -160 276
            [3] =
            {
                mob =
                {
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 17,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 18,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 19,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 20,
                },
                obstacles =
                {
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 14,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 15,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 16,
                },
                collision =
                {
                    rakaznarInnerCourtID.npc.REIVE_COLLISION_OFFSET + 2,
                },
            },

            -- !pos 879.9 90 -173.8 276
            [4] =
            {
                mob =
                {
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 24,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 25,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 26,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 27,
                },
                obstacles =
                {
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 21,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 22,
                    rakaznarInnerCourtID.mob.REIVE_MOB_OFFSET + 23,
                },
                collision =
                {
                    rakaznarInnerCourtID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },
        },
    },

    [xi.zone.SIH_GATES] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {

            -- !pos -118.8 -10 -99 268
            [1] =
            {
                mob =
                {
                    sihGatesID.mob.REIVE_MOB_OFFSET + 3,
                    sihGatesID.mob.REIVE_MOB_OFFSET + 4,
                    sihGatesID.mob.REIVE_MOB_OFFSET + 5,
                    sihGatesID.mob.REIVE_MOB_OFFSET + 6,
                    sihGatesID.mob.REIVE_MOB_OFFSET + 7,
                    sihGatesID.mob.REIVE_MOB_OFFSET + 8,
                },
                obstacles =
                {
                    sihGatesID.mob.REIVE_MOB_OFFSET,
                    sihGatesID.mob.REIVE_MOB_OFFSET + 1,
                    sihGatesID.mob.REIVE_MOB_OFFSET + 2,
                },
                collision =
                {
                    sihGatesID.npc.REIVE_COLLISION_OFFSET,
                    sihGatesID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos -77.9 -9.8 -259.9 268
            [2] =
            {
                mob =
                {
                    sihGatesID.mob.REIVE_MOB_OFFSET + 12,
                    sihGatesID.mob.REIVE_MOB_OFFSET + 13,
                    sihGatesID.mob.REIVE_MOB_OFFSET + 14,
                    sihGatesID.mob.REIVE_MOB_OFFSET + 15,
                    sihGatesID.mob.REIVE_MOB_OFFSET + 16,
                    sihGatesID.mob.REIVE_MOB_OFFSET + 17,
                },
                obstacles =
                {
                    sihGatesID.mob.REIVE_MOB_OFFSET + 9,
                    sihGatesID.mob.REIVE_MOB_OFFSET + 10,
                    sihGatesID.mob.REIVE_MOB_OFFSET + 11,
                },
                collision =
                {
                    sihGatesID.npc.REIVE_COLLISION_OFFSET + 2,
                    sihGatesID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },
        },
    },

    [xi.zone.WOH_GATES] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {

            -- !pos 276 30 99.5 273
            [1] =
            {
                mob =
                {
                    wohGatesID.mob.REIVE_MOB_OFFSET + 2,
                    wohGatesID.mob.REIVE_MOB_OFFSET + 3,
                    wohGatesID.mob.REIVE_MOB_OFFSET + 4,
                    wohGatesID.mob.REIVE_MOB_OFFSET + 5,
                },
                obstacles =
                {
                    wohGatesID.mob.REIVE_MOB_OFFSET,
                    wohGatesID.mob.REIVE_MOB_OFFSET + 1,
                },
                collision =
                {
                    wohGatesID.npc.REIVE_COLLISION_OFFSET,
                    wohGatesID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos 284 30.6 259.7 273
            [2] =
            {
                mob =
                {
                    wohGatesID.mob.REIVE_MOB_OFFSET + 8,
                    wohGatesID.mob.REIVE_MOB_OFFSET + 9,
                    wohGatesID.mob.REIVE_MOB_OFFSET + 10,
                    wohGatesID.mob.REIVE_MOB_OFFSET + 11,
                },
                obstacles =
                {
                    wohGatesID.mob.REIVE_MOB_OFFSET + 6,
                    wohGatesID.mob.REIVE_MOB_OFFSET + 7,
                },
                collision =
                {
                    wohGatesID.npc.REIVE_COLLISION_OFFSET + 2,
                    wohGatesID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },
        },
    },

    [xi.zone.YAHSE_HUNTING_GROUNDS] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {
            -- !pos -155.5 0.3 141.9 260
            [1] =
            {
                mob =
                {
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 17,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 18,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 19,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 20,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 21,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 22,
                },
                obstacles =
                {
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 14,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 15,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 16,
                },
                collision =
                {
                    yahseHuntingGroundsID.npc.REIVE_COLLISION_OFFSET + 8,
                    yahseHuntingGroundsID.npc.REIVE_COLLISION_OFFSET + 9,
                },
            },

            -- !pos 116 0.3 -177.9 260
            [2] =
            {
                mob =
                {
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 26,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 27,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 28,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 29,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 30,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 31,
                },
                obstacles =
                {
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 23,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 24,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 25,
                },
                collision =
                {
                    yahseHuntingGroundsID.npc.REIVE_COLLISION_OFFSET + 4,
                    yahseHuntingGroundsID.npc.REIVE_COLLISION_OFFSET + 5,
                },
            },

            -- !pos 153 0.49 -19.7 260
            [3] =
            {
                mob =
                {
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 10,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 11,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 12,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 13,
                },
                obstacles =
                {
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 7,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 8,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 9,
                },
                collision =
                {
                    yahseHuntingGroundsID.npc.REIVE_COLLISION_OFFSET + 0,
                    yahseHuntingGroundsID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos -315.7 0.41 -221 260
            [4] =
            {
                mob =
                {
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 35,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 36,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 37,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 38,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 39,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 40,
                },
                obstacles =
                {
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 32,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 33,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 34,
                },
                collision =
                {
                    yahseHuntingGroundsID.npc.REIVE_COLLISION_OFFSET + 6,
                    yahseHuntingGroundsID.npc.REIVE_COLLISION_OFFSET + 7,
                },
            },

            -- !pos 115 0.27 -176 260
            [5] =
            {
                mob =
                {
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 3,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 4,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 5,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 6,
                },
                obstacles =
                {
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 0,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 1,
                    yahseHuntingGroundsID.mob.REIVE_MOB_OFFSET + 2,
                },
                collision =
                {
                    yahseHuntingGroundsID.npc.REIVE_COLLISION_OFFSET + 2,
                    yahseHuntingGroundsID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },
        },
    },

    [xi.zone.YORCIA_WEALD] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {

            -- !pos 100 1.6 342 263
            [1] =
            {
                mob =
                {
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 2,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 3,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 4,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 5,
                },
                obstacles =
                {
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 0,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 1,
                },
                collision =
                {
                    yorciaWealdID.npc.REIVE_COLLISION_OFFSET + 0,
                },
            },

            -- !pos -102 1.57 180 263
            [2] =
            {
                mob =
                {
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 8,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 9,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 10,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 11,
                },
                obstacles =
                {
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 6,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 7,
                },
                collision =
                {
                    yorciaWealdID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },

            -- !pos 258 1.57 -140 263
            [3] =
            {
                mob =
                {
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 14,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 15,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 16,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 17,
                },
                obstacles =
                {
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 12,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 13,
                },
                collision =
                {
                    yorciaWealdID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos 60 1.63 -178 263
            [4] =
            {
                mob =
                {
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 20,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 21,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 22,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 23,
                },
                obstacles =
                {
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 18,
                    yorciaWealdID.mob.REIVE_MOB_OFFSET + 19,
                },
                collision =
                {
                    yorciaWealdID.npc.REIVE_COLLISION_OFFSET + 2,
                },
            },
        },
    },
}
