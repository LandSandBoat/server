-----------------------------------
-- Flight of the Lion
-- Wings of the Goddess Mission 35
-----------------------------------
-- !addmission 5 34
-- Bulwark Gate : !pos -447.174 -1.831 342.417 98
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.FLIGHT_OF_THE_LION)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.FALL_OF_THE_HAWK },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.SAUROMUGUE_CHAMPAIGN_S] =
        {
            ['Bulwark_Gate'] = mission:progressEvent(10, 98, 300, 200, 100, 0, 9240578, 0, 0),

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
