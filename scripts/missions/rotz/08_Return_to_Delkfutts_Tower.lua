-----------------------------------
-- Return to Delkfutt's Tower
-- Zilart M8
-----------------------------------
-- !addmission 3 16
-- Gilgamesh              : !pos 122.452 -9.009 -12.052 252
-- Aldo                   : !pos 20 3 -58 245
-- Lower Delkfutt's Tower : !zone 184
-- Stellar Fulcrum        : !zone 179
-- Qe'Lov Gate (BCNM)     : !pos -520 -4 17 179
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.ROMAEVE },
}

mission.sections =
{
    -- Section: Mission Active
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Option') == 0 then
                        return mission:progressEvent(104, 0, 1, 255, 0, 12590582, 95569, 4095, 1)
                    else
                        return mission:event(68)
                    end
                end,
            },

            onEventFinish =
            {
                [104] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 1)
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] = mission:event(13),
        },
    },

    -- Section: Mission Active and missionStatus == 0
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.LOWER_DELKFUTTS_TOWER] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 15
                end,
            },

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },
    },

    -- Section: Mission Active and missionStatus == 1
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.STELLAR_FULCRUM] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 0
                end,
            },

            onEventUpdate =
            {
                [0] = function(player, csid, option, npc)
                    if option == 0 then
                        player:updateEvent(1, 23, 1756, 488, 179, 7, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },
    },

    -- Section: Mission Active and missionStatus == 2
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus >= 2
        end,

        [xi.zone.STELLAR_FULCRUM] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        return 17
                    end
                end,
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == 256 then
                        player:setMissionStatus(mission.areaId, 3)
                        player:setPos(-519.99, 1.076, -19.943, 64, xi.zone.STELLAR_FULCRUM)
                    end
                end,
            },
        },
    },
}

return mission
