-----------------------------------
-- Purple, The New Black
-- Wings of the Goddess Mission 7
-----------------------------------
-- !delmission 5 6
-- !addmission 5 6
-- !setmissionstatus <player> 1 5 0
-- _2d1 (Reinforced Gateway) : !pos -114.386 -3.599 -179.804 85
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.PURPLE_THE_NEW_BLACK)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.IN_THE_NAME_OF_THE_FATHER },
}

mission.sections =
{
    -- 0: Pre-BCNM CS
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.LA_VAULE_S] =
        {
            ['_2d1'] = mission:progressEvent(2, 85, 3456, utils.MAX_UINT32 - 207616, 1525, 0, 19550816, 0, 0),

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },
    },

    -- 1: Enter the BCNM vs Galarhigg
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus >= 1
        end,

        [xi.zone.LA_VAULE_S] =
        {
            onZoneIn = function(player, prevZone)
                if player:getMissionStatus(mission.areaId) == 2 then
                    return 6
                end
            end,

            onEventFinish =
            {
                -- Completed BCNM
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.PURPLE_THE_NEW_BLACK then
                        player:setMissionStatus(mission.areaId, 2)
                        player:setPos(-260.44, 0.134, -156.652, 192, xi.zone.LA_VAULE_S)
                    end
                end,

                [6] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
