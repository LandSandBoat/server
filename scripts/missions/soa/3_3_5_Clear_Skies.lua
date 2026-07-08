-----------------------------------
-- The Disappearance of Nyline
-- Seekers of Adoulin M3-3-3
-----------------------------------
-- !addmission 12 50
-- Levil : !pos -87.204 3.350 12.655 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.CLEAR_SKIES)

mission.reward =
{
    bayld       = 100,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_MAN_IN_BLACK },
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
                        return mission:progressEvent(133)
                    else
                        return mission:event(141)
                    end
                end,
            },

            onEventFinish =
            {
                [133] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
