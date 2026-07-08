-----------------------------------
-- The Watergarden Coliseum
-- Seekers of Adoulin M2-4-1
-----------------------------------
-- !addmission 12 19
-- Yeggha_Dolashi : !pos 260 -5.768 60 258
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_WATERGARDEN_COLISEUM)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.FRICTION_AND_FISSURES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Yeggha_Dolashi'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(0)
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.mission.setVar(player, xi.mission.log_id.SOA, xi.mission.id.soa.FRICTION_AND_FISSURES, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },
}

return mission
