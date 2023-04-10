-----------------------------------
-- The Twin World Trees
-- Seekers of Adoulin M2-3
-----------------------------------
-- !addmission 12 17
-- Oscairn : !pos -80.214 -0.150 30.717 257
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_TWIN_WORLD_TREES)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.HONOR_AND_AUDACITY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            -- Note: This message persists over several missions.  Once a breakpoint is found,
            -- this should be a replaceDefault after completion of the initial change.
            ['Levil'] = mission:event(127),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            onTriggerAreaEnter =
            {
                [2] = function(player, triggerArea)
                    if mission:getVar(player, 'Timer') <= VanadielUniqueDay() then
                        return mission:progressEvent(1503)
                    end
                end,
            },

            onEventFinish =
            {
                [1503] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
