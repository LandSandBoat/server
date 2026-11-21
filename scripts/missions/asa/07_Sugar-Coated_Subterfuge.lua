-----------------------------------
-- Sugar-Coated Subterfuge
-- A Shantotto Ascension M7
-----------------------------------
-- !addmission 11 6
-- Aldo : !pos 19.7 3.9 -59 245
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_SUBTERFUGE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.SHANTOTTO_IN_CHAINS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] = mission:progressEvent(10100),

            onEventFinish =
            {
                [10100] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
