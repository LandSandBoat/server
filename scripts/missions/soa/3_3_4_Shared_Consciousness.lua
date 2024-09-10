-----------------------------------
-- Shared Consciousness
-- Seekers of Adoulin M3-3-4
-----------------------------------
-- !addmission 12 49
-- Levil          : !pos -87.204 3.350 12.655 256
-- Boarding House : !pos -41.693 -0.15 -38.29 257
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.SHARED_CONSCIOUSNESS)

mission.reward =
{
    exp         = 1000,
    bayld       = 1000,
    title       = xi.title.SUNSHINE_CADET,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.CLEAR_SKIES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(141),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Door_Boarding_House'] = mission:progressEvent(1513),

            onEventFinish =
            {
                [1513] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.mission.setVar(player, xi.mission.log_id.SOA, xi.mission.id.soa.CLEAR_SKIES, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },
}

return mission
