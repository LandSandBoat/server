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

-- Bits
-- 0 -> Lower Jeuno Aldo interaction. Optional.
-- 1 -> Lower Delkfutt tower Zone-in cutscene. Optional. Yes. Really.

mission.sections =
{
    -- Section: Mission Active
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.LOWER_DELKFUTTS_TOWER] =
        {
            onZoneIn = function(player, prevZone)
                local previousZone = player:getPreviousZone()
                if
                    previousZone == xi.zone.QUFIM_ISLAND and
                    not mission:isVarBitsSet(player, 'Option', 1)
                then
                    return 15 -- Optional cutscene. Only triggers from qufim entrance.
                elseif previousZone == xi.zone.MIDDLE_DELKFUTTS_TOWER then
                    return 14 -- Ensure regular entering CS plays.
                end
            end,

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Option', 1)
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Option', 0) then
                        return mission:progressEvent(104, 0, 1, 255, 0, 12590582, 95569, 4095, 1)
                    else
                        return mission:event(68)
                    end
                end,
            },

            onEventFinish =
            {
                [104] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Option', 0)
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] = mission:event(13),
        },

        [xi.zone.STELLAR_FULCRUM] =
        {
            onZoneIn = function(player, prevZone)
                local missionStatus = player:getMissionStatus(mission.areaId)
                if missionStatus == 0 then
                    return 0 -- Pre-Battle.
                elseif missionStatus == 2 then
                    return 17 -- Post-Battle. Mission complete event.
                elseif player:getPreviousZone() == xi.zone.UPPER_DELKFUTTS_TOWER then
                    return 7 -- Ensure regular entering CS plays.
                end
            end,

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
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [17] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.RETURN_TO_DELKFUTTS_TOWER then
                        player:setMissionStatus(mission.areaId, 2)
                        player:setPos(-519.99, 1.076, -19.943, 64, xi.zone.STELLAR_FULCRUM)
                    end
                end,
            },
        },
    },
}

return mission
