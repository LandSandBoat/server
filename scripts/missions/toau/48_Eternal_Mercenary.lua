-----------------------------------
-- Eternal Mercenary
-- Aht Uhrgan Mission 48 (Last)
-----------------------------------
-- !addmission 4 47
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.ETERNAL_MERCENARY)

mission.reward = {}

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
                    return mission:event(3151, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0):replaceDefault()
                end,
            },
        },
    },
}

return mission
