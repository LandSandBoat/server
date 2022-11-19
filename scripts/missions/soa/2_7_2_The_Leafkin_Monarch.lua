-----------------------------------
-- The Leafkin Monarch
-- Seekers of Adoulin M2-7-2
-----------------------------------
-- !addmission 12 34
-- Ploh Trishbahk (trigger area) : !pos 100.580 -40.150 -63.830 257
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_LEAFKIN_MONARCH)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.YGGDRASIL },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    return mission:progressEvent(1507)
                end,
            },

            onEventFinish =
            {
                [1507] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.mission.setVar(player, xi.mission.log_id.SOA, xi.mission.id.soa.YGGDRASIL, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },
}

return mission
