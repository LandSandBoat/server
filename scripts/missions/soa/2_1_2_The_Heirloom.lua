-----------------------------------
-- The Heirloom
-- Seekers of Adoulin M2-1-2
-----------------------------------
-- !addmission 12 13
-- Ploh Trishbahk (trigger area) : !pos 100.580 -40.150 -63.830 257
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_HEIRLOOM)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.AN_AIMLESS_JOURNEY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(103),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    return mission:progressEvent(1502)
                end,
            },

            onEventFinish =
            {
                [1502] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
