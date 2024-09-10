-----------------------------------
-- The Scent of Battle
-- Wings of the Goddess Mission 27
-----------------------------------
-- !addmission 5 26
-- Bulwark Gate : !pos -447.174 -1.831 342.417 98
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.THE_SCENT_OF_BATTLE)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.ANOTHER_WORLD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.SAUROMUGUE_CHAMPAIGN_S] =
        {
            ['Bulwark_Gate'] = mission:progressEvent(9, 98, 5, 0, 0, utils.MAX_UINT32 - 1611137536, utils.MAX_UINT32 - 41990201, 3, 1),

            onEventFinish =
            {
                [9] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
