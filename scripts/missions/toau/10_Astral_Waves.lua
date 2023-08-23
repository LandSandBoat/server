-----------------------------------
-- Astral Waves
-- Aht Uhrgan Mission 10
-----------------------------------
-- !addmission 4 9
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.ASTRAL_WAVES)

mission.reward =
{
    keyItem     = xi.ki.ASTRAL_COMPASS,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.IMPERIAL_SCHEMES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = mission:progressEvent(3052, { text_table = 0 }),

            onEventFinish =
            {
                [3052] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setCharVar('Mission[4][10]Timer', VanadielUniqueDay() + 1)
                        player:setLocalVar('Mission[4][10]mustZone', 1)
                    end
                end,
            },
        },
    },
}

return mission
