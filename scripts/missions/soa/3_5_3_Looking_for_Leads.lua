-----------------------------------
-- Looking for Leads
-- Seekers of Adoulin M3-5-3
-----------------------------------
-- !addmission 12 61
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.LOOKING_FOR_LEADS)

mission.reward =
{
    keyItem     = xi.ki.TINTINNABULUM,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.DRIFTING_NORTHWEST },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(144),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            onTriggerAreaEnter =
            {
                [3] = function(player, triggerArea)
                    return mission:progressEvent(1517)
                end,
            },

            onEventFinish =
            {
                [1517] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
