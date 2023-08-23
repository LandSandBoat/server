-----------------------------------
-- Social Graces
-- Aht Uhrgan Mission 23
-----------------------------------
-- !addmission 4 22
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.SOCIAL_GRACES)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.FOILED_AMBITION },
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
                    return mission:progressEvent(3095)
                end,
            },

            onEventFinish =
            {
                [3095] = function(player, csid, option, npc)
                    player:setLocalVar('Mission[4][23]mustZone', 1)
                    player:setCharVar('Mission[4][23]Timer', VanadielUniqueDay() + 1)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
