-----------------------------------
-- Sentinels' Honor
-- Aht Uhrgan Mission 33
-----------------------------------
-- !addmission 4 32
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.SENTINELS_HONOR)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.TESTING_THE_WATERS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    if
                        not mission:getMustZone(player) and
                        VanadielUniqueDay() >= mission:getVar(player, 'Timer')
                    then
                        return mission:progressEvent(3130, { text_table = 0 })
                    else
                        return mission:progressEvent(3120, { text_table = 0 })
                    end
                end,
            },

            onEventFinish =
            {
                [3130] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
