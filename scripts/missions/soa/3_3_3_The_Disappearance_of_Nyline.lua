-----------------------------------
-- The Disappearance of Nyline
-- Seekers of Adoulin M3-3-3
-----------------------------------
-- !addmission 12 48
-- Levil          : !pos -87.204 3.350 12.655 256
-- Boarding House : !pos -41.693 -0.15 -38.29 257
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_DISAPPEARANCE_OF_NYLINE)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.SHARED_CONSCIOUSNESS },
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
            ['Door_Boarding_House'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Option') == 0 then
                        return mission:event(1512)
                    end
                end,
            },

            onEventFinish =
            {
                [1512] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 1)
                end,
            },
        },

        [xi.zone.FORET_DE_HENNETIEL] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    return mission:progressEvent(517)
                end,
            },

            onEventFinish =
            {
                [517] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
