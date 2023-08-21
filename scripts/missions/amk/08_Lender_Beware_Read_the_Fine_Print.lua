-----------------------------------
-- Lender Beware! Read the Fine Print
-- A Moogle Kupo d'Etat M8
-- !addmission 10 7
-- Shady Sconce       : !pos -179.563 24.093 274.055 176
-- Waterfall Basin    : !pos 104.888 0.477 -114.185 176
-- Inconspicuous Door : !pos -15 1.300 68 244
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.LENDER_BEWARE_READ_THE_FINE_PRINT)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.RESCUE_A_MOOGLES_LABOR_OF_LOVE },
}

mission.sections =
{
    -- 0: Shady Sconce
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.SEA_SERPENT_GROTTO] =
        {
            ['Shady_Sconce'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(19, 176)
                end,
            },

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setMissionStatus(xi.mission.log_id.AMK, 1)
                    end
                end,
            },
        },
    },

    -- 1: Waterfall Basin
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.SEA_SERPENT_GROTTO] =
        {
            ['Shady_Sconce'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(22)
                end,
            },

            ['Waterfall_Basin'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(20)
                end,
            },

            onEventFinish =
            {
                [20] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.AMK, 2)
                end,
            },
        },
    },

    -- 2: Inconspicuous Door
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 2
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Inconspicuous_Door'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(10184)
                end,
            },

            onEventFinish =
            {
                [10184] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
