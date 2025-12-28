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
                    local hasZoned      = not mission:getMustZone(player)
                    local hasTimePassed = VanadielUniqueDay() >= mission:getVar(player, 'Timer')

                    -- Calculate event.
                    local eventId = (hasZoned and hasTimePassed) and 3130 or 3120

                    -- Calculate dialog.
                    local dialog = 2

                    if not hasTimePassed then -- Dialog parameter cycles between 0 and 2 until time lockout is over. At that point, option 0 stops happening.
                        dialog = mission:getVar(player, 'Option')
                        if dialog == 0 then
                            mission:setVar(player, 'Option', 2)
                        else
                            mission:setVar(player, 'Option', 0)
                        end
                    end

                    return mission:event(eventId, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, dialog, 0)
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
