-----------------------------------
-- Fangs of the Lion
-- Aht Uhrgan Mission 43
-----------------------------------
-- !addmission 4 42
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.FANGS_OF_THE_LION)

mission.reward =
{
    keyItem     = xi.ki.MYTHRIL_MIRROR,
    title       = xi.title.NASHMEIRAS_LOYALIST,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.NASHMEIRAS_PLEA },
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
                    return mission:progressEvent(3138, { text_table = 0 })
                end,
            },

            onEventFinish =
            {
                [3138] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
