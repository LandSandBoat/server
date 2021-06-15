-----------------------------------
-- Journey Abroad
-- San d'Oria M2-3 (Part 0)
-----------------------------------
-- !addmission 0 5
-- Ambrotien       : !pos 93.419 -0.001 -57.347 230
-- Grilau          : !pos -241.987 6.999 57.887 231
-- Endracion       : !pos -110 1 -34 230
-- Halver          : !pos 2 0.1 0.1 233
-- Mourices        : !pos -50.646 -0.501 -27.642 241
-- Savae E Paleade : !pos 23.724 -17.39 -43.360 237
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_ABROAD)

mission.reward =
{
    rank    = 3,
    gil     = 3000,
    keyItem = xi.ki.ADVENTURERS_CERTIFICATE,
    title   = xi.title.CERTIFIED_ADVENTURER,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 5 then
        mission:begin(player)
    end
end

mission.sections =
{
    -- Player has no active missions
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
                [2009] = handleAcceptMission,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 11 then
                        return mission:progressEvent(507)
                    elseif missionStatus == 0 then
                        return mission:progressEvent(505)
                    else
                        return mission:progressEvent(532)
                    end
                end,
            },

            onEventFinish =
            {
                [505] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_THE_CONSULS_SANDORIA)
                end,

                [507] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.KINDRED_REPORT)
                    end
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Savae_E_Paleade'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    -- Part I - Bastok > Windurst
                    if missionStatus == 2 then
                        return mission:progressEvent(204)
                    -- Part II - Windurst > Bastok
                    elseif missionStatus == 7 then
                        return mission:progressEvent(206)
                    end
                end,
            },

            onEventFinish =
            {
                [204] = function(player, csid, option, npc)
                    player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_BASTOK)
                    player:setMissionStatus(mission.areaId, 3)
                    player:delKeyItem(xi.ki.LETTER_TO_THE_CONSULS_SANDORIA)
                end,

                [206] = function(player, csid, option, npc)
                    player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_BASTOK2)
                    player:setMissionStatus(mission.areaId, 8)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Mourices'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    -- Part I - Windurst > Bastok
                    if missionStatus == 2 then
                        player:startEvent(448)
                    elseif missionStatus == 7 then
                        player:startEvent(458) -- TODO: Verify this, status 7 is a different mission, and might have been dead code
                    -- Part II - Bastok > Windurst
                    elseif missionStatus == 6 then
                        player:startEvent(462)
                    elseif missionStatus == 11 then
                        player:startEvent(468) -- TODO: Verify this, might have been dead code
                    end
                end,
            },

            onEventFinish =
            {
                [448] = function(player, csid, option, npc)
                    player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_WINDURST)
                    player:setMissionStatus(mission.areaId, 3)
                    player:delKeyItem(xi.ki.LETTER_TO_THE_CONSULS_SANDORIA)
                end,

                [462] = function(player, csid, option, npc)
                    player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_WINDURST2)
                    player:setMissionStatus(mission.areaId, 7)
                end,
            },
        },
    },
}

return mission
