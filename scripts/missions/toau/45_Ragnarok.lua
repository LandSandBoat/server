-----------------------------------
-- Ragnarok
-- Aht Uhrgan Mission 45
-----------------------------------
-- !addmission 4 44
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.RAGNAROK)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.IMPERIAL_CORONATION },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onTriggerAreaEnter =
            {
                [3] = function(player, triggerArea)
                    return mission:progressEvent(3139, 0, 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },

            onEventFinish =
            {
                [3139] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
