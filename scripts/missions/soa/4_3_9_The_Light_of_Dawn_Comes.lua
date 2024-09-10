-----------------------------------
-- The Light of Dawn Comes from the East
-- Seekers of Adoulin M4-3-9
-----------------------------------
-- !addmission 12 92
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_LIGHT_OF_DAWN_COMES)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.CRIES_FROM_THE_DEEP },
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
                        return mission:progressEvent(177, 256, 0, 255, 255, 255, 255, 255, 0)
                    else
                        return mission:event(166)
                    end
                end,
            },

            onEventFinish =
            {
                [177] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
