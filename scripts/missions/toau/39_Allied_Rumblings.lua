-----------------------------------
-- Allied Rumblings
-- Aht Uhrgan Mission 39
-----------------------------------
-- !addmission 4 38
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.ALLIED_RUMBLINGS)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.UNRAVELING_REASON },
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
                    return mission:event(3148, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    return mission:progressEvent(10097, 0, 0, 0, 0, 0, 0, 0, 0)
                end,
            },

            onEventFinish =
            {
                [10097] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setLocalVar('Mission[4][39]mustZone', 1)
                        player:setCharVar('Mission[4][39]Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },
}

return mission
