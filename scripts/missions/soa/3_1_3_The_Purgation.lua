-----------------------------------
-- The Purgation
-- Seekers of Adoulin M3-1-3
-----------------------------------
-- !addmission 12 40
-- Erminold : !pos 50.949 -40 -90.942 257
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_PURGATION)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_KEY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            -- TODO: Continue to check if Levil's dialogue changes.  This event has been
            -- repeated for several missions.

            ['Levil'] = mission:event(138),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Erminold'] = mission:event(1526):replaceDefault(),

            onRegionEnter =
            {
                [1] = function(player, region)
                    return mission:progressEvent(1510)
                end,
            },

            onEventFinish =
            {
                [1510] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.mission.setVar(player, xi.mission.log_id.SOA, xi.mission.id.soa.THE_KEY, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },
}

return mission
