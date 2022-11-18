-----------------------------------
-- The Final Seal
-- Windurst M5-1
-----------------------------------
-- No active missions, Rank 4, !addkeyitem 71
-- Mokyokyo              : !pos -55 -8 227 238
-- Janshura-Rashura      : !pos -227 -8 184 240
-- Rakoh Buuma           : !pos 106 -5 -23 241
-- Zokima-Rokima         : !pos 0 -16 124 239
-- Vestal Chamber (_6q2) : !pos 0.1 -49 37 242
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/titles')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_FINAL_SEAL)

mission.reward =
{
    rankPoints = 600,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 0 then
        mission:begin(player)
        player:setMissionStatus(mission.areaId, 10)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
        npcUtil.giveKeyItem(player, xi.ki.NEW_FEIYIN_SEAL)
    end

    player:delKeyItem(xi.ki.MESSAGE_TO_JEUNO_WINDURST)
end

mission.sections =
{
    -- Player meets requirements, but has not started the mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId and
                player:getRank(player:getNation()) == 5 and
                not player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mokyokyo'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(232)
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Janshura-Rashura'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(163)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Rakoh_Buuma'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(197)
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Zokima-Rokima'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(150)
                end,
            },
        },

        [xi.zone.HEAVENS_TOWER] =
        {
            ['_6q2'] =
            {
                onTrigger = function(player, npc)
                    -- This mission is handled a bit differently when compared to Bastok and San d'Oria.  Without
                    -- the need of gate guard interaction, KI tracking is used to determine whether its the first
                    -- or subsequent time the door has been triggered.
                    if player:hasKeyItem(xi.ki.MESSAGE_TO_JEUNO_WINDURST) then
                        return mission:progressEvent(166)
                    else
                        return mission:progressEvent(190)
                    end
                end,
            },

            onEventFinish =
            {
                [166] = handleAcceptMission,
                [190] = handleAcceptMission,
            },
        },
    },

    -- Mission has been accepted
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.HEAVENS_TOWER] =
        {
            ['_6q2'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 12 and
                        player:hasKeyItem(xi.ki.BURNT_SEAL)
                    then
                        return mission:progressEvent(192)
                    end
                end,
            },

            onEventFinish =
            {
                [192] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.BURNT_SEAL)
                    end
                end,
            },
        },

        [xi.zone.FEIYIN] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 10 then
                        return 1
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 11)
                end,
            },
        },

        [xi.zone.QUBIA_ARENA] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 11 and
                        player:getLocalVar('battlefieldWin') == 512
                    then
                        npcUtil.giveKeyItem(player, xi.ki.BURNT_SEAL)
                        player:setMissionStatus(mission.areaId, 12)
                        player:delKeyItem(xi.ki.NEW_FEIYIN_SEAL)
                    end
                end,
            },
        },
    },
}

return mission
