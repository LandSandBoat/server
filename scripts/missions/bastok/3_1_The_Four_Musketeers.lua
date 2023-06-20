-----------------------------------
-- The Four Musketeers
-- Bastok M3-1
-----------------------------------
-- !addmission 1 10
-- Argus      : !pos 132.157 7.496 -2.187 236
-- Cleades    : !pos -358 -10 -168 235
-- Malduc     : !pos 66.200 -14.999 4.426 237
-- Rashid     : !pos -8.444 -2 -123.575 234
-- Iron Eater : !pos 92.936 -19.532 1.814 237
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_FOUR_MUSKETEERS)

mission.reward =
{
    rankPoints = 350,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 10 then
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

        [xi.zone.BASTOK_MARKETS] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.METALWORKS] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Cleades'] = mission:progressEvent(1002),
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Rashid'] = mission:progressEvent(1002),
        },

        [xi.zone.METALWORKS] =
        {
            ['Ayame'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) > 0 then
                        return mission:event(718)
                    end
                end,
            },

            ['Iron_Eater'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(715)
                    else
                        return mission:event(716)
                    end
                end,
            },

            ['Malduc'] = mission:progressEvent(1002),

            ['Naji'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) > 0 then
                        return mission:event(717)
                    end
                end,
            },

            onEventFinish =
            {
                [715] = function(player, csid, option, npc)
                    if option == 0 then
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,
            },
        },

        [xi.zone.BEADEAUX] =
        {
            ['Copper_Quadav'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if
                        missionStatus > 1 and
                        missionStatus < 22
                    then
                        player:setMissionStatus(mission.areaId, missionStatus + 1)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 120
                    end
                end,
            },

            onEventFinish =
            {
                [120] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                    player:setPos(-297, 1, 96, 1)
                end,
            },
        },

        [xi.zone.PASHHOW_MARSHLANDS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.BEADEAUX then
                        local missionStatus = player:getMissionStatus(mission.areaId)

                        if
                            missionStatus > 1 and
                            missionStatus < 22
                        then
                            return 10
                        elseif missionStatus == 22 then
                            return 11
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    player:setPos(578, 25, -376, 126)
                end,

                [11] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setPos(578, 25, -376, 126)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:progressEvent(1002),
        },
    },
}

return mission
