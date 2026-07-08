-----------------------------------
-- Dark Clouds Ahead
-- Seekers of Adoulin M3-2-1
-----------------------------------
-- !addmission 12 43
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.DARK_CLOUDS_AHEAD)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_SMALLEST_OF_FAVORS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:progressEvent(132),

            onEventFinish =
            {
                [132] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.mission.setVar(player, xi.mission.log_id.SOA, xi.mission.id.soa.THE_SMALLEST_OF_FAVORS, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },
}

return mission
