-----------------------------------
-- Misplaced Nobility
-- Aht Uhrgan Mission 27
-----------------------------------
-- !addmission 4 26
-- blank_toau20 : !pos -298 36 -38 68
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.MISPLACED_NOBILITY)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.BASTION_OF_KNOWLEDGE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AYDEEWA_SUBTERRANE] =
        {
            ['blank_toau20'] = mission:progressEvent(12),

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
