-----------------------------------
-- Glimmer of Portent
-- Seekers of Adoulin M3-6-5
-----------------------------------
-- !addmission 12 70
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.GLIMMER_OF_PORTENT)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.INTO_THE_FIRE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Timer') <= VanadielUniqueDay() then
                        return mission:progressEvent(154, 256, 0, 255, 0)
                    else
                        return mission:event(152)
                    end
                end,
            },

            onEventFinish =
            {
                [154] = function(player, csid, option, npc)
                    if option == 1 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
