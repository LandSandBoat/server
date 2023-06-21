-----------------------------------
-- Written in the Stars
-- Windurst M3-2
-----------------------------------
-- !addmission 2 11
-- Rakoh Buuma      : !pos 106 -5 -23 241
-- Mokyokyo         : !pos -55 -8 227 238
-- Janshura-Rashura : !pos -227 -8 184 240
-- Zokima-Rokima    : !pos 0 -16 124 239
-- Zubaba           : !pos 15 -27 18 242
-- Gate of Light    : !pos -331 0 139 192
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.WRITTEN_IN_THE_STARS)

mission.reward =
{
    -- Base Rank Point Value, First time completion awards 500
    rankPoints = 400,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 11 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.PORT_WINDURST] =
        {
            onEventFinish =
            {
                [78] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            onEventFinish =
            {
                [93] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            onEventFinish =
            {
                [111] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            onEventFinish =
            {
                [114] = handleAcceptMission,
            },
        },
    },

    -- Has not completed A New Journey, and first time running this mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                not player:hasCompletedMission(mission.areaId, mission.missionId) and
                not player:hasCompletedMission(mission.areaId, mission.missionId + 1)
        end,

        [xi.zone.HEAVENS_TOWER] =
        {
            ['Zubaba'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(121)
                    elseif missionStatus == 1 then
                        return mission:progressEvent(122)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(135)
                    end
                end,
            },

            onEventFinish =
            {
                [121] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.CHARM_OF_LIGHT)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [135] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:addRankPoints(100)
                    end
                end,
            },
        },

        [xi.zone.INNER_HORUTOTO_RUINS] =
        {
            ['_5ci'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(41, 0, xi.ki.CHARM_OF_LIGHT)
                    end
                end,
            },

            onEventFinish =
            {
                [41] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    player:delKeyItem(xi.ki.CHARM_OF_LIGHT)
                end,
            }
        },
    },

    -- Repeating or has completed the next mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                (player:hasCompletedMission(mission.areaId, mission.missionId) or
                player:hasCompletedMission(mission.areaId, mission.missionId + 1))
        end,

        [xi.zone.HEAVENS_TOWER] =
        {
            ['Zubaba'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:getMissionStatus(mission.areaId) == 3 and
                        npcUtil.tradeHasExactly(trade, { { xi.items.RUSTY_DAGGER, 3 } })
                    then
                        return mission:progressEvent(151)
                    end
                end,

                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(257, 0, xi.items.RUSTY_DAGGER)
                    elseif missionStatus == 3 then
                        return mission:progressEvent(150, 0, xi.items.RUSTY_DAGGER)
                    end
                end,
            },

            onEventFinish =
            {
                [151] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:confirmTrade()
                    end
                end,

                [257] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                end,
            },
        },
    },
}

return mission
