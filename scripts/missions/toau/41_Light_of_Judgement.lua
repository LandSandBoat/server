-----------------------------------
-- Light of Judgement
-- Aht Uhrgan Mission 41
-----------------------------------
-- !addmission 4 39
-- Rodin-Comidin : !pos 17.205 -5.999 51.161 50
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.LIGHT_OF_JUDGMENT)

mission.reward =
{
    keyItem     = xi.ki.NYZUL_ISLE_ROUTE,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.PATH_OF_DARKNESS },
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

            ['Rodin-Comidin'] = mission:progressEvent(3137, { text_table = 0 }),

            onEventFinish =
            {
                [3137] = function(player, csid, option, npc)
                    if option == 0 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
