-----------------------------------
-- Leaute's Last Wishes
-- San d'Oria M6-1
-----------------------------------
-- !addmission 0 16
-- Ambrotien        : !pos 93.419 -0.001 -57.347 230
-- Grilau           : !pos -241.987 6.999 57.887 231
-- Endracion        : !pos -110 1 -34 230
-- Halver           : !pos 2 0.1 0.1 233
-- Door: Great Hall : !pos 0 -1 13 233
-- Chalvatot        : !pos -105 0.1 72 233
-- Dreamrose        : !pos -262.403 -10.155 49.164 125
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local westernAltepaID = require('scripts/zones/Western_Altepa_Desert/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.LEAUTES_LAST_WISHES)

mission.reward =
{
    rankPoints = 600,
    keyItem    = xi.ki.PIECE_OF_PAPER,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 16 then
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

    -- Player has accepted the mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Arsha'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(85)
                    end
                end,
            },

            ['Chupaile'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(86)
                    end
                end,
            },

            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(25)
                    elseif missionStatus == 1 then
                        return mission:progressEvent(23)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(24)
                    elseif missionStatus == 3 then
                        return mission:progressEvent(22)
                    end
                end,
            },

            ['_6h4'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(87)
                    end
                end,
            },

            onTriggerAreaEnter =
            {
                [2] = function(player, triggerArea)
                    if
                        player:getMissionStatus(mission.areaId) == 4 and
                        player:hasKeyItem(xi.ki.DREAMROSE)
                    then
                        return mission:progressEvent(111)
                    end
                end,
            },

            onEventFinish =
            {
                [22] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                end,

                [25] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [87] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,

                [111] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.DREAMROSE)
                    end
                end,
            },
        },

        [xi.zone.WESTERN_ALTEPA_DESERT] =
        {
            ['Dreamrose'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        (not GetMobByID(westernAltepaID.mob.SABOTENDER_ENAMORADO):isSpawned() or
                        GetMobByID(westernAltepaID.mob.SABOTENDER_ENAMORADO):isDead())
                    then
                        if mission:getVar(player, 'Progress') == 1 then
                            mission:setVar(player, 'Progress', 0)
                            player:setMissionStatus(mission.areaId, 3)
                            return mission:keyItem(xi.ki.DREAMROSE)
                        else
                            SpawnMob(westernAltepaID.mob.SABOTENDER_ENAMORADO):updateClaim(player)
                            return mission:messageSpecial(westernAltepaID.text.FEEL_SOMETHING_PRICKLY)
                        end
                    end
                end,
            },

            ['Sabotender_Enamorado'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        mission:setVar(player, 'Progress', 1)
                    end
                end,
            },
        },
    },
}

return mission
