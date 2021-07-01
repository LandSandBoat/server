-----------------------------------
-- The Shadow Lord
-- San d'Oria M5-2
-----------------------------------
-- !addmission 0 15
-- Ambrotien            : !pos 93.419 -0.001 -57.347 230
-- Grilau               : !pos -241.987 6.999 57.887 231
-- Endracion            : !pos -110 1 -34 230
-- Halver               : !pos 2 0.1 0.1 233
-- Door: Prince Royal's : !pos -38 -3 73 233
-- Door: Great Hall     : !pos 0 -1 13 233
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local chateauID = require("scripts/zones/Chateau_dOraguille/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_SHADOW_LORD)

mission.reward =
{
    -- Rank 6 is awarded prior to completing mission
    gil = 20000,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 15 then
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
                    if player:getMissionStatus(mission.areaId) == 5 then
                        return mission:progressEvent(85)
                    end
                end,
            },

            ['Chupaile'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 5 then
                        return mission:progressEvent(86)
                    end
                end,
            },

            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(546)
                    elseif
                        missionStatus == 4 and
                        player:hasKeyItem(xi.ki.SHADOW_FRAGMENT)
                    then
                        return mission:progressEvent(548)
                    elseif missionStatus == 5 then
                        return mission:messageText(chateauID.text.HALVER_OFFSET + 471):replaceDefault()
                    end
                end,
            },

            ['_6h0'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(547)
                    end
                end,
            },

            ['_6h4'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 5 then
                        return mission:progressEvent(61)
                    end
                end,
            },

            onEventFinish =
            {
                [61] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.SHADOW_FRAGMENT)
                    end
                end,

                [546] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [547] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,

                [548] = function(player, csid, option, npc)
                    player:setRank(6)
                    player:setRankPoints(0)
                    player:setMissionStatus(mission.areaId, 5)
                end,
            },
        },

        [xi.zone.THRONE_ROOM] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        if
                            player:getCurrentMission(xi.mission.log_id.ZILART) ~= xi.mission.id.zilart.THE_NEW_FRONTIER and
                            not player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_NEW_FRONTIER)
                        then
                            -- Don't add missions we already completed. Players who change nation will hit this.
                            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_NEW_FRONTIER)
                        end

                        return mission:progressEvent(7)
                    end
                end,

                [7] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.SHADOW_FRAGMENT)
                    player:setMissionStatus(mission.areaId, 4)
                    player:setPos(378, -12, -20, 125, 161)
                end,
            },
        },
    },

    -- Optional Dialogue after Completion
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    if player:getCurrentMission(mission.areaId) == xi.mission.id.sandoria.NONE then
                        return mission:messageText(chateauID.text.HALVER_OFFSET + 500):replaceDefault()
                    end
                end,
            },
        },
    },

    -- This cutscenes below are displayed any time after completing the Shadow Lord BCNM, up until
    -- the next mission is accepted.  This is handled in both sections.
    {
        check = function(player, currentMission, missionStatus, vars)
            return (currentMission == mission.missionId and player:getMissionStatus(mission.areaId) >= 4) or
                (
                    player:getCurrentMission(mission.areaId) == xi.mission.id.sandoria.NONE and
                    not player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.LEAUTE_S_LAST_WISHES)
                )
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Aramaviont'] = mission:progressEvent(12),
            ['Curilla']    = mission:progressEvent(56),
            ['Milchupain'] = mission:progressEvent(33),
            ['Rahal']      = mission:progressEvent(77),
        },
    },
}

return mission
