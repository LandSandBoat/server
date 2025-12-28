-----------------------------------
-- The Dolphin Crest
-- Aht Uhrgan Mission 14
-----------------------------------
-- !addmission 4 13
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.THE_DOLPHIN_CREST)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.THE_BLACK_COFFIN },
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
                    return mission:progressEvent(3072, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },

            onEventFinish =
            {
                [3072] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
